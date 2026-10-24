-- Step 6: Create the INVENTORY table
-- This table stores information about inventory items.
-- The item_id is the primary key so each item has a unique identifier.

CREATE TABLE INVENTORY (
    item_id INT NOT NULL PRIMARY KEY,
    item_name VARCHAR(40) NOT NULL,
    category VARCHAR(30),
    quantity INT,
    unit_cost DECIMAL(7,2),
    received_on DATE
);

-- Check the table structure to verify the columns and primary key.
DESCRIBE INVENTORY;

-- Step 7: Insert three inventory records
-- Add three products with their categories, quantities, costs, and dates received.
INSERT INTO INVENTORY
    (item_id, item_name, category, quantity, unit_cost, received_on)
VALUES
    (1, 'Laser Mouse', 'Peripherals', 25, 18.50, '2026-02-10'),
    (2, 'Mechanical Keyboard', 'Peripherals', 12, 64.00, '2026-03-05'),
    (3, 'USB Hub', 'Accessories', 40, 22.75, '2026-04-18');

-- Display all inventory records to confirm the inserts were successful.
SELECT * FROM INVENTORY;

-- Step 8: Update the keyboard price
-- Display the current prices before making changes.
SELECT item_id, item_name, unit_cost
FROM INVENTORY;

-- Lower the keyboard price to 59.99 without changing other products.
UPDATE INVENTORY
SET unit_cost = 59.99
WHERE item_id = 2;

-- Display the prices again to verify only the keyboard price changed.
SELECT item_id, item_name, unit_cost
FROM INVENTORY;


-- Step 9: Create a view to calculate inventory value
-- Create a view that shows each product and its total inventory value.
-- Multiplying quantity by unit_cost calculates the value of each product.

CREATE VIEW INVENTORY_VALUE AS
SELECT
    item_name,
    quantity,
    unit_cost,
    quantity * unit_cost AS total_value
FROM INVENTORY;

-- Display the inventory values with the highest total value first.
SELECT *
FROM INVENTORY_VALUE
ORDER BY total_value DESC;


-- Step 10: Copy the inventory table and add a primary key
-- Create a new table containing all columns and records from INVENTORY.
CREATE TABLE INVENTORY_COPY AS
SELECT * FROM INVENTORY;

-- Check the copied table to see whether its primary key was transferred.
SHOW CREATE TABLE INVENTORY_COPY;

-- Add a primary key so each copied item has a unique identifier.
ALTER TABLE INVENTORY_COPY
ADD PRIMARY KEY (item_id);

-- Verify that item_id is now marked as the primary key.
DESCRIBE INVENTORY_COPY;

-- Test that duplicate item IDs are rejected by the primary key.
-- This INSERT is expected to fail with ERROR 1062.
-- INSERT INTO INVENTORY_COPY
-- (item_id, item_name, category, quantity, unit_cost, received_on)
-- VALUES (1, 'Duplicate Mouse', 'Peripherals', 5, 18.50, '2026-05-01');


-- Step 11: Create a database user and display accounts
-- Create a local stock clerk account with the temporary lab password.
CREATE USER 'stockclerk'@'localhost' IDENTIFIED BY 'Stock#2026';

-- Display all MySQL users and the hosts they can connect from.
SELECT user, host FROM mysql.user ORDER BY user;

