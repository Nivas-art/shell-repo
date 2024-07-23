#!bin/bash

source ./commann.sh
FUNCTION

dnf module disable nodejs -y &>>$LOGFILE
#VALIDATE $? "disable is"

dnf module enable nodejs:20 -y &>>$LOGFILE
#VALIDATE $? "enable 20 version is"

dnf install nodejs -y &>>$LOGFILE
#VALIDATE $? "insatll of nodejs"

id expense &>>$LOGFILE
if [ $? -ne 0 ]
then 
    useradd expense &>>$LOGFILE
    #VALIDATE $? "user added"
else
    echo -e "user alraedy exixts...$G SKIPPING $N"
fi

mkdir -p /app &>>$LOGFILE
#VALIDATE $? "created app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
#VALIDATE $? "downloaded"

cd /app
rm -rf /app/* &>>$LOGFILE
unzip /tmp/backend.zip &>>$LOGFILE
#VALIDATE $? "unzipped file"

npm install &>>$LOGFILE
VALIDATE $? "installed dependencies"

cp /home/ec2-user/shell-repo/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
#VALIDATE $? "copied db details"

systemctl daemon-reload &>>$LOGFILE
#VALIDATE $? "reloaded"

systemctl start backend &>>$LOGFILE
#VALIDATE $? "started"

systemctl enable backend &>>$LOGFILE
#VALIDATE $? "enabled"

dnf install mysql -y &>>$LOGFILE
#VALIDATE $? "installing client sql"

mysql -h 172.31.85.59 -uroot -p${sql_root_pwd} < /app/schema/backend.sql &>>$LOGFILE
#VALIDATE $? "schema added"

systemctl restart backend &>>$LOGFILE
#VALIDATE $? "restared"


