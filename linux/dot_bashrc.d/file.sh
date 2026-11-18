#
# ~/.bashrc.d/file.sh
#

share-add() {
  (( $# < 2 )) && return 1
  local grantee="$1"
  local dir="$2"
  setfacl -R -m "u:$grantee:rwX,d:u:$grantee:rwX" "$dir"
  setfacl -R -m "d:u:$USER:rwX" "$dir"
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
  find ~/* -type d -exec sh -c '
    getfacl -p "$2" | grep -q "^user:$1:"
  ' bash "$grantee" {} \; -print -prune
}
