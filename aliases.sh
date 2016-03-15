#my custom aliases

alias aliases='subl ~/aliases.sh &'
alias reload='source ~/aliases.sh'

#alias open=explorer
# start [dirname]
function open () {
    echo "opening path.";
    echo $1 | sed -e "s,/$,," -e 's/\//\\\\/g' | xargs start; # remove trailing slash; convert to windows path (if multiple subdirs, e.g. Desktop/anotherdir/)
}
alias open=open # otherwise there's another one that's built in!!

alias hosts='runas /user:administrator notepad.exe C:/Windows/System32/drivers/etc/hosts'

alias inbox='chrome http://inbox.google.com'
alias mail=inbox
alias dash='chrome https://docs.google.com/spreadsheets/d/1oS4AupTeLBFYDlgqt60mQFfVSNpW3CvRueKjJ9CLVA8/edit#gid=0'
alias tab='chrome https://docs.google.com/spreadsheets/d/1jnXcTJJWBTnVhZ8SeyjkdJ8P9ZxNMvWrlhzMsOsGxbg/edit#gid=0'
alias jenkins='chrome ci/'
alias ci=jenkins

#notes
export ndir="C:/Users/Maxim/Dropbox/docs"
alias v="lastv=$ndir/mznote_`date +%Y_%m_%dT%H_%M_%S`.md; subl $lastv &"
alias getv="echo $lastv"


# share via Dropbox
# pipe to this
function dropbox {
	read path;
	#echo $path;
    filename=`python ~/getfilename.py $path`;
    #echo $filename;
    cp $path /c/Users/Maxim/Dropbox/Public/;
    echo 'on clipboard:';
    echo https://dl.dropboxusercontent.com/u/UID/$filename;
    echo https://dl.dropboxusercontent.com/u/UID/$filename | clip
}
alias share=dropbox



# utils
# trim string
function trim {
	echo $1 | xargs;
}
alias trimstr=trim
alias strip=trim




alias pbcopy=gclip  # or clip
alias pbpaste=pclip




# excel
alias excel='"C:\Program Files\Microsoft Office\Office15\EXCEL.exe" &'
alias word='"C:\Program Files\Microsoft Office\Office15\WINWORD.exe"'
alias track='explorer "C:\Users\Maxim\Dropbox\Tracking.xlsx"'
alias gtrack='chrome https://docs.google.com/spreadsheets/d/17A2AWKTMWNfI91FFAi0KdbzvyN7k80hx3r1HubhjnA0/edit#gid=427144215'
alias phone='explorer "C:\Users\Maxim\Dropbox\Phone calls.xlsx"'



# tunnels
alias tunnel-quanta='ssh -ND 9999 NAME'

#jdk
alias activate-jdk='source ~/activate_jdk.sh'


# docker
alias docker_create='docker-machine create --driver virtualbox default'
#alias docker_start='boot2docker up && eval "$(boot2docker shellinit)"'
alias docker_start='docker-machine start default &&  eval $("c:\Users\maxim\bin\docker-machine.exe" env default --shell bash)'
#alias docker_load='eval "$(boot2docker shellinit)"'
alias docker_load='eval $("c:\Users\maxim\bin\docker-machine.exe" env default --shell bash)'
alias docker_test='docker run docker/whalesay cowsay hello'
alias docker_stop='docker-machine stop default'

# google calendar
alias caladd='gcalcli quick --calendar "Maxim Zaslavsky (Gmail)" --details url'
alias ics='gcalcli import --calendar "Maxim Zaslavsky (Gmail"' # import invite.ics files

#imagemagick
alias igconvert='"C:\Program Files (x86)\LyX 2.0\imagemagick\convert"'


# aws
alias s3url="~/shell/aws-tools/sign_s3_url.bash"
alias s3cmd="python ~/Desktop/utils/s3cmd-1.6.1/s3cmd"


# recursive file list
function filelist {
	find "$1" -exec ls -dl \{\} \;
}


alias della='ssh -X -A -t nobel ssh -A -t -X della' # della

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