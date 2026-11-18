#
# ~/.bashrc.d/git.sh
#

user-git-log() {
  local height="${1-10}"
  git log -n "$height" --color --format="%C(auto)%h %s %d"
}

user-git-rebase() {
  local height="$1"
  local target
  if [[ -n "$1" ]]; then
    target="HEAD~$1"
  else
    target="--root"
  fi
  git rebase -i "$target"
}

user-git-branch-remote-rename() {
  local cmd="${BASH_COMMAND%% *}"
  local old="$1"
  local new="$2"
  if [[ -z "$old" || -z "$new" ]]; then
    echo "usage: $cmd <old-name> <new-name>"
    return 1
  fi
  git push origin "origin/$old:refs/heads/$new" && \
  git push origin --delete "$old"
}

alias gn='git clone "$@"'
alias gs='git status'
alias ga='git add -A'
alias gc='git commit -m "$@"'
alias gp='git push "$@"'
alias gr='cd "$(git rev-parse --show-toplevel)"'
alias gl=user-git-log
# n:new, r:root

alias gad='git add'
alias grm='git rm'
alias gmv='git mv'
alias gcm='git commit --amend "$@"'
alias gpf='git push --force-with-lease "$@"'
alias gre=user-git-rebase

alias gb='git branch'
alias gbs='git switch "$@"'
alias gbc='git switch -c "$@"'
alias gbr='git branch -r'
alias gbrmv=user-git-branch-remote-rename
# bs:branch switch, bc:branch create, brmv:branch remote move
