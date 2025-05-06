CREATE TABLE [dbo].[State] (
    [StateID]    INT IDENTITY(1,1) PRIMARY KEY,
    [StateName]  NVARCHAR(100) NOT NULL,
    [CountryID]  INT NOT NULL,
    FOREIGN KEY ([CountryID]) REFERENCES [dbo].[Country] ([CountryID]) ON DELETE CASCADE
);

