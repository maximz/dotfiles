Install:

```
# convert path formats: windows <--> unix
# http://stackoverflow.com/questions/13701218/windows-path-to-posix-path-conversion-in-bash
# But they leave one issue: the drive name must become lowercased
# so we add a echo "/C:/ABcd" | sed 's/.*:/\L\0/g'
function tounixpath () {
    echo "/$1" | sed -e 's/\\/\//g' -e 's/.*:/\L\0/g' -e 's/://'
}
function towinpath () {
    echo "$1" | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/'
}


# notice that have to do // not / because of https://github.com/docker/toolbox/issues/80

# accepts parameter with box name
function newbox () {
    unixcertpath=$(tounixpath $DOCKER_CERT_PATH);
    docker run --name $1 -v $(pwd)://mounted -it -e BOX_NAME=$1 -e DOCKER_HOST=$DOCKER_HOST -e DOCKER_CERT_PATH=//dockercert -e DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY -e DOCKER_MACHINE_NAME=$DOCKER_MACHINE_NAME -v $unixcertpath://dockercert maximz/devbox:latest;
}

function newtempbox () {
    unixcertpath=$(tounixpath $DOCKER_CERT_PATH);
    docker run --rm -v $(pwd)://mounted -it -e BOX_NAME=temp -e DOCKER_HOST=$DOCKER_HOST -e DOCKER_CERT_PATH=//dockercert -e DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY -e DOCKER_MACHINE_NAME=$DOCKER_MACHINE_NAME -v $unixcertpath://dockercert maximz/devbox:latest;
    # -v //var/run/docker.sock://var/run/docker.sock doesn't work on windows so we do above instead, taken from $(docker-machine env default --shell bash)
    # note that mounted volumes need to be /c/..., not /C/...
    #
}
```