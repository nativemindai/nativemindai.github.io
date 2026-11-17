#!/bin/sh
# Privacy guard: blocks commits and pushes that could tie this repo to a real person.
#
# Install once, from the repo root (Git Bash on Windows works):
#     sh scripts/privacy-guard.sh install
#
# Then list your private words in .private-terms, one per line: names, emails,
# handles of other accounts, your website, school, employer, city. That file is
# git-ignored and never leaves your computer.
#
# What it checks:
#   pre-commit  commit name/email; staged files and lines vs .private-terms; photo metadata
#   commit-msg  the commit message vs .private-terms
#   pre-push    the pushing account (SSH key must belong to the repo owner) and the
#               author/committer of every commit being pushed
# Never bypass it with --no-verify.

ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "privacy-guard: not inside a git repo" >&2; exit 1; }
GITDIR=$(git rev-parse --git-dir)
TERMS="$ROOT/.private-terms"
TMP="$GITDIR/privacy-terms.tmp"

fail() {
    rm -f "$TMP"
    printf '\n  PRIVACY GUARD blocked this: %s\n\n' "$1" >&2
    exit 1
}

load_terms() {
    [ -f "$TERMS" ] || fail ".private-terms is missing. Run: sh scripts/privacy-guard.sh install"
    # Each term also matches its joined forms: "first last" -> first-last, first_last, first.last, firstlast
    grep -v '^[[:space:]]*#' "$TERMS" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' | grep -v '^$' |
        sed -e 'p' -e 's/[[:space:]][[:space:]]*/-/gp' -e 's/-/_/gp' -e 's/_/./gp' -e 's/\.//gp' | sort -u > "$TMP"
    [ -s "$TMP" ] || fail ".private-terms has no entries. Add your name, emails and personal handles, one per line."
}

has_term() { tr -s '[:blank:]' ' ' | grep -qiF -f "$TMP"; }   # reads stdin; extra spaces/tabs collapse to one

ok_email() {
    case "$1" in
        *@users.noreply.github.com|noreply@github.com) return 0 ;;
        *) return 1 ;;
    esac
}

check_identity() {
    email=$(git config user.email)
    name=$(git config user.name)
    ok_email "$email" || fail "commit email is not a GitHub noreply address. Run: git config user.email \"<id>+<username>@users.noreply.github.com\""
    [ -n "$name" ] || fail "no commit name set. Run: git config user.name \"nativemind\""
    printf '%s\n' "$name" | has_term && fail "the commit name (git config user.name) contains a private term."
    return 0
}

check_staged() {
    files=$(git diff --cached --name-only --diff-filter=ACMR)
    [ -n "$files" ] || return 0
    printf '%s\n' "$files" | has_term && fail "a staged file NAME contains a private term."
    printf '%s\n' "$files" | while IFS= read -r f; do
        if git diff --cached --no-color -U0 -- "$f" | grep '^+' | has_term; then
            printf '%s\n' "$f" > "$GITDIR/privacy-hit.tmp"; break
        fi
    done
    if [ -s "$GITDIR/privacy-hit.tmp" ]; then
        hit=$(cat "$GITDIR/privacy-hit.tmp"); rm -f "$GITDIR/privacy-hit.tmp"
        fail "$hit contains a private term. Remove it, then stage the file again."
    fi
    rm -f "$GITDIR/privacy-hit.tmp"
    printf '%s\n' "$files" | while IFS= read -r f; do
        case "$f" in
            *.[jJ][pP][gG]|*.[jJ][pP][eE][gG]|*.[hH][eE][iI][cC]|*.[hH][eE][iI][fF]|*.[tT][iI][fF]|*.[tT][iI][fF][fF]|*.[pP][nN][gG]|*.[wW][eE][bB][pP])
                if command -v exiftool >/dev/null 2>&1; then
                    meta=$(exiftool -q -q -s -GPS:all -Make -Model -SerialNumber -OwnerName -Artist -Author -Creator -Copyright -Software "$ROOT/$f" 2>/dev/null)
                    [ -z "$meta" ] || { echo "$f" > "$GITDIR/privacy-hit.tmp"; break; }
                else
                    # Without exiftool: photos (JPEG/HEIC/TIFF) are blocked; PNG/WebP pass only if they have no EXIF/XMP block.
                    case "$f" in
                        *.[pP][nN][gG]|*.[wW][eE][bB][pP])
                            if grep -aq -e 'eXIf' -e 'EXIF' -e 'XML:com.adobe.xmp' "$ROOT/$f"; then echo "$f" > "$GITDIR/privacy-hit.tmp"; break; fi ;;
                        *) echo "$f" > "$GITDIR/privacy-hit.tmp"; break ;;
                    esac
                fi ;;
        esac
    done
    if [ -s "$GITDIR/privacy-hit.tmp" ]; then
        hit=$(cat "$GITDIR/privacy-hit.tmp"); rm -f "$GITDIR/privacy-hit.tmp"
        fail "$hit may carry photo metadata (location, device, author). Re-save it without metadata (or as PNG), then stage it again."
    fi
    rm -f "$GITDIR/privacy-hit.tmp"
}

check_push_account() {
    # The push must go over SSH, and the SSH key must belong to the account that owns the repo.
    # This stops a push from another GitHub account signed in on this computer (VS Code, gh, Git
    # Credential Manager): a repo's public activity shows which account pushed.
    url=$1
    [ -n "$url" ] || fail "no remote URL given to the pre-push check. Re-run: sh scripts/privacy-guard.sh install"
    case "$url" in
        ssh://*) rest=${url#ssh://}; rest=${rest#*@}; host=${rest%%/*}; host=${host%%:*}; path=${rest#*/} ;;
        *@*:*)   rest=${url#*@}; host=${rest%%:*}; path=${rest#*:} ;;
        *) fail "this repo only pushes over SSH with the brand key, but the remote is '$url'. Run: git remote set-url origin git@github-nativemind:<owner>/<repo>.git" ;;
    esac
    owner=$(printf '%s' "${path%%/*}" | tr '[:upper:]' '[:lower:]')
    hello=$(ssh -T -o BatchMode=yes -o ConnectTimeout=15 "git@$host" 2>&1)
    login=$(printf '%s\n' "$hello" | sed -n 's/^Hi \([^!]*\)!.*/\1/p' | head -n 1 | tr '[:upper:]' '[:lower:]')
    [ -n "$login" ] || fail "couldn't confirm which GitHub account the SSH key for '$host' belongs to. Test it with: ssh -T git@$host"
    [ "$login" = "$owner" ] || fail "this push would be made by the GitHub account '$login', not '$owner' (the repo's owner). Use the brand SSH host (git@github-nativemind:...)."
    return 0
}

check_push() {
    zero=0000000000000000000000000000000000000000
    while read -r lref lsha rref rsha; do
        [ "$lsha" = "$zero" ] && continue
        if [ "$rsha" = "$zero" ]; then range="$lsha --not --remotes"; else range="$rsha..$lsha"; fi
        # shellcheck disable=SC2086
        git log --format='%ae%n%ce' $range | sort -u | while IFS= read -r e; do
            ok_email "$e" || { echo bad > "$GITDIR/privacy-hit.tmp"; break; }
        done
        [ -s "$GITDIR/privacy-hit.tmp" ] && { rm -f "$GITDIR/privacy-hit.tmp"; fail "a commit in this push has a non-noreply email. Fix the commit author before pushing."; }
        # shellcheck disable=SC2086
        git log --format='%an%n%cn%n%B' $range | has_term && fail "a commit in this push has a private term in its name or message."
    done
    return 0
}

install() {
    hooks="$GITDIR/hooks"
    mkdir -p "$hooks"
    printf '#!/bin/sh\nexec sh "$(git rev-parse --show-toplevel)/scripts/privacy-guard.sh" check\n' > "$hooks/pre-commit"
    printf '#!/bin/sh\nexec sh "$(git rev-parse --show-toplevel)/scripts/privacy-guard.sh" msg "$1"\n' > "$hooks/commit-msg"
    printf '#!/bin/sh\nexec sh "$(git rev-parse --show-toplevel)/scripts/privacy-guard.sh" push "$@"\n' > "$hooks/pre-push"
    chmod +x "$hooks/pre-commit" "$hooks/commit-msg" "$hooks/pre-push"
    if [ ! -f "$TERMS" ]; then
        cat > "$TERMS" <<'EOF'
# Private words the guard blocks (case-insensitive). One per line. Never committed.
# Add: first + last name, every email you use, personal social handles,
# personal website(s), school, employer, home city, other GitHub usernames.
EOF
    fi
    git check-ignore -q "$TERMS" || fail ".private-terms is NOT git-ignored. Add '.private-terms' to .gitignore first."
    echo "privacy-guard: hooks installed (pre-commit, commit-msg, pre-push)."
    echo "Next: open .private-terms and add your private words."
}

case "${1:-}" in
    install) install ;;
    check)   load_terms; check_identity; check_staged; rm -f "$TMP" ;;
    msg)     load_terms; grep -v '^#' "$2" | has_term && fail "the commit message contains a private term."; rm -f "$TMP" ;;
    push)    load_terms; check_push_account "${3:-}"; check_push; rm -f "$TMP" ;;
    *)       echo "usage: sh scripts/privacy-guard.sh install|check|msg <file>|push <remote> <url>" >&2; exit 2 ;;
esac
exit 0
