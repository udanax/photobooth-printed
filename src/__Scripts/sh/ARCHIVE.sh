#!/bin/bash

#apt-get install zip

folder_root="../.."
folder_archive="$folder_root/__ARCHIV"
folder_archive_backup="$folder_root/__ARCHIV-ZALOHA"
folder_new_archive_filename=$(date +%Y-%m-%d_%H-%M-%S)
folder_new_archive="$folder_archive/$folder_new_archive_filename"

folder_print="$folder_root/Prints"
folder_originals="$folder_root/Originals"
folder_green_screen="$folder_root/GreenScreen"
folder_animated="$folder_root/Animated"
folder_videos="$folder_root/Videos"

# Path to folder with printed photos
folder_printed="$folder_root/_Vytisknuto"

# Path to folder with non-printed photos
folder_printed_no="$folder_root/_Netisknuto"

mkdir -p $folder_archive

mkdir -p $folder_new_archive

mkdir -p $folder_archive_backup

if !([ ! -d "$folder_print" ]); then
  cp -r "$folder_print" "$folder_new_archive/Pripravene"
  rm -r "$folder_print"/*
  rm -r "$folder_print"/thumb/*
fi

if !([ ! -d "$folder_originals" ]); then
  cp -r "$folder_originals" "$folder_new_archive/Originaly"
  rm -r "$folder_originals"/*
fi

if !([ ! -d "$folder_green_screen" ]); then
  cp -r "$folder_green_screen" "$folder_new_archive/Zelene_pozadi"
  rm -r "$folder_green_screen"/*
fi

if !([ ! -d "$folder_printed" ]); then
  cp -r "$folder_printed" "$folder_new_archive/Vytisknuto"
  rm -r "$folder_printed"/*
fi

if !([ ! -d "$folder_printed_no" ]); then
  cp -r "$folder_printed_no" "$folder_new_archive/Netisknuto"
  rm -r "$folder_printed_no"/*
fi

if !([ ! -d "$folder_animated" ]); then
  cp -r "$folder_animated" "$folder_new_archive/Animace"
  rm -r "$folder_animated"/*
fi

if !([ ! -d "$folder_videos" ]); then
  cp -r "$folder_videos" "$folder_new_archive/Videa"
  rm -r "$folder_videos"/*
fi

if !([ ! -f "$folder_root/dslrbooth_log.txt" ]); then
  cp -r "$folder_root/dslrbooth_log.txt" "$folder_new_archive/dslrbooth_log.txt"
  rm -r "$folder_root/dslrbooth_log.txt"
fi

#zip -r "$folder_new_archive".zip $folder_new_archive
#mv $folder_new_archive "$folder_archive_backup/$folder_new_archive_filename"
cp -r $folder_new_archive "$folder_archive_backup/$folder_new_archive_filename"

echo "------------"
echo "-----OK-----"
echo "------------"