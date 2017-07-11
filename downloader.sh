#!/opt/bin/bash

########################################################################################
# 
# Copyright (c) 2009 MekDrop
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 
########################################################################################

################### BASE CONFIG ########################################################

apppath="/opt/bin"
ports="6810-6819"
dpath="~/downloads/"
mailto="your@email.com"
tmp="/tmp/downloads/"
log="/tmp/log/"
pcount=3

################ DONT CHANGE THIS IF YOU NOT SURE ######################################

cpath="`pwd`"
appname="CustomDownloader0.00.02"
cwp="$cpath/waiting"
ckp="$cpath/processing"

function ifNotExistsCreateDir() {
    if [ ! -d "$1" ]; then
	mkdir "$1"
    fi;
}

function getFileExtention() {
    echo "$1"|awk -F . '{print $NF}'
}

function sendCompletedMail() {
    echo "Completed file \"$1\"..." | sendmail $3
}

function sendProcessingMail() {
    echo "Downloading started \"$1\"." | sendmail $3
}

# getCommandLine $ckp $m $tmp $appname $apppath $ports $dpath
function run() {
    ext=`getFileExtention "$1/$2"`
    cd "$7"
    case "$ext" in
        torrent )
	    echo $($5/enhanced-ctorrent -v -E 1.2:1 -p $6 -C 4 -T -b "$3/$2.bf" -A "$4" "$1/$2" -S localhost:2780 )
        ;;
        url )
	    echo $(wget -i "$1/$2" -c)
        ;;
        html )
	    echo $(wget -i "$1/$2" -F -c)
        ;;
    esac;
}

# markAsProcessing $cwp $ckp $m
function markAsProcessing() {
    mv "$1/$3" "$2/$3"
}

function markAsCompleted() {
    cd "$1"
    mv "$1/$2" "../completed/"
}

function isRunning() {
    if ps -p $1 > /dev/null; then
	echo true;
    else
	echo false;
    fi;
}

function getFileName() {
    cd "$1"
    for m in *; do {
	[ ! -f "$m" ] && continue;
	echo "$m";
	break;
    }	
    done;
}

if pidof "$0"; then
    echo "Another process is running.";
    exit;
fi;

ifNotExistsCreateDir "$log"
ifNotExistsCreateDir "$tmp"
ifNotExistsCreateDir "$cwp"
ifNotExistsCreateDir "$ckp"
ifNotExistsCreateDir "$dpath"

i=0
while true; do
    echo "${nproc[i]}";
    if [ "${nproc[i]}" = "" ]; then
	m=`getFileName "$cwp"`;
	markAsProcessing $cwp $ckp $m
	echo "\"$m\" started"
        lproc[$i]="$log/$m.log"	
	iproc[$i]=`run "$ckp" "$m" "$tmp" "$appname" "$apppath" "$ports" "$dpath" "${lproc[i]}"`	
	nproc[$i]="$m"
	bg ${iproc[$i]}
    fi;
    if [ `isRunning "${nproc[i]}"` = 'false' ]; then
	    markAsCompleted "$ckp" "${nproc[i]}"
	    sendCompletedMail "${nproc[i]}" "${lproc[i]}" "$mailto"
	    rm -rf "${lproc[i]}"
	    lproc[$i]=""
    	    iproc[$i]=""
	    nproc[$i]=""
    fi;
    i=`expr $i + 1`
    if [ $i \> $pcount ]; then
	i=0
	sleep 10;
    fi;
    sleep 1;
done;
