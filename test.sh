#!/bin/bash

rootDir=$(cd `dirname $0`; pwd)
echo "rootDir:"$rootDir


###################[0] shell 參數
#####
#:$0 當前的腳本, $1~n 執行腳本跟的參數, $# 參數個數
#####
echo "當前腳本名稱:"$0
echo "參數@1:"$1
echo "參數@2:"$2

echo "參數個數:"$#

echo "傳遞給腳本的所有參數\$*:"$*
echo "傳遞給腳本的所有參數\$@:"$@

#$* 和 $@ 都表示传递给函数或脚本的所有参数，不被双引号(" ")包含时，都以"$1" "$2" … "$n" 的形式输出所有参数。
#但是当它们被双引号(" ")包含时，"$*" 会将所有的参数作为一个整体，以"$1 $2 … $n"的形式输出所有参数；
#"$@" 会将各个参数分开，以"$1" "$2" … "$n" 的形式输出所有参数。

# "" 包着的話,$*以整體輸出,$@還是分開單個輸出
for var in "$*"
do
echo "\$*:$var"
done

for var in "$@"
do
echo "\$@:$var"
done
# "" 包着的話,$*以整體輸出,$@還是分開單個輸出

# $? 上个命令的退出状态，或函数的返回值。
echo $?

echo "當前shell進程id:"$$


###################[0] shell 參數


###################[1] if else

# 數值判斷, eq, ne gt, ge, lt, le, 即:(equal == , not equal != , greater than > , greater equal >=, lower than <, lower equal <= )
echo "當前shell進程id:"$$
if [ $? -ne 1 ]; then
	echo "\$?:$?"
fi

int_value=10
if [ ${int_value} -gt 1 ]; then
	echo "int_value:${int_value}"
fi

if ((${int_value} > 1)); then
	echo "hahahhahhh"
fi
#字符串判斷, z, n, =, !=  (zero, not empty, =, !=)
str_value="devin"
str_value2=""
#字符串比較,要用 "" 包起來
if [ "$str_value2" != "$str_value" ]; then
	echo "兩個字符串不相等"
fi

if [ -z "$str_value2" ]; then
	echo "str_value2爲空"
fi

if [ ! -z "$str_value" ]; then
	echo "str_value不爲空"
fi

if [ -n "$str_value" ]; then
	echo "str_value not empty"
fi

if [ "$str_value" ]; then
	echo "再一次:str_value not empty "
fi

## 判斷存在文件,或者文件夾
fileName="hah.txt"
directory="hah"

#: -f 判斷存在普通文件, -d 判斷存在目錄即文件夾, -e判斷文件存在(文件夾,或者普通文件或者其他)
if [ -f "${rootDir}/${fileName}" ]; then
	echo "存在:${rootDir}/${fileName}"
fi

if [ -e "${rootDir}/${directory}" ]; then
	echo "存在:${rootDir}/${directory}"
fi

if [ -d "${rootDir}/${fileName}" ]; then
	echo "存在:${rootDir}/${fileName}"
fi

###復雜邏輯判斷 -a(and &&), -o(or ||), !(非)

receivedLen=25
totalLen=100

receivedMsg="devin received"
if (($receivedLen < $totalLen)) && [ -n "$receivedMsg" ]; then
	echo "success"
fi

#下面的 -a爲 and &&的意思
if [ $receivedLen -lt $totalLen -a ! -z "$receivedMsg" ]; then
	echo "再一次:success"
fi

####[11111111111]
if [ $receivedLen -lt $totalLen ]; then
	echo "小於"
elif [$receivedLen -gt $totalLen ]; then
	echo "大於"
else 
	echo "等於"
fi
####[11111111111]

###復雜邏輯判斷 -a(and &&), -o(or ||), !(非)

###################[1] if else


##条件变量替换: 對 shell腳本裏定於的變量進行改變
replace_value=$3
#${replace_value:? "replace_value is not defined"}

echo "replace_value-:"${replace_value:-devin}
echo "replace_value-:"${replace_value}

echo "replace_value=:"${replace_value:=devin}
echo "replace_value=:"${replace_value}

##条件变量替换: 對 shell腳本裏定於的變量進行改變






