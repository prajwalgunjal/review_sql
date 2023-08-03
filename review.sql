Banking application: In a banking application, you could create a stored procedure that transfers funds between accounts. 
The stored procedure would take in the account numbers, validate the data, check the balance, and update the account balances in the database. 
You could also include additional logic to handle currency conversions, transaction fees, and other business rules.




CREATE TABLE Accounts (
    AccountNumber VARCHAR(20) PRIMARY KEY,
    Balance DECIMAL(10, 2) NOT NULL
);

CREATE TABLE TransactionHistory (
    TransactionID INT IDENTITY(1, 1) PRIMARY KEY,
    SourceAccountNumber VARCHAR(20),
    DestinationAccountNumber VARCHAR(20),
    TransferAmount DECIMAL(10, 2)
);



INSERT INTO Accounts VALUES ('10', 1000.00),
('1', 500.00),
('2', 2500.00),
('3', 800.00),
('4', 1200.00),
 ('5', 3000.00),
('6', 700.00),
('7', 1800.00),
('8', 4200.00),
('9', 900.00)










alter PROCEDURE TransferFunds
(
    @sourceAccountNumber VARCHAR(20),
    @destinationAccountNumber VARCHAR(20),
    @transferAmount DECIMAL(10, 2)
)
AS
BEGIN
    
    DECLARE @sourceBalance DECIMAL(10, 2)
    DECLARE @destinationBalance DECIMAL(10, 2)

    BEGIN TRANSACTION 

  
    IF NOT EXISTS (SELECT 1 FROM Accounts WHERE AccountNumber = @sourceAccountNumber)
    BEGIN
        PRINT ('Source account not found.')
        ROLLBACK 
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Accounts WHERE AccountNumber = @destinationAccountNumber)
    BEGIN
        PRINT ('Destination account not found.')
        ROLLBACK 
        RETURN
    END

    SELECT @sourceBalance = Balance FROM Accounts WHERE AccountNumber = @sourceAccountNumber
    SELECT @destinationBalance = Balance FROM Accounts WHERE AccountNumber = @destinationAccountNumber

    
    IF @sourceBalance < @transferAmount
    BEGIN
        PRINT 'Insufficient balance in the source account.'
        ROLLBACK -- Rollback the transaction if the source account has insufficient balance
        RETURN
    END

   
    INSERT INTO TransactionHistory (SourceAccountNumber, DestinationAccountNumber, TransferAmount)
    VALUES (@sourceAccountNumber, @destinationAccountNumber, @transferAmount);
    
   
    UPDATE Accounts SET Balance = Balance - @transferAmount
    WHERE AccountNumber = @sourceAccountNumber

    UPDATE Accounts SET Balance = Balance + @transferAmount
    WHERE AccountNumber = @destinationAccountNumber

    PRINT 'Transfer completed successfully.'

    COMMIT 
END


EXEC TransferFunds
    @sourceAccountNumber = '1',
    @destinationAccountNumber = '2',
    @transferAmount = 10.00;


select * from Accounts

	select * from TransactionHistory




-------------------------------------------------------------------------------------------------------------------------------------------------------------------




create table temp1(
ID uniqueidentifier primary key default newid(),
name varchar(100),
last_name varchar(100)
)



alter database scoped configuration set IDENTITY_CACHE = off
insert into temp1 values
('Prajwal','gunjal'),
('sukanya','naik'),
('sanjana','ms')

select * from temp1
create table new(
ID int identity(1,1) primary key,
name varchar(100),
last_name varchar(100)
)

create procedure abc
@firstname varchar(100),
@lastname varchar(100)
as
begin
begin transaction 
begin try 
	insert into new values(@firstname, @lastname);
	commit
end try 
begin catch
	rollback
end catch 
end 

exec abc 3,3



begin transaction
insert into new values (1,1)
rollback


select * from new