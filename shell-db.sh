#!bin/bash

echo "please enter a pwd"
read sql_root_pwd

source ./commann.sh
FUNCTION


dnf install mysql-server -y &>>$LOGFILE
#VALIDATE $? "install of mysql serever is"

systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "enable of mysql serever is"

systemctl start mysqld &>>$LOGFILE
#VALIDATE $? "start of mysql is"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "pwd of mysql is"

#mysql -h 54.159.226.223 -uroot -pExpenseApp@1 -e 'show databases;' &>>$LOGFILE
#if [ $? -ne 0 ]
#then 
 #   mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
    #VALIDATE $? "pwd of sql is"
#else
 #   echo -e "pwd already setapped....$G SKIPPING $N"
#fi 