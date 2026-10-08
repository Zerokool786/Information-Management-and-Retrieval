# FarmFord Order Database

A SQL Server database for a farm that delivers produce to its customers. It stores customers, their addresses, produce, orders and admin logins, and uses a stored procedure, a view and a trigger to handle the day-to-day work.

## What it does

- **Normalized tables:** customer details and addresses are kept in separate tables, and address types are a lookup table, so nothing is stored twice. Every table is linked with foreign keys to keep the data consistent.
- **Customer registration:** the `sp_CustomerRegistration` stored procedure takes a customer's details and the produce they want. A new customer is added with their address before the order is placed. A returning customer is matched by name, so they aren't duplicated, and the new order goes against their existing record.
- **Read-only order view:** `vuORDERS` shows each order with the customer's name, address, order date, delivery date and status, so users can see orders without being able to change the tables.
- **Stock alert trigger:** when a produce item's status changes to Unavailable, a trigger switches on its Attention flag so staff know to deal with it.
- **Record history:** every table has columns for when a row was created and last updated, and whether it is still active.

## Tables

| Table | Holds |
|---|---|
| `Customer` | Name and phone number |
| `Customer_Address` | Addresses, linked to a customer and an address type |
| `Address_Type` | Address types, such as permanent or current |
| `Produce` | Items for sale, with quantity, price, status and the attention flag |
| `Order` | Orders, linked to a customer and a produce item, with dates and status |
| `Login` | Admin users who manage orders |
| `Role` | User roles |

## Running it

Run the scripts in the `database` folder in order, in SQL Server Management Studio or Azure Data Studio:

1. `01_schema.sql` creates the database, tables and keys.
2. `02_view_orders.sql` creates the order view.
3. `03_trigger_produce_attention.sql` creates the stock alert trigger.
4. `04_sp_customer_registration.sql` creates the registration procedure.
5. `05_sample_usage.sql` adds sample data and walks through the procedure, view and trigger.

## Tech

Microsoft SQL Server, T-SQL
