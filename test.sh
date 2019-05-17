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

echo "傳遞給腳本的所有參數\$*:"$*
echo "傳遞給腳本的所有參數\$@:"$@

#$* 和 $@ 都表示传递给函数或脚本的所有参数，不被双引号(" ")包含时，都以"$1" "$2" … "$n" 的形式输出所有参数。
#但是当它们被双引号(" ")包含时，"$*" 会将所有的参数作为一个整体，以"$1 $2 … $n"的形式输出所有参数；
#"$@" 会将各个参数分开，以"$1" "$2" … "$n" 的形式输出所有参数。

# "" 包着的話,$*以整體輸出,$@還是分開單個輸出
for var in "$*"
do
echo "以整體輸出:\$*:$var"
done

for var in "$@"
do
echo "還是分開單個輸出:\$@:$var"
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

#${value:?message} 若变量以赋值的话,正常替换.否则将消息message送到标准错误输出(若此替换出现在Shell程序中,那么该程序将终止运行) 
#${replace_value:? "replace_value is not defined"}

# ${value:-word} 当变量未定义或者值为空时,返回值为word的内容,否则返回变量的值. 
echo "replace_value-:"${replace_value:-devin}
echo "replace_value-:"${replace_value}

#${value:=word}  与前者类似,只是若变量未定义或者值为空时,在返回word的值的同时将word赋值给value
echo "replace_value=:"${replace_value:=devin}
echo "replace_value=:"${replace_value}

# ${value:+word} 若变量以赋值的话,其值才用word替换,否则不进行任何替换,不改變value的值
rep_value="ccc"
echo "rep_value+:"${rep_value:+lai}

#从指定位置开始截取 左邊開始計數:${string: start :length},从右边开始计数:${string: 0-start :length}
#@@@
url="https://www.baidu.com"
echo "url result:"${url:2:9}
echo "url result:"${url:0-2}

#从指定字符（子字符串）开始截取
#其中，string 表示要截取的字符，chars 是指定的字符（或者子字符串），*是通配符的一种，表示任意长度的字符串。*chars连起来使用的
#意思是：忽略左边的所有字符，直到遇见 chars（chars 不会被截取）。
#@@@  使用 # 号截取右边字符:${string#*chars}, example: echo ${url#*:},echo ${url#*p:},echo ${url#*ttp:}

echo "substr:url: ${url#*ps://}"
echo "substr:url: ${url#https://}"

#如果希望直到最后一个指定字符（子字符串）再匹配结束，那么可以使用##，具体格式为：${string##*chars}
echo "final: url: ${url##*.}"

# 使用 % 截取左边字符: ${string%chars*}
echo "final left str: url: ${url%/*}"
echo "final left str%%: url: ${url%%/*}"

#获取字符串长度:${#string_name}
echo "url字符串的長度爲:"${#url}

##条件变量替换: 對 shell腳本裏定於的變量進行改變


###[222222222222222222]
############shell 數組

#定於數組,各元素空格分開
#修改數組某個下標的元素;weeks[2]=10

weeks=(0 1 2 3 4 5 6)
echo "數組weeks的長度爲:${#weeks[@]}"
echo "數組weeks的長度爲:${#weeks[*]}"
echo "數組weeks各元素爲:${weeks[*]}" #或者${weeks[*]}

#連個或多個數組拼接
days=(2 5 90)
week_days=(${weeks[@]} ${days[@]})
echo "兩數組拼接後的結果爲:${week_days[@]}"

#刪除數組 unset arrary(這樣直接是刪除所有的), 或者unset array[index]
unset weeks[1]
echo "刪除weeks[1]後,結果爲:${weeks[@]}"

############shell 數組
###[222222222222222222]



#############
#@shell 中常用的一些數學運算,(())
aa=10
bb=15
cc=$((aa+bb))
echo "cc:"$cc

if ((aa>9 && bb==15));then
	echo "測試數學運算 (())成功"
fi

((ff=aa*bb,dd=bb-5,nn=bb/5))
echo "ff:${ff}"

index=1
let index++
echo "index:${index}"

echo "scale=2; 5/3" | bc
#@shell 中常用的一些數學運算,(())
#############

#for循環
for i in 0 1 2 3 4 5 6 7 8 9 
do
 echo -n $i
done

echo \

for file in $(ls . | grep sh)
do
	echo "filename:${file}"
done
#for循環
