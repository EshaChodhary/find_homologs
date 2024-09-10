#!/bin/bash



# Input files
queryFile="$1"
subjectFile="$2"
outputFile="$3"

# Run tblastn and save results to a file
tblastn -query "$queryFile" -subject "$subjectFile" -outfmt "6 qseqid sseqid pident length" > blast_results.txt

# Filter results: Keep hits with >30% identity and >90% 
awk '$3 > 30 && $4 > 0.9 * length($1)' blast_results.txt > "$outputFile"

# Count and Print the number of matches
numMatches=$(wc -l < "$outputFile")
echo "Number of matches identified: $numMatches"



