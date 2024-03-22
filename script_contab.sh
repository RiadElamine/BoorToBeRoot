#!/bin/bash

minute=`who | awk '{print $4}' | awk -F ':' '{print $1}' | awk 'NR == 1'`
s=`who | awk -F ':' '{print $2}' | awk 'NR == 1'`
second=`echo $minute $s | awk '{printf("%d", $1 % 10 * 60 + $2)}'`
sleep $second
