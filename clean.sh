#!/bin/bash

find ./ -name "*.o" > ./tmp1.list

list="./tmp1.list"
while IFS= read -r var
do 
  echo "rm $var"
  rm $var
done < "$list"

rm ./tmp1.list


find ./ -name "modules.order" > ./tmp2.list

list="./tmp2.list"
while IFS= read -r var
do 
  echo "rm $var"
  rm $var
done < "$list"

rm ./tmp2.list


find ./ -name "modules.builtin" > ./tmp3.list

list="./tmp3.list"
while IFS= read -r var
do 
  echo "rm $var"
  rm $var
done < "$list"

rm ./tmp3.list


