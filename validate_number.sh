#!/usr/bin/bash

validate_number() {

    local number="$1"

    # Empty check
    if [[ -z "$number" ]]; then
        zenity --error \
            --title="Invalid Number" \
            --text="Number of columns cannot be empty."
        return 1
    fi

    # Positive integer check
    if ! [[ "$number" =~ ^[1-9][0-9]*$ ]]; then
        zenity --error \
            --title="Invalid Number" \
            --text="Number of columns must be a positive integer (1, 2, 3, ...)."
        return 1
    fi

    return 0
}
