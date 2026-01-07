#! /usr/bin/bash
function validate_name(){
local name="$1"
    # Combined validation: non-empty + starts with letter/underscore + only allowed chars
    if [[ ! "$name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo "Error: name must:"
        echo "  - Not be empty"
        echo "  - Start with a letter or underscore"
        echo "  - Contain only letters, numbers, and underscores"
        return 1
    fi

    # Check for SQL reserved words (I just used some of the reserved keywords, not all of them)
    local reserved_words="select insert update delete create drop alter table database"
    if [[ " $reserved_words " =~ " ${name,,} " ]]; then
        echo "Error: '$name' is a reserved word"
        return 1
    fi

    return 0

}
