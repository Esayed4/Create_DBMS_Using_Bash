#!/usr/bin/bash

function validate_name() {

    local name="$1"

    # Format validation
    if [[ ! "$name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        zenity --error --title="Invalid Name" --text="Invalid name:\n
• Must not be empty
• Must start with a letter or underscore
• Can contain only letters, numbers, and underscores"
        return 1
    fi

    # Reserved words check
    local reserved_words="select insert update delete create drop alter table database"

    if [[ " $reserved_words " =~ " ${name,,} " ]]; then
        zenity --error --title="Reserved Word" \
        --text="Error: '$name' is a reserved SQL keyword."
        return 1
    fi

    return 0
}
