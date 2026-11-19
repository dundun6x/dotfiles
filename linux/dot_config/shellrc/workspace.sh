ws-jump() {
  local dir
  dir="$(fzf --walker="dir,hidden" --walker-root="$HOME" --query="$*")"
  [[ -n "$dir" ]] && cd "$dir"
}

ws-source() {
  [[ -f ./env.sh ]] && source ./env.sh
}

ws-load() {
  ws-jump "$1" || return 0
  ws-source && echo "Loaded 'env.sh'"
}
