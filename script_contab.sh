#!/bin/bash

minute=`who | awk 'NR == 1 {print $4}' | awk -F ':' '{print $1}'`
s=`who | awk -F ':' 'NR == 1 {print $2}'`
second=`echo $minute $s | awk '{printf("%d", $1 % 10 * 60 + $2)}'`
sleep $second
