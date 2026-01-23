#!/bin/bash

#
# Script clean nginx Docker logs.
#
# @author   Luis Felipe <lfelipe1501@gmail.com>
# @website  https://www.lfsystems.com.co
# @version  1.0

logPath="app/logs"

LOGs="$(ls $logPath)"
for lg in $LOGs
do
   cat /dev/null > $logPath/$lg
done
