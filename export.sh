#!/bin/bash

# Check if the user provided a string as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <string>"
    exit 1
fi

# Store the OpenSCAD script filename
scad_file="Extrude_Letter.scad"

# Create output directory and remove it if it exists
output_dir="./output"
if [ -d "$output_dir" ]; then
    echo "Removing existing output directory..."
    rm -rf "$output_dir"
fi

# Create the output directory again
mkdir -p "$output_dir"

# Loop through each character in the provided string
for (( i=0; i<${#1}; i++ )); do
    char="${1:$i:1}"

    # Define the output file as the character's name with .stl extension in the output directory
    output_file="${output_dir}/${char}.stl"

    # Call OpenSCAD for each character
    openscad -o "$output_file" -D char_to_cutout=\"${char}\" "$scad_file"

    echo "Generated $output_file"
done
