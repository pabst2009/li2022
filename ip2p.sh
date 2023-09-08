#!/bin/sh

if [ -z "$1" ]; then
  echo "usage:"
  echo "$0 input.ipynb"
  exit 1
fi

cat $1 | jq -j '.cells  | map( select(.cell_type == "code") | .source + ["\n\n"] )  | .[][]'   
