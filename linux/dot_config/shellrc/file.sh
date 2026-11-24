share-add() {
  (( $# < 2 )) && return 1
  local grantee="$1"
  local dir="$2"
  setfacl -R -m "u:${grantee}:rwX,d:u:${grantee}:rwX" "$dir"
  setfacl -R -m "d:u:${USER}:rwX" "$dir"
  # Note that 'grantee' owns any files it creates inside shared 'dir'
  # To unify file ownership afterwards, use 'sudo chown -R $USER <dir>'
}

share-remove() {
  (( $# < 2 )) && return 1
  local grantee="$1"
  local dir="$2"
  setfacl -R -x "u:$grantee,d:u:$grantee" "$dir"
  setfacl -R -x "d:u:$USER" "$dir"
}

share-list() {
  (( $# < 1 )) && return 1
  local grantee="$1"
  find "$HOME" -mindepth 1 -type d \
    -exec sh -c '
      getfacl -p "$2" 2>/dev/null | grep -q "^user:$1:"
    ' sh "$grantee" {} \; \
    -print -prune
}

_share() {
  case $CURRENT in
    2) _users ;;
    3) _directories ;;
  esac
}

if [[ -n "$ZSH_VERSION" ]]; then
  compdef _share share-add
  compdef _share share-remove
  compdef _share share-list
fi
