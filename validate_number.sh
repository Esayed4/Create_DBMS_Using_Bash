#! /usr/bin/bash
validate_number() {
    local number="$1"
    
    # Check if empty
    if [[ -z "$number" ]]; then
        echo "Error: Number of columns cannot be empty!"
        return 1
    fi
    
    # Check if it's a positive integer
    if ! [[ "$number" =~ ^[1-9][0-9]*$ ]]; then
        echo "Error: Number of columns must be a positive integer (1, 2, 3, ...)!"
        return 1
    fi
}
