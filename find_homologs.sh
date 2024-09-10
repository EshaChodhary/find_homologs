#!/bin/bash

# Ensure that  three arguments are passed
if [[ "$#" -ne 3 ]]; then
    echo "Usage: $0 <query_file> <subject_file> <output_file>"
    exit 1
fi

# Define input and output files
query_file="$1"
subject_file="$2"
output_file="$3"

# Temporary file to store BLAST results
temporary_file="blast_temp_output.txt"

# Run BLAST and format output for filtering
blastn -query "$query_file" -subject "$subject_file" -outfmt "6 qseqid sseqid pident length qlen slen" -out "$temporary_file"

# Filter perfect matches (100% identity and matching lengths) and save to the output file
awk '$3 == 100 && $4 == $5' "$temporary_file" > "$output_file"

# Count the number of perfect matches and display the result
match_count=$(wc -l < "$output_file")
echo "Perfect matches found: $match_count"

# Display the result specifying the input files
echo "Perfect matches found between $query_file and $subject_file: $match_count"

# Clean up the temporary file
rm "$temporary_file"

