-- Read-only view of order details, so users can see orders without changing the tables

USE FarmFord;
GO

CREATE VIEW [dbo].[vuORDERS]
AS
SELECT
        O.Order_ID,
        C.Cust_Last_Name + ', ' + C.Cust_First_Name AS Customer_Name,
        AD.Full_Address,
        O.Order_Date,
        O.Delivery_Date,
        O.Order_Status

FROM RCW.[Order] O
JOIN RCW.Customer C ON C.Cust_ID = O.Cust_ID
JOIN RCW.Customer_Address AD ON AD.Cust_ID = C.Cust_ID
JOIN RCW.Produce P ON P.Produce_ID = O.Produce_ID

WHERE CAST(O.Order_Date AS DATE) <= CAST(GETDATE() AS DATE);
GO
