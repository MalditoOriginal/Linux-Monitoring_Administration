#!/bin/bash

# Check if the script is run with exactly one parameter
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path_ending_with_/>"
    exit 1
fi

# Start the timer to measure script execution time
start_time=$(date +%s.%N)

# Function to calculate the size of a directory (including all nested folders)
get_directory_size() {
    du -sb "$1" | awk '{print $1}'
}

# Function to calculate the hash (MD5) of a file
get_file_hash() {
    md5sum "$1" | awk '{print $1}'
}

# Function to count the number of specific file types in a directory
count_file_types() {
    local extension="$1"
    find "$2" -type f -name "*.$extension" | wc -l
}

# Function to get the top N files with largest size in a directory
get_top_files_by_size() {
    local dir="$1"
    local num_files="$2"
    find "$dir" -type f -exec du -h {} + | sort -rhk 1 | head -n "$num_files"
}

# Function to get the top N executable files with largest size and their MD5 hash
get_top_executable_files() {
    local dir="$1"
    local num_files="$2"
    find "$dir" -type f -executable -exec du -h {} + | sort -rhk 1 | head -n "$num_files" |
        while read -r line; do
            file_path=$(echo "$line" | cut -f2-)
            file_size=$(echo "$line" | awk '{print $1}')
            file_hash=$(get_file_hash "$file_path")
            echo "$file_path, $file_size, $file_hash"
        done
}

# Main script logic
directory_path="$1"

# Check if the directory exists
if [ ! -d "$directory_path" ]; then
    echo "Error: Directory not found."
    exit 1
fi

# Total number of folders (including all nested ones)
total_folders=$(find "$directory_path" -type d | wc -l)

# Top 5 folders with largest size in descending order (path and size)
top_five_folders=$(get_top_files_by_size "$directory_path" 5)

# Total number of files
total_files=$(find "$directory_path" -type f | wc -l)

# Number of specific file types
conf_files=$(count_file_types "conf" "$directory_path")
text_files=$(count_file_types "txt" "$directory_path")
exe_files=$(count_file_types "exe" "$directory_path")
log_files=$(count_file_types "log" "$directory_path")
archive_files=$(count_file_types "zip" "$directory_path")  # Update this with actual archive extensions
symbolic_links=$(find "$directory_path" -type l | wc -l)

# Top 10 files with largest size in descending order (path, size, and type)
top_ten_files=$(get_top_files_by_size "$directory_path" 10)

# Top 10 executable files with largest size in descending order (path, size, and hash)
top_ten_executable_files=$(get_top_executable_files "$directory_path" 10)

# Calculate script execution time
end_time=$(date +%s.%N)
execution_time=$(echo "$end_time - $start_time" | bc -l)

# Output the information
echo "Total number of folders (including all nested ones) = $total_folders"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top_five_folders"
echo "Total number of files = $total_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_files"
echo "Text files = $text_files"
echo "Executable files = $exe_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $symbolic_links"
echo "TOP 10 files of maximum size arranged in descending order (path, size, and type):"
echo "$top_ten_files"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size, and MD5 hash of file):"
echo "$top_ten_executable_files"
echo "Script execution time (in seconds) = $execution_time"
