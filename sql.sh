#!/bin/bash

if [ $# -lt 4 ]; then
	echo "less parameters, should be greater than 4"
	exit 1
fi

# ip and port
HOST_NAME=$1
PORT=3306

# user and password
USER_NAME=$2
PASSWORD=$3

#database
# db:measure
DB_NAME=$4

SHOW_TABLES="show tables"

INIT_SET="--default-character-set=utf8"

MYSQL="mysql -h${HOST_NAME} -u${USER_NAME} -p${PASSWORD} -D${DB_NAME} ${INIT_SET}"


#init connect mysql
$MYSQL -e "${SHOW_TABLES}"

if [ $? -ne 0 ]; then
	echo "connect mysql failed"
	exit 1
fi

#########################
#@@brief: execute sql cmd
#@@  from file
########################
CmdSqlFile=sqlcmd.conf
data=$(awk -F ':=:' '{print $2}' ${CmdSqlFile})

#$MYSQL -e "${sql}"


cmdArray=()

#[0]
IFS_OLD=$IFS
IFS=$'\n'
index=0
for cmd in $data
do
	echo "cmd:"$cmd
	cmdArray[index]=$cmd
	let index++
done
IFS=$IFS_OLD
#[0]


echo "sql cmd length:"${#cmdArray[@]}

#[1]
for((i=0;i<${#cmdArray[@]};i++))
do
	exeSql=${cmdArray[i]}
	echo "exeSql:${exeSql}"

	if [ ! -z "${exeSql}" ]; then
		echo "is not empty"
		$MYSQL -e "${exeSql}"
	
		if [ $? -ne 0 ]; then
			echo "do sql execute failed"
			exit 1
		fi
	
	fi
done
#[1]

echo "ret=$?"
