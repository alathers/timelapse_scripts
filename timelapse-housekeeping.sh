#!/bin/bash

# sort and clean my multi-day time lapse stuff into buckets of more reasonable size
TopLevel="/mnt/AnselAdams/TimeLapse/Paris/AveDItalie/"
cd ${TopLevel}
for j in $(ls -1); do
   cd $j
   for h in $(ls -1 | sed 's/-.*//g'); do
      if [[ ! -d $h ]]; then
         mkdir $h
      fi
   done
   for h in $(ls -1 ); do
      if [[ ! -d $h ]]; then
         dir=`echo $h | sed 's/-.*//g'`
         mv $h $dir/
      fi
   done
    cd ${TopLevel}
done
