#!/bin/bash

apt-get install dos2unix

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

folder_root=".."
folder_print="$folder_root/Prints"

# Path to folder with printed photos
folder_printed="$folder_root/Vytisknuto"

# Path to folder with non-printed photos
folder_printed_no="$folder_root/Netisknuto"

# Path to log file
log_path="$folder_root/dslrbooth_log.txt"

if [ ! -f "$log_path" ]; then
    echo "FATAL ERROR: Log file 'dslrbooth_log.txt' not found in specified dir!"
    exit
fi

if [ ! -f "$folder_print" ]; then
    echo "FATAL ERROR: Folder 'Prints' with original photos prepared for print not found!"
    exit
fi

mkdir -p $folder_printed
mkdir -p $folder_printed_no

targets=($(cat "$log_path" | dos2unix | grep -E -o -a "^.*] Printing .* of .*\.\.\.$" | sed -e "s/^.*Printing .* of //"  | sed -e "s/\.\.\.$//"))
length=${#targets[@]}

# Clear printed images first
rm "$folder_printed"/*.jpg

# Copy printed images to specified folder.
for ((i = 0; i != length; i++)); do
  if [ ! -f "$folder_print/${targets[i]}" ]; then
    echo "Image $i: '${targets[i]}' not found - skipped."
  else
    if [ ! -f "$folder_printed/${targets[i]}" ]; then
      cp "$folder_print/${targets[i]}" "$folder_printed/${targets[i]}"
      echo "Image $i: '${targets[i]}' copied."
    else
      echo "Image $i: '${targets[i]}' already copied."
    fi
  fi
done

# Clear non-printed images first
rm "$folder_printed_no"/*.jpg

# Copy non-printed images to another specified folder.    
for filepath in "$folder_print"/*.jpg; do
    filename=$(echo $filepath|sed -e "s/.*\///")   
    if containsElement "$filename" "${targets[@]}"; then
      if !([ ! -f "$folder_printed_no/$filename" ]); then
        rm "$folder_printed_no/$filename"
      fi
    else
        echo "Image '$filename' identified as non-printed."
        cp "$folder_print/$filename" "$folder_printed_no/$filename"
    fi
done