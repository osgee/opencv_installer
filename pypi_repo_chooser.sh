#!/bin/bash

aliyun="http://mirrors.aliyun.com/pypi/simple/"
ustc="https://pypi.mirrors.ustc.edu.cn/simple/"
douban="http://pypi.douban.com/simple/"
Python="https://pypi.python.org/simple/"
v2ex="http://pypi.v2ex.com/simple/"
cas="http://pypi.mirrors.opencas.cn/simple/"
tsinghua="https://pypi.tuna.tsinghua.edu.cn/simple/"

echo [1]$ustc
echo [2]$aliyun
echo [3]$douban
echo [4]$Python
echo [5]$v2ex
echo [6]$cas
echo [7]$tsinghua

echo ""

echo "Please Input the Index of Repository to use:(1-7) [1]"
read INDEX

CURRENT_PATH=$(pwd)


PIP_CONFIG_DIR=".pip"
PIP_CONFIG_FILE="pip.conf"

function build_structure {
	cd ~
	if [ ! -d $PIP_CONFIG_DIR ]; then
		mkdir .pip
	fi
	cd .pip
	if [ -e $PIP_CONFIG_FILE ]; then
		rm $PIP_CONFIG_FILE
	fi
}

if [ "$INDEX" == 1 ]; then
	build_structure
	echo "[global]" >> $PIP_CONFIG_FILE
	echo "index-url = "$ustc >> $PIP_CONFIG_FILE
elif [ "$INDEX" == 2 ]; then
	build_structure
	echo "[global]" >> $PIP_CONFIG_FILE
	echo "index-url = "$aliyun >> $PIP_CONFIG_FILE
elif [ "$INDEX" == 3 ]; then
	build_structure
	echo "[global]" >> $PIP_CONFIG_FILE
	echo "index-url = "$douban >> $PIP_CONFIG_FILE
elif [ "$INDEX" == 4 ]; then
	build_structure
	echo "[global]" >> $PIP_CONFIG_FILE
	echo "index-url = "$Python >> $PIP_CONFIG_FILE
elif [ "$INDEX" == 5 ]; then
	build_structure
	echo "[global]" >> $PIP_CONFIG_FILE
	echo "index-url = "$v2ex >> $PIP_CONFIG_FILE
elif [ "$INDEX" == 6 ]; then
	build_structure
	echo "[global]" >> $PIP_CONFIG_FILE
	echo "index-url = "$cas >> $PIP_CONFIG_FILE
elif [ "$INDEX" == 7 ]; then
	build_structure
	echo "[global]" >> $PIP_CONFIG_FILE
	echo "index-url = "$tsinghua >> $PIP_CONFIG_FILE
else
	echo "Using Default Repository (ustc)"
	build_structure
	echo "[global]" >> $PIP_CONFIG_FILE
	echo "index-url = "$ustc >> $PIP_CONFIG_FILE
fi

cd $CURRENT_PATH

