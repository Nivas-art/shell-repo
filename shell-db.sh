#!bin/bash

source ./commann.sh
FUNCTION

dnf install mysql-server -y &>>$LOGFILE
#VALIDATE $? "install of mysql serever is"

systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "enable of mysql serever is"

systemctll start mysqld &>>$LOGFILE
#VALIDATE $? "start of mysql is"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "pwd of mysql is"

mysql -h 18.207.1.187 -uroot -pExpenseApp@1 -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
    #VALIDATE $? "pwd of sql is"
else
    echo -e "pwd already setiped....$G SKIPPING $N"
fi 