git-log-n() {
  local height="${1-10}"
  git log -n "$height" --color --format="%C(auto)%h %s %d" "$@"
}

git-rebase-n() {
  local height="$1"
  local target
  if [[ -n "$height" ]]; then
    target="HEAD~$height"
  else
    target="--root"
  fi
  git rebase -i "$target"
}

git-branch-remote-rename() {
  local old="$1"
  local new="$2"
  local cmd
  [ -n "$ZSH_VERSION" ] && cmd="$0" || cmd="${FUNCNAME[0]}"
  if [[ -z "$old" || -z "$new" ]]; then
    echo "usage: $cmd <old-name> <new-name>"
    return 1
  fi
  git push origin "origin/$old:refs/heads/$new" && \
  git push origin --delete "$old"
}

alias gs='git status'
alias gl='git-log-n'
alias gh='cd "$(git rev-parse --show-toplevel)"'

alias ga='git add -A'
alias gad='git add'
alias grm='git rm'
alias gmv='git mv'
alias gr='git restore'
alias grs='git restore --staged'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias grb='git rebase'
alias grbn='git-rebase-n'

alias gb='git branch'
alias gbs='git switch'     # bs for branch switch
alias gbc='git switch -c'  # bc for branch create
alias gbr='git branch -r'
alias gbrmv='git-branch-remote-rename'

alias gn='git clone'  # n for new
alias gf='git fetch'
alias gpl='git pull'
alias gps='git push'
alias gpf='git push --force-with-lease'
