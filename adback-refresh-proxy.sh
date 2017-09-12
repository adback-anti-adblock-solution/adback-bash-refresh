#!/bin/bash

function help() {
    echo "Help tutorial"
}

while getopts ht:f: option
do
   case "${option}"
   in
       t) TOKEN=${OPTARG};;
       f) FILE=${OPTARG};;
       h) help
          exit;;
   esac
done

if [[ -z $TOKEN ]]; then
    help
    exit
fi

if [[ -z $FILE ]]; then
    echo "File not specified"
elif [ ! -f $FILE ]; then
    echo "Base file is missing"
    exit 1
fi

SCRIPTS=$(wget -qO- http://adback.dev/app_dev.php/api/end-point/me?_format=yml\&access_token=$TOKEN)

old_end_point=$(echo $SCRIPTS | tr " " "\n" | awk '/old_end_point/{getline; print}')
end_point=$(echo $SCRIPTS | tr " " "\n" | awk '/^end_point/{getline; print}')
next_end_point=$(echo $SCRIPTS | tr " " "\n" | awk '/next_end_point/{getline; print}')

cp $FILE $old_end_point
cp $FILE $end_point
cp $FILE $next_end_point
