-- Flags a produce item for attention as soon as its status changes to Unavailable

USE FarmFord;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE TRIGGER [RCW].[trg_OrderStatus_Attention]
    ON [RCW].[Produce]
    AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF ( UPDATE ([Status]) )
    BEGIN
        UPDATE P
        SET P.Attention = 1  -- Needs attention
        FROM [RCW].[Produce] P
        JOIN INSERTED I ON I.[Produce_ID] = P.[Produce_ID]
        WHERE I.[Status] = 'Unavailable';
    END
END
GO
