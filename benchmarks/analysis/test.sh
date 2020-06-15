#!/bin/bash
for file in ./*rkt
do 
	filenamelen=${#file}-4
	filename=${file:0:$filenamelen}
	#echo $filename
	#touch "$filename.analysis"
	(/usr/bin/time -v racket "$filename.rkt") 2>&1 | grep -E "Maximum|wall" | sed 's/.* //'>"$filename".analysis
done
