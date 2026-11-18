#
# ~/.zshrc.d/proxy.sh
#

proxy-set() {
  export http_proxy="http://$HOST_IP:7897"
  export https_proxy="http://$HOST_IP:7897"
  export all_proxy="socks5://$HOST_IP:7897"
}

proxy-unset() {
  unset http_proxy
  unset https_proxy
  unset all_proxy
}

proxy-test() {
  curl http://www.google.com \
    -o /dev/null \
    -x "$http_proxy" \
    --connect-timeout 3 &&
    echo Success || echo Fail
}
