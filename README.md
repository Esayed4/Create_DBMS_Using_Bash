# Bash DBMS Project (GUI Version)

A **Database Management System (DBMS)** implemented entirely in **Bash**, with a **Zenity-based GUI** for easier interaction.  
This project allows you to **create, update, delete, and query tables** with proper **validation** and **foreign key support**.

---

## Features

- Create databases and tables  
- Add columns with **data type** and **constraints**:
  - `PRIMARY KEY`  
  - `NOT NULL`  
  - `UNIQUE`  
  - `FOREIGN KEY` (referencing another table)  
- Insert data with **type validation** and constraint checks  
- Update and delete rows  
- Select all data or filter by **PRIMARY KEY**  
- Zenity-based GUI for user-friendly interaction  
- Input validation for table and column names  
- Multi-table support with metadata management  

---
## Demonstration: Handling Relationships Between Tables (PK & FK)

This project supports **foreign key relationships** between tables and enforces proper constraints.  
Here’s an example workflow with **two tables**:

---

#### Example Tables

1. **`departments` table** – Primary Table  
   - `dept_id` → `int` → **PRIMARY KEY**  
   - `dept_name` → `string` → NOT NULL  

2. **`employees` table** – Foreign Table  
   - `emp_id` → `int` → **PRIMARY KEY**  
   - `emp_name` → `string` → NOT NULL  
   - `dept_id` → `int` → **FOREIGN KEY REFERENCES departments(dept_id)**  

---

#### Behavior Overview

| Action                       | Behavior in the Project                               |
|-------------------------------|------------------------------------------------------|
| **Drop `departments` table**  | ❌ Prevented if there are referencing `employees` rows |
| **Update `dept_id` in departments** | 🔄 Cascade: Updates the corresponding `dept_id` in `employees` table |
| **delete `employees` by dept_id**   | ⚪ Set NULL: If the referenced department is deleted, the FK in employees becomes NULL |

---

 

### Notes

- Foreign key behaviors (DROP PREVENT, UPDATE CASCADE, SELECT/SET NULL) are enforced automatically by the scripts.  
- This ensures **referential integrity** between tables while maintaining flexibility for updates and deletions.  
- GUI prompts guide the user when an action violates FK constraints.



---

## Requirements

- **Bash** (tested on Git Bash / Linux shell)  
- **Zenity** installed for GUI pop-ups  

**Install Zenity on Windows (via Chocolatey):**

```bash
sudo apt-get install zenity
```

---

## How to Run the Project

1. Open your terminal in the project folder.

2. Make the main script executable:
```bash
chmod +x main
```


3. Run the GUI DBMS:
```bash
./main
```


4. Use the GUI prompts to perform operations:

      - Create tables
      - Insert data
      - Select data (all rows or by primary key)
      - Update or delete rows
    
      All data is stored as CSV files inside your database folder, with metadata files to track structure and constraints.
----

Project DBMS/
```
├─ main                        # Main script to run the GUI DBMS
├─ 5_create_table              # Script to create tables
├─ insert                      # Script to insert data into tables
├─ select                      # Script to select data from tables
├─ update_table                # Script to update existing rows
├─ delete_from_atable          # Script to delete rows
├─ drop_table                  # Script to drop tables
├─ list_tables                 # Script to list all tables
├─ ConnectDB                   # Script to connect to a database
├─ CreateDB                    # Script to create a new database
├─ DropDB                      # Script to drop a database
├─ ListDB                      # Script to list all databases
├─ foreign_key_validation.sh   # Helper script for foreign key validation
├─ get_and_validate_data_type  # Helper script for column datatype validation
├─ validate_name.sh            # Script to validate table/column names
├─ validate_number.sh          # Script to validate number of columns
```

----

## License

This project is open-source and free to use.
Feel free to modify and improve the code.

---

## Coming Features

The project is actively being improved. Future updates include:

- **JOIN support**:  
  Combine data from multiple tables using INNER JOIN, LEFT JOIN, etc.  
- **GROUP BY support**:  
  Aggregate data by a specific column with COUNT, SUM, AVG, etc.  
 
Stay tuned for updates!

---

## Contributors

 
- **Esayed Nabil**  
  - Github   : https://github.com/Esayed4/
  - Linkedin : https://www.linkedin.com/in/esayed-/
- **Ahmed Ali**  
  - Github   :
  - Linkedin :

