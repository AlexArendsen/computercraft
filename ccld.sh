#!/bin/bash

# ccld -- Computercraft Source Linker, written by Alex Arendsen
# Combines many Lua scripts into one for easier transport into
# Minecraft

if [ -z "$2" ]; then
  echo "Usage: $0 <driver> <output>"
fi

echo "-- ccld: project linked $(date)" > "$2"

while IFS='' read -r line || [[ -n "$line" ]]; do
  tkns=($(tr '()"' ' ' <<< ${line}))
  if [[ "${tkns[0]}" == "dofile" ]]; then
    # TODO -- Let the user know if the file couldn't found,
    # Advise that spaces may not be included in file names for this script
    echo "-- =============================" >> "$2"
    echo "-- ccld: BEGIN ${tkns[1]}" >> "$2"
    echo "-- =============================" >> "$2"
    cat "${tkns[1]}" >> "$2"
    echo "-- =============================" >> "$2"
    echo "-- ccld: END ${tkns[1]}" >> "${2}"
    echo "-- =============================" >> "$2"
  else
    echo "${line}" >> "$2"
  fi
done < "$1"

