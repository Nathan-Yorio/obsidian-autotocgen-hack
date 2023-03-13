#!/bin/bash

# Check if an input and output pdf were specified
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <in> <out>"
  exit 1
fi

# Checking to see if pdf.tocgen is actually already installed
if ! command -v pdftocgen &> /dev/null
then
    echo "pdf.tocgen is not available for the current user."
    exit 1
fi

# Collect the input and output pdfs
in="$1"
out="$2"

# Set the recipe text as a variable
# Can be modified here to whatever the actual parameters
# are for a given document
recipe='[[heading]]
# Heading 1
level = 1
greedy = true
font.name = "Inter-ExtraBold"
font.size = 15.025714874267578

[[heading]]
# Heading 2
level = 1
greedy = true
font.name = "Inter-SemiBold"
font.size = 12.020570755004883

[[heading]]
# Heading 3
level = 1
greedy = true
font.name = "Inter-SemiBold"
font.size = 10.292613983154297

[[heading]]
# Heading 4
level = 1
greedy = true
font.name = "Inter-SemiBold"
font.size = 9.391071319580078

[[heading]]
# Heading 5
level = 1
greedy = true
font.name = "Inter-SemiBold"
font.size = 8.414400100708008'

# Write the recipe text to a file
echo "$recipe" > recipe.toml

# Run the command using the input variables
pdftocgen "$in" < recipe.toml | pdftocio -o "$out" "$in"

# Get rid of the recipe that is now filled with pdf stuff
# to prepare for the next run
rm recipe.toml
