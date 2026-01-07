#!/usr/bin/bash

function get_foreign_key() {

    local current_column_name="$1"
    local current_data_type="$2"
    local table_path="$3"

    while true; do

        # List available tables
        tables=$(ls "$table_path" 2>/dev/null | grep -v '^meta_')

        if [[ -z "$tables" ]]; then
            zenity --error --text="No tables available to reference."
            return 1
        fi

        # Select referenced table
        ref_table=$(echo "$tables" | zenity --list \
            --title="Select Referenced Table" \
            --column="Tables" \
            --height=300 \
            --width=300)

        if [[ -z "$ref_table" ]]; then
            zenity --info --text="Foreign key setup cancelled."
            return 1
        fi

        # Check metadata
        meta_file="$table_path/meta_$ref_table"
        if [[ ! -f "$meta_file" ]]; then
            zenity --error --text="Metadata for table '$ref_table' not found."
            continue
        fi

        # Get PK column
        pk_column=$(awk -F',' '$4~/PRIMARY KEY/{print $2; exit}' "$meta_file")

        if [[ -z "$pk_column" ]]; then
            zenity --error \
                --text="Table '$ref_table' has NO PRIMARY KEY."
            continue
        fi

        # Get PK data type
        pk_data_type=$(awk -F',' -v col="$pk_column" '$2==col{print $3}' "$meta_file")

        if [[ -z "$pk_data_type" ]]; then
            zenity --error \
                --text="Could not determine data type for PRIMARY KEY '$pk_column'."
            continue
        fi

        # Data type compatibility check
        if [[ "$current_data_type" != "$pk_data_type" ]]; then
            zenity --error --title="Data Type Mismatch" --text="
Foreign key data type mismatch!

Current column:
  $current_column_name ($current_data_type)

Referenced PRIMARY KEY:
  $pk_column ($pk_data_type)

Both must have the SAME data type."
            continue
        fi

        # Confirmation
        zenity --question --title="Confirm Foreign Key" --text="
Referenced table: $ref_table
PRIMARY KEY: $pk_column
Data type: $pk_data_type

Use this PRIMARY KEY as a foreign key?"

        if [[ $? -eq 0 ]]; then
            break
        fi
    done

    # ONLY output to STDOUT (for capture)
    echo "FOREIGN KEY REFERENCES $ref_table($pk_column)"
    return 0
}
