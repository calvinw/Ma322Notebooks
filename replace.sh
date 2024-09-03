#!/bin/bash

# Function to process a single file
process_file() {
    local file="$1"
    echo "Processing file: $file"
    
    # Use sed to replace the string and save changes in-place
    sed -i 's/# Solution/# __SOLUTION__/g' "$file"
    sed -i 's/# Regular Block/# __REGULAR_BLOCK__/g' "$file"
    
    echo "Completed processing: $file"
}

# Main script
echo "Starting to process files..."

# Loop through all files matching the pattern
for file in More*.qmd; do
    # Check if the file exists (in case no matches were found)
    if [ -f "$file" ]; then
        process_file "$file"
    fi
done

echo "All files have been processed."
