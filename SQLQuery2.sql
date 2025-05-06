-- Insert a new user (Chef)
INSERT INTO Users (FullName, Username, Email, Password, PhoneNumber, Role)
VALUES ('parth joshi', 'parth', 'parth@gmail.com', '123123', '9876543213', 'Chef');

-- Get the last inserted UserID
DECLARE @NewUserID INT = SCOPE_IDENTITY();

-- Insert corresponding chef details
INSERT INTO ChefDetails (UserID, Address, City, State, PINCode, CuisineSpecialty, Experience, AvailabilityStatus, ProfilePicture)
VALUES (@NewUserID, '101 Maple Street', 'nadiad', 'gujrat', '94101', 'Japanese, Korean', 7, 'Available', 'img/c5.jpg');
