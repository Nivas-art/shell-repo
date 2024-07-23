#!bin/bash

set -e
FAILURE(){
    echo "failed at $1: $2"
}
trap 'FAILURE ${LINENO} "BASH_COMMAND"' ERR
 
USERID=$(id -u)
TIMESTAMP=$(date +%f-%h-%m-%s)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$TIMESTAMP-$SCRIPT_NAME.log
R="\e[31m"
G="\e[32m"
N="\e[0m"


FUNCTION(){
if [ $USERID -ne 0 ]
then
    echo "your not in roott user"
    exit 1
else
    echo "your in root userr"
fi
}

#VALIDATE(){
 #   if [ $1 -ne 0 ]
  #  then
   #     echo -e "$2....$R FAILURE $N"
    #else
     #   echo -e "$2....$G PASS $N"
    #fi
#}