#!/bin/bash

source ./common.sh
check_root

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$LOG_FILE
VALIDATE $? "Adding Rabbitmq repo"

dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "Installing RabbitMQ Server"
systemctl enable rabbitmq-server
VALIDATE $? "Enabling RabbitMQ Server"
systemctl start rabbitmq-server &>>$LOG_FILE
VALIDATE $? "Starting Rabbitmq Server"
rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
VALIDATE $? "Adding User and Setting permissions to Rabbitmq"

print_total_time