#!/bin/bash

export IFS=""
set -x
BASEDIR="$( cd "$(dirname "$0")" ; pwd -P )"
cd ${BASEDIR}
echo "#TTPLAYLIST">masterplaylist.m3u8

find * -maxdepth 0 -type d -print0 | while IFS= read -r -d $'\0' folder
do
  cd ${folder}
  echo "#EXTM3U">PLAYLIST.m3u8
  echo "#TTPLAYLIST_NAME:${folder}">>PLAYLIST.m3u8

  # Supported Filetyps:
  # https://en.discussions.tomtom.com/spark-and-spark-3-runner-2-and-runner-3-473/music-on-runner-3-watch-1015649
  find *.mp3 *.aac -maxdepth 0 -type f -print0 | while IFS= read -r -d $'\0' j
  do
    echo "#EXTINF:0,$j">>PLAYLIST.m3u8
    echo "$j">>PLAYLIST.m3u8
  done
  cd ${BASEDIR}
  echo "#NAME:${folder}">>masterplaylist.m3u8
  echo "${folder}/PLAYLIST.m3u8">>masterplaylist.m3u8
done

exit 0
