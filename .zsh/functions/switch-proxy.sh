# Set HTTP Proxy
# I use goagent in my local machine as proxy
#export http_proxy="127.0.0.1:8087"
#export RSYNC_PROXY="127.0.0.1:8087"
proxy_goagent="127.0.0.1:8087"
function switch_proxy {
    if [ "$http_proxy" = "" ]; then
        echo "Switch proxy to $proxy_goagent"
        export http_proxy=$proxy_goagent
        export https_proxy=$proxy_goagent
    else
        echo "Turn proxy off"
        export http_proxy=""
        export https_proxy=""
    fi
}
alias p="switch_proxy"
