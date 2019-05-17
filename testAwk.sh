#!/bin/bash

#測試 awk命令

#awk 处理机制 :awk 会逐行处理文本 , 支持在处理第一行之前做一些准备工作 , 以及在处理完最后一行做一些总结性质的工作 
#在命令格式上分别体现如下 :
#BEGIN{}: 读入第一行文本之前执行 , 一般用来初始化操作
#{}: 逐行处理,逐行读入文本执行相应的处理,是最常见的编辑指令快
#END{}: 处理完最后一行文本之后执行 , 一般用来输出处理结果


##########################################
#awk [-F|-f] 'BEGIN{}{command1; command2} END{}' file
#[-F|-f]   大参数，-F指定分隔符，-f调用脚本
#'  '          引用代码块
#//           匹配代码块，可以是字符串或正则表达式
#{}           命令代码块，包含一条或多条命令
#；          多条命令使用分号分隔


#$0:代表整行,$1~n:代表一行中的第幾個字段(默認是按空格分開的), NR:表示行號, 

#@@@@@@@@1

#[0]test      分隔符 正則
#		^     ^
hehe=$(awk -F ":" '/bash$/{print $1}' /etc/passwd)

for haha in $hehe
do
	echo $haha
done
#[0]test

echo "分割線"

###### /bash$/:以bash結尾
cmdFind=$(awk -F ":" 'BEGIN{N=0}/bash$/{N++; print $1 "\n"}END{print "N:"N}' /etc/passwd)
for cmd in $cmdFind
do
	echo $cmd
done
#echo $cmdFind
######

#####awk '/^ro/{print }' passwd    打印passwd里面以ro开头的行
cmdFind=$(awk -F ":" '/^ro/{print }' /etc/passwd)
echo "passwd里面以ro开头的行:"$cmdFind

cmdFind=$(cat /etc/passwd | awk -F ":" '/^ro/{print }')
echo "passwd里面以ro开头的行:"$cmdFind

cmdFind=$(cat /etc/passwd | awk -F ":" '/^[a-b]/||/bash$/{print }')
echo "打印/etc/passwd里面以a或b或c或d开头的行:"$cmdFind

#awk '/^[^a-d]/{print }' /etc/passwd  打印/etc/passwd里面不以a,b,c,d开头的行
cmdFind=$(cat /etc/passwd | awk -F ":" '/^[^a-p]/{print }')
echo "打印cmdFind:"$cmdFind


rootDir=$(cd `dirname $0`;pwd)
stuentFile=${rootDir}/stu.txt
echo "studentFile:"$stuentFile

cmdFind=$(cat ./stu.txt | awk '$7 ~/^n/{print $7}')
echo "打印cmdFind:"$cmdFind

#打印第6列不以22結尾的 第6行
cmdFind=$(cat ./stu.txt | awk '$6 !~/22$/{print $6}')
echo "打印cmdFind:"$cmdFind

#打印第一列以/h開頭的整行
cmdFind=$(cat ./stu.txt | awk '$1 ~/^\/h/{print NF":"NR":"$0}')
echo "打印cmdFind:"$cmdFind


#####vim 快捷鍵:命令模式下(dd:刪除光標所在整行, gg:跳到文首,G:跳到文尾, 0: 跳到行首,$:跳到行尾, e,E,b)

cmdFind=$(cat ./stu.txt | awk '{if (NR>3) {print $NF}}')
echo "打印cmdFind:"$cmdFind

#指定多個分隔符[]
cmdFind=$(awk -F '[:#]' '{print $1":"$2":"$3}' hehe.txt)
echo "打印cmdFind:"$cmdFind

