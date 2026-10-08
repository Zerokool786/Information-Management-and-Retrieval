-- Sample data and a walkthrough of the stored procedure, view and trigger

USE FarmFord;
GO

-- Lookup data
INSERT INTO [RCW].[Address_Type] ([Type], [Created_Date], [IsActive])
VALUES ('Permanent', GETDATE(), 1),
       ('Current', GETDATE(), 1);

INSERT INTO [RCW].[Produce] ([Produce_ID], [Produce_Name], [Quantity], [Price], [Status], [Created_Date], [IsActive])
VALUES (1, 'Eggs (half dozen)', 100, 1.50, 'Available', GETDATE(), 1),
       (2, 'Milk (1 litre)', 50, 0.95, 'Available', GETDATE(), 1);
GO

-- A new customer: adds the customer, their address and the order
EXEC [RCW].[sp_CustomerRegistration] 'Jane', 'Doe', '01234567890', '12', 'High Street',
     '12 High Street, Plymouth', 'Permanent', 'Eggs (half dozen)', '2022-08-20';

-- The same customer again: no duplicate customer, just a new order
EXEC [RCW].[sp_CustomerRegistration] 'Jane', 'Doe', '01234567890', '12', 'High Street',
     '12 High Street, Plymouth', 'Permanent', 'Milk (1 litre)', '2022-08-22';
GO

-- Orders through the read-only view
SELECT * FROM [dbo].[vuORDERS];

-- Mark a produce item as unavailable; the trigger flags it for attention
UPDATE [RCW].[Produce] SET [Status] = 'Unavailable' WHERE [Produce_ID] = 1;

SELECT [Produce_Name], [Status], [Attention] FROM [RCW].[Produce];
GO
