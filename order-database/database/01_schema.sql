-- FarmFord order database: tables and keys
-- Microsoft SQL Server

IF DB_ID('FarmFord') IS NULL
    CREATE DATABASE FarmFord;
GO

USE FarmFord;
GO

CREATE SCHEMA [RCW];
GO

--------------------------------[RCW].[Address_Type]---------------------------------------------
CREATE TABLE [RCW].[Address_Type](
    [AddressType_ID] [int] IDENTITY(1,1) NOT NULL,
    [Type] [varchar](50) NOT NULL,
    [Created_Date] [datetime] NOT NULL,
    [Updated_Date] [datetime] NULL,
    [IsActive] [bit] NOT NULL,
    CONSTRAINT [PK_AddressType] PRIMARY KEY CLUSTERED ([AddressType_ID] ASC)
);
GO

--------------------------------[RCW].[Customer]---------------------------------------------
CREATE TABLE [RCW].[Customer](
    [Cust_ID] [int] IDENTITY(1,1) NOT NULL,
    [Cust_First_Name] [varchar](50) NOT NULL,
    [Cust_Last_Name] [nvarchar](50) NOT NULL,
    [Phone] [nvarchar](50) NOT NULL,
    [Created_Date] [datetime] NOT NULL,
    [Updated_Date] [datetime] NULL,
    [IsActive] [bit] NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([Cust_ID] ASC)
);
GO

--------------------------------[RCW].[Customer_Address]---------------------------------------------
CREATE TABLE [RCW].[Customer_Address](
    [Address_ID] [int] IDENTITY(1,1) NOT NULL,
    [Cust_ID] [int] NOT NULL,
    [House_No] [nvarchar](10) NOT NULL,
    [Street] [nvarchar](20) NOT NULL,
    [Full_Address] [nvarchar](200) NOT NULL,
    [Address_Type_ID] [int] NOT NULL,
    [Created_Date] [datetime] NOT NULL,
    [Updated_Date] [datetime] NULL,
    [IsActive] [bit] NOT NULL,
    CONSTRAINT [PK_Customer_Address] PRIMARY KEY CLUSTERED ([Address_ID] ASC)
);
GO

--------------------------------[RCW].[Role]---------------------------------------------
CREATE TABLE [RCW].[Role](
    [Role_ID] [int] NOT NULL,
    [Role_Name] [nvarchar](20) NOT NULL,
    [Created_Date] [datetime] NOT NULL,
    [Updated_Date] [datetime] NULL,
    [IsActive] [bit] NOT NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([Role_ID] ASC)
);
GO

--------------------------------[RCW].[Login]---------------------------------------------
CREATE TABLE [RCW].[Login](
    [Login_ID] [int] NOT NULL,
    [Login_Name] [nvarchar](20) NOT NULL,
    [Password] [nvarchar](50) NOT NULL,
    [Role_ID] [int] NOT NULL,
    [Expiry_Date] [datetime] NOT NULL,
    [Created_Date] [datetime] NOT NULL,
    [Updated_Date] [datetime] NULL,
    [IsActive] [bit] NOT NULL,
    CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED ([Login_ID] ASC)
);
GO

--------------------------------[RCW].[Produce]---------------------------------------------
-- Attention is switched on by a trigger when a produce item becomes unavailable
CREATE TABLE [RCW].[Produce](
    [Produce_ID] [int] NOT NULL,
    [Produce_Name] [varchar](100) NOT NULL,
    [Quantity] [int] NOT NULL,
    [Price] [float] NOT NULL,
    [Status] [varchar](20) NOT NULL,
    [Attention] [bit] NOT NULL CONSTRAINT [DF_Produce_Attention] DEFAULT (0),
    [Created_Date] [datetime] NOT NULL,
    [Updated_Date] [datetime] NULL,
    [IsActive] [bit] NOT NULL,
    CONSTRAINT [PK_Produce] PRIMARY KEY CLUSTERED ([Produce_ID] ASC)
);
GO

--------------------------------[RCW].[Order]---------------------------------------------
CREATE TABLE [RCW].[Order](
    [Order_ID] [int] IDENTITY(1,1) NOT NULL,
    [Produce_ID] [int] NOT NULL,
    [Cust_ID] [int] NOT NULL,
    [Order_Date] [datetime] NOT NULL,
    [Delivery_Date] [datetime] NOT NULL,
    [Order_Status] [varchar](10) NOT NULL,
    [Created_Date] [datetime] NOT NULL,
    [Updated_Date] [datetime] NULL,
    [Completed_By] [int] NULL,
    [IsActive] [bit] NOT NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([Order_ID] ASC)
);
GO

--------------------------------Foreign keys---------------------------------------------
ALTER TABLE [RCW].[Customer_Address] ADD CONSTRAINT [FK_CustomerAddress_AddressType]
    FOREIGN KEY ([Address_Type_ID]) REFERENCES [RCW].[Address_Type] ([AddressType_ID])
    ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE [RCW].[Customer_Address] ADD CONSTRAINT [FK_CustomerAddress_Customer]
    FOREIGN KEY ([Cust_ID]) REFERENCES [RCW].[Customer] ([Cust_ID])
    ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE [RCW].[Order] ADD CONSTRAINT [FK_Order_Customer]
    FOREIGN KEY ([Cust_ID]) REFERENCES [RCW].[Customer] ([Cust_ID])
    ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE [RCW].[Order] ADD CONSTRAINT [FK_Order_Produce]
    FOREIGN KEY ([Produce_ID]) REFERENCES [RCW].[Produce] ([Produce_ID])
    ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE [RCW].[Order] ADD CONSTRAINT [FK_Order_CompletedBy]
    FOREIGN KEY ([Completed_By]) REFERENCES [RCW].[Login] ([Login_ID]);
GO

ALTER TABLE [RCW].[Login] ADD CONSTRAINT [FK_Login_Role]
    FOREIGN KEY ([Role_ID]) REFERENCES [RCW].[Role] ([Role_ID]);
GO
