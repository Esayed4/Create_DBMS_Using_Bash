#! /usr/bin/bash

function get_foreign_key() {
    
    table_path=$3

    # We need to know the current column's data type, we will get it from the main function
    local current_column_name="$1"
    local current_data_type="$2"
    
    while true; do

    # Wrap ALL interactive output in {} and redirect to STDERR

  {    
    # List available tables
    echo "Available tables:"
    ls $table_path | grep -v '^meta_' | cat -n

    # Get table name    
    read -p "Enter table name (or 'exit'): " ref_table
    if [[ "$ref_table" =~ ^[Ee][Xx][Ii][Tt]$ ]]; then
          echo "Foreign key setup cancelled."
          return 1  # Exit function immediately
    fi


    # Check if table exists
    if [ ! -f "$table_path"/"$ref_table" ]; then
        echo "Error: Table '$ref_table' does not exist!"
	read -p "Try another table? (y/n): " try_again
        if [[ ! "$try_again" =~ ^[Yy] ]]; then
                echo "Foreign key setup cancelled."
                return 1
        fi
        echo
        continue  # Go back to show table list
    fi

    # Get primary key column from metadata
    local pk_column=$(awk -F',' '$4 ~ /PRIMARY KEY/ {print $2}' "$table_path"/"meta_$ref_table" 2>/dev/null)

    if [ -z "$pk_column" ]; then
        
	echo "Error: Table '$ref_table' has NO PRIMARY KEY!"
	read -p "Try another table? (y/n): " try_again
            if [[ ! "$try_again" =~ ^[Yy] ]]; then
                echo "Foreign key setup cancelled."
                return 1
            fi
            echo
            continue
    fi

    # Get the primary key's data type from metadata
    local pk_data_type=$(awk -F',' -v col="$pk_column" '$2 == col {print $3}' "$table_path"/"meta_$ref_table" 2>/dev/null)
            
            
    if [ -z "$pk_data_type" ]; then
    	echo "Error: Could not find data type for column '$pk_column'"
        read -p "Try another table? (y/n): " try_again
        if [[ ! "$try_again" =~ ^[Yy] ]]; then
        	echo "Foreign key setup cancelled."
                return 1
        fi
        echo
        continue
    fi
    
    # Check data type compatibility
    if [ "$current_data_type" != "$pk_data_type" ]; then
    	echo "Data type mismatch!"
        echo "   Current column '$current_column_name' has data type: $current_data_type"
        echo "   But Primary key '$pk_column' of your choosen table has data type: $pk_data_type"
        echo "   Foreign key and referenced PK must have the SAME data type."

        read -p "Try another table? (y/n): " try_again
        if [[ ! "$try_again" =~ ^[Yy] ]]; then
          	echo "Foreign key setup cancelled."
                return 1
        fi
        echo
        continue
    fi

    echo "Table '$ref_table' has PRIMARY KEY column: '$pk_column' (type: $pk_data_type)"
    echo "Data type matches current column '$current_column_name' (type: $current_data_type)"

    read -p "Use the PRIMARY KEY of this table? (y/n): " confirm
   
    if [[ "$confirm" =~ ^[Yy] ]]; then
            # Exit the {} block before echoing to STDOUT
            break
    fi
      
    echo "Let's try another table..."
    echo

 } >&2  # Redirect ALL interactive output to STDERR


 	# This continues the loop if user said no to confirmation
        continue
 done
    
 # ONLY this line goes to STDOUT (for capturing in variable)
 echo "FOREIGN KEY REFERENCES $ref_table($pk_column)"
 return 0

}
