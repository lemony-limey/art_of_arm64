#!/usr/bin/env bash

# set -euo

fileName=""
compileOnly=" "
pie="-no-pie"
cFile="c.cpp"
lib=" "

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  -c)
    compileOnly='-c'
    shift
    ;;

  -pie)
    pie='-pie'
    shift
    ;;

  -math)
    math='-lm'
    shift
    ;;

  *)
    fileName="$1"
    shift
    ;;
  esac
done

# If -c option was provided, only assemble the .S file and
# produce a .o output file.
#
# If -c not specified, compile both c.cpp and the .S file and
# produce an executable:

if [ "$compileOnly" = '-c' ]; then
  objectFile="-o $fileName".o
  cFile=" "
else
  objectFile="-o $fileName"
fi

# If the executable already exists, delete it:
if test -e "$fileName"; then
  rm "$fileName"
fi

# If the object file already exists, delete it:
if test -e "$fileName".o; then
  rm "$fileName".o
fi

unamestr=$(uname)
if [ "$unamestr" = 'Darwin' ]; then
  g++ -D isMacOS=1 "$compileOnly" "$objectFile" "$cFile" "$fileName.S" -lSystem "$math"
fi
