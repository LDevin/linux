#!/bin/bash

rootDir=$(cd `dirname $0`; pwd)
echo "rootDir=$rootDir"

#读取配置文件
dockerConfig=docker.conf
if [ ! -f "$rootDir/$dockerConfig" ]; then
	echo "docker config file is not exist"
	exit
fi
source $dockerConfig
#读取配置文件

echo $image_name $container_name

#开启docker容器
containerId=`docker ps -q -f name=$container_name`
echo "runing container $containerId"

if [ $containerId ]; then
	echo "exist runing container"
else
	stopContainer=`docker ps -a -q -f name=$container_name`
	if [ $stopContainer ]; then
		docker start $stopContainer
	else
 		docker run -d -it --name=$container_name -v $host_dir:$container_dir $image_name
	fi
fi
#开启docker容器

cmdExe=$1
dataBackDir=$2
gender=$3
configBackDir=$4
cameraNum=$5

dataDir=$(cd "$dataBackDir"; pwd)
configDir=$(cd "$configBackDir"; pwd)
echo "configDir=$configDir"

container_dataDir=$(cd $dataDir; pwd | awk -F "/" '{print $NF}')
container_configDir=$(cd $configDir; pwd | awk -F "/" '{print $NF}')

echo "filedir=$dataDir"
echo "container_dataDir=$container_dataDir"
echo "container_configDir=$container_configDir"

#删除和docker挂载目录下同名的文件夹，then cp new dir
hostDataDir=$host_dir/$container_dataDir
echo $hostDataDir

if [ -d $hostDataDir ]; then
	echo "$hostDataDir dir is exist，removing this dir now"
	rm -rf $hostDataDir
fi
cp -rf $dataDir $hostDataDir

hostConfigDir=$host_dir/$container_configDir
if [ ! -d $hostConfigDir ]; then
	echo "$hostConfigDir dir is not exist，removing this dir now"
	cp -rf $configDir $hostConfigDir
	#rm -rf $hostConfigDir
fi
#删除和docker挂载目录下同名的文件夹，then cp new dir

#执行容器的命令
#docker exec ${docker_name} ${cmd} ${argums...}
cmd=/bin/sh
test_sh=/home/test.sh
container_sh=/app/bin/$cmdExe

#测试执行docker里的sh脚本
docker exec $container_name $cmd $test_sh lai devin

docker exec $container_name $cmd $container_sh $container_dir/$container_dataDir $gender $container_dir/$container_configDir $cameraNum


