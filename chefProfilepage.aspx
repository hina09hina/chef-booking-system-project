<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="chefProfilepage.aspx.cs" Inherits="YourChef.chefProfilepage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chef Registration</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: url('https://images.unsplash.com/photo-1543352632-5a4b16e2e8c3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
            background-size: cover;
            color: #333;
        }
        .container {
            max-width: 700px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            margin-bottom: 10px;
        }
        .upload-icon {
            position: absolute;
            top: 110px;
            left: 50%;
            transform: translateX(-50%);
            background: #4CAF50;
            color: white;
            padding: 8px;
            border-radius: 50%;
            cursor: pointer;
        }
        h1 {
            text-align: center;
            color: #4CAF50;
            font-size: 28px;
            margin-bottom: 20px;
        }
        .section {
            margin-bottom: 30px;
        }
        h2 {
            color: #666;
            font-size: 20px;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 5px;
            margin-bottom: 15px;
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #444;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px 10px 10px 35px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
            background: #fff;
            transition: border-color 0.3s ease;
        }
        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #4CAF50;
            outline: none;
        }
        .form-group i {
            position: absolute;
            left: 10px;
            top: 38px;
            color: #888;
        }
        .form-group select[multiple], 
        .form-group asp:ListBox {
            height: 120px;
            padding: 10px;
        }
        .form-group button {
            padding: 12px 25px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .form-group button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .container {
                margin: 20px;
                padding: 20px;
            }
            .profile-img {
                width: 100px;
                height: 100px;
            }
            .form-group input,
            .form-group textarea,
            .form-group select {
                font-size: 13px;
            }
            .form-group button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="container">
            <div class="profile-header">
                <asp:Image ID="imgProfile" runat="server" CssClass="profile-img" ImageUrl="~/Images/default-chef.jpg" />
                <asp:FileUpload ID="fuProfilePicture" runat="server" CssClass="upload-icon" style="display: none;" onchange="previewImage(this);" />
                <label for="<%= fuProfilePicture.ClientID %>" class="upload-icon"><i class="fas fa-camera"></i></label>
            </div>
            <h1>Chef Registration</h1>

            <!-- Personal Details Section -->
            <div class="section">
                <h2>Personal Details</h2>
                <div class="form-group">
                    <asp:Label ID="lblFirstName" runat="server" Text="Full Name" AssociatedControlID="txtFirstName"></asp:Label>
                    <i class="fas fa-user"></i>
                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="Enter your first name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" 
                        ErrorMessage="First Name is required." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                
                <div class="form-group">
                    <asp:Label ID="lblEmail" runat="server" Text="Email" AssociatedControlID="txtEmail"></asp:Label>
                    <i class="fas fa-envelope"></i>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="example@example.com"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                        ErrorMessage="Email is required." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                        ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Invalid email format." 
                        CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblPhoneNumber" runat="server" Text="Phone Number" AssociatedControlID="txtPhoneNumber"></asp:Label>
                    <i class="fas fa-phone"></i>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" TextMode="Phone" placeholder="Enter your phone number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" 
                        ErrorMessage="Phone Number is required." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" 
                        ValidationExpression="\d{10}" ErrorMessage="Phone Number must be 10 digits." 
                        CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>

            <!-- Address Details Section -->
            <div class="section">
                <h2>Address Details</h2>
                <div class="form-group">
                    <asp:Label ID="lblAddress" runat="server" Text="Address" AssociatedControlID="txtAddress"></asp:Label>
                    <i class="fas fa-home"></i>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" placeholder="Enter your address"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblCity" runat="server" Text="City" AssociatedControlID="txtCity"></asp:Label>
                    <i class="fas fa-city"></i>
                    <asp:TextBox ID="txtCity" runat="server" placeholder="Enter your city"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" 
                        ErrorMessage="City is required." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblState" runat="server" Text="State" AssociatedControlID="txtState"></asp:Label>
                    <i class="fas fa-map"></i>
                    <asp:TextBox ID="txtState" runat="server" placeholder="Enter your state"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState" 
                        ErrorMessage="State is required." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblPINCode" runat="server" Text="PIN Code" AssociatedControlID="txtPINCode"></asp:Label>
                    <i class="fas fa-map-pin"></i>
                    <asp:TextBox ID="txtPINCode" runat="server" placeholder="Enter your PIN code"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPINCode" runat="server" ControlToValidate="txtPINCode" 
                        ErrorMessage="PIN Code is required." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPINCode" runat="server" ControlToValidate="txtPINCode" 
                        ValidationExpression="\d{6}" ErrorMessage="PIN Code must be 6 digits." 
                        CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>

            <!-- Professional Details Section -->
            <div class="section">
                <h2>Professional Details</h2>
                <div class="form-group">
                    <asp:Label ID="lblCuisineSpecialty" runat="server" Text="Cuisine Specialty (Hold Ctrl to select multiple)" AssociatedControlID="ddlCuisineSpecialty"></asp:Label>
                    <i class="fas fa-utensils"></i>
                    <asp:ListBox ID="ddlCuisineSpecialty" runat="server" SelectionMode="Multiple">
                        <asp:ListItem Text="Indian" Value="Indian"></asp:ListItem>
                        <asp:ListItem Text="Italian" Value="Italian"></asp:ListItem>
                        <asp:ListItem Text="Chinese" Value="Chinese"></asp:ListItem>
                        <asp:ListItem Text="Mexican" Value="Mexican"></asp:ListItem>
                        <asp:ListItem Text="French" Value="French"></asp:ListItem>
                        <asp:ListItem Text="Continental" Value="Continental"></asp:ListItem>
                    </asp:ListBox>
                    <asp:CustomValidator ID="cvCuisineSpecialty" runat="server" ClientValidationFunction="validateCuisineSpecialty"
                        ErrorMessage="Please select at least one cuisine specialty." CssClass="error" Display="Dynamic"></asp:CustomValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblExperience" runat="server" Text="Experience (years)" AssociatedControlID="txtExperience"></asp:Label>
                    <i class="fas fa-briefcase"></i>
                    <asp:TextBox ID="txtExperience" runat="server" TextMode="Number" placeholder="Enter your experience in years"></asp:TextBox>
                    <asp:CompareValidator ID="cvExperience" runat="server" ControlToValidate="txtExperience" 
                        Type="Integer" Operator="DataTypeCheck" ErrorMessage="Experience must be a number." 
                        CssClass="error" Display="Dynamic"></asp:CompareValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblAvailability" runat="server" Text="Availability Status" AssociatedControlID="ddlAvailability"></asp:Label>
                    <i class="fas fa-calendar-check"></i>
                    <asp:DropDownList ID="ddlAvailability" runat="server">
                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                        <asp:ListItem Text="Available" Value="Available"></asp:ListItem>
                        <asp:ListItem Text="Busy" Value="Busy"></asp:ListItem>
                        <asp:ListItem Text="On Leave" Value="On Leave"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvAvailability" runat="server" ControlToValidate="ddlAvailability" 
                        InitialValue="" ErrorMessage="Please select availability status." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Register" OnClick="btnSubmit_Click" ClientIDMode="Static" />
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function previewImage(input) {
            console.log('previewImage called');
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%= imgProfile.ClientID %>').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function validateCuisineSpecialty(source, args) {
            console.log('validateCuisineSpecialty called');
            var listBox = document.getElementById('<%= ddlCuisineSpecialty.ClientID %>');
            var selectedCount = 0;
            for (var i = 0; i < listBox.options.length; i++) {
                if (listBox.options[i].selected) {
                    selectedCount++;
                }
            }
            args.IsValid = selectedCount > 0;
            if (!args.IsValid) {
                console.log('Validation failed: Please select at least one cuisine specialty.');
            } else {
                console.log('Cuisine specialty validation passed');
            }
        }

        // Add form submission logging
        document.getElementById('form1').addEventListener('submit', function (e) {
            console.log('Form submission attempted');
            if (typeof (Page_ClientValidate) === 'function') {
                console.log('Page_ClientValidate function exists');
                Page_ClientValidate();
                if (!Page_IsValid) {
                    console.log('Client-side validation failed');
                    var validators = Page_Validators;
                    for (var i = 0; i < validators.length; i++) {
                        if (!validators[i].isvalid) {
                            console.log('Validation error: ' + validators[i].errormessage);
                        }
                    }
                    e.preventDefault(); // Prevent submission if validation fails
                } else {
                    console.log('Client-side validation passed, submitting form...');
                }
            } else {
                console.log('Page_ClientValidate function not found - client-side validation scripts might be missing');
                e.preventDefault();
            }
        });

        // Log when the button is clicked
        document.getElementById('btnSubmit').addEventListener('click', function () {
            console.log('Register button clicked');
        });
    </script>
</body>
</html>