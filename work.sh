#!/bin/bash

input_dir=$1
output_dir=$2

# work both with JPG and jpg
for input_file in $(find $input_dir -type f -iname "*.jpg" -o -iname "*.JPG"); do

    input_file_without_path=$(basename $input_file)
    input_file_without_extension=$(echo $input_file_without_path | sed 's/\.[^.]*$//')

    output_raw="$output_dir/$input_file_without_extension.raw"
    output_tif="$output_dir/$input_file_without_extension.tif"

    echo "input_file: $input_file"
    echo "output_raw: $output_raw"
    echo "output_tif: $output_tif"

    dji_irp \
        --action measure \
        --measurefmt float32 \
        --distance 25 \
        --humidity 77 \
        --emissivity 0.98 \
        --reflection 23 \
        --verbose 1 \
        --source $input_file \
        --output $output_raw

    raw2tiff \
        -w 640 \
        -l 512 \
        -d float \
        -c none \
        $output_raw $output_tif

    exiftool -overwrite_original -TagsFromFile "$input_file" -all:all $output_tif
done
