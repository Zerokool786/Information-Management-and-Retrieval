-- Registers a customer and places their order.
-- A new customer is added with their address before the order is placed.
-- A customer who already exists is not duplicated; the order is placed against their existing record.

USE FarmFord;
GO

CREATE PROCEDURE [RCW].[sp_CustomerRegistration]

    @pCust_First_Name VARCHAR(50),
    @pCust_Last_Name VARCHAR(50),
    @pPhone VARCHAR(50),
    @pHouse_No VARCHAR(10),
    @pStreet NVARCHAR(20),
    @pFull_Address NVARCHAR(200),
    @pAddress_Type NVARCHAR(50),
    @pProduce_Name NVARCHAR(50),
    @pDelivery_Date DATE NULL

AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @Customer TABLE (
        Cust_First_Name VARCHAR(50),
        Cust_Last_Name VARCHAR(50),
        Phone VARCHAR(50),
        House_No VARCHAR(10),
        Street NVARCHAR(20),
        Full_Address NVARCHAR(200),
        Delivery_Date DATE,
        Address_Type_ID INT,
        Produce_ID INT
    )

    INSERT INTO @Customer
    VALUES (@pCust_First_Name,
            @pCust_Last_Name,
            @pPhone,
            @pHouse_No,
            @pStreet,
            @pFull_Address,
            @pDelivery_Date,
            (SELECT AddressType_ID FROM RCW.Address_Type WHERE [Type] = @pAddress_Type),
            (SELECT Produce_ID FROM RCW.Produce WHERE Produce_Name = @pProduce_Name))

    IF NOT EXISTS (SELECT 1 FROM @Customer T
                   JOIN [RCW].[Customer] C
                       ON C.Cust_First_Name = T.Cust_First_Name
                       AND C.Cust_Last_Name = T.Cust_Last_Name)

    BEGIN
        --------------------------------[RCW].[Customer]---------------------------------------------
        INSERT INTO [RCW].[Customer] ([Cust_First_Name], [Cust_Last_Name], [Phone], [Created_Date], [IsActive])
        SELECT
            @pCust_First_Name,
            @pCust_Last_Name,
            @pPhone,
            GETDATE() AS [Created_Date],
            1 AS [IsActive]
        FROM @Customer T
        LEFT JOIN [RCW].[Customer] C
            ON C.Cust_First_Name = T.Cust_First_Name
            AND C.Cust_Last_Name = T.Cust_Last_Name
        WHERE C.Cust_ID IS NULL

        --------------------------------[RCW].[Customer_Address]---------------------------------------------
        INSERT INTO [RCW].[Customer_Address] ([Cust_ID], [House_No], [Street], [Full_Address],
                                              [Address_Type_ID], [Created_Date], [IsActive])
        SELECT
            CC.Cust_ID,
            C.House_No,
            C.Street,
            C.Full_Address,
            C.Address_Type_ID,
            GETDATE() AS [Created_Date],
            1 AS [IsActive]
        FROM @Customer C
        JOIN [RCW].[Customer] CC
            ON CC.Cust_First_Name = C.Cust_First_Name
            AND CC.Cust_Last_Name = C.Cust_Last_Name
        LEFT JOIN [RCW].[Customer_Address] AD
            ON AD.Cust_ID = CC.Cust_ID
        WHERE AD.Address_ID IS NULL

        -----------------------------------[RCW].[Order]------------------------------------------------------
        INSERT INTO [RCW].[Order] ([Produce_ID], [Cust_ID], [Order_Date], [Delivery_Date],
                                   [Created_Date], [Order_Status], [IsActive])
        SELECT
            C.Produce_ID,
            CC.Cust_ID,
            GETDATE() AS [Order_Date],
            @pDelivery_Date,
            GETDATE() AS [Created_Date],
            'Pending' AS [Order_Status],
            1 AS [IsActive]
        FROM @Customer C
        JOIN [RCW].[Customer] CC
            ON CC.Cust_First_Name = C.Cust_First_Name
            AND CC.Cust_Last_Name = C.Cust_Last_Name
    END

    ELSE
    BEGIN
        -----------------------------------[RCW].[Order]------------------------------------------------------
        INSERT INTO [RCW].[Order] ([Produce_ID], [Cust_ID], [Order_Date], [Delivery_Date],
                                   [Created_Date], [Order_Status], [IsActive])
        SELECT
            C.Produce_ID,
            CC.Cust_ID,
            GETDATE() AS [Order_Date],
            @pDelivery_Date,
            GETDATE() AS [Created_Date],
            'Pending' AS [Order_Status],
            1 AS [IsActive]
        FROM @Customer C
        JOIN [RCW].[Customer] CC
            ON CC.Cust_First_Name = C.Cust_First_Name
            AND CC.Cust_Last_Name = C.Cust_Last_Name

        PRINT @pCust_First_Name + ', ' + @pCust_Last_Name + ' already exists in the system. Order is placed.'
    END

END
GO
