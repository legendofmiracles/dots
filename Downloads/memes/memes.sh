#!/bin/bash
files=$(ls | xargs -n1)
while IFS= read -r file; do
  printf "  - { trigger: \":$(echo $file | cut -d "." -f1)\", image_path: \"$(pwd)/$file\" }\n"
done <<< "$files"
