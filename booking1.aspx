<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="booking1.aspx.cs" Inherits="YourChef.booking1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .container {
            margin-top: 20px;
        }
        .btn-group-toggle .btn {
            margin-right: 5px;
        }
        .validation-error {
            color: red;
            font-size: 12px;
        }
        .btn-outline-secondary.active {
            background-color: #007bff; /* Change to your preferred color */
            color: white; /* Change to your preferred color */
            border-color: #007bff; /* Change to your preferred color */
        }
    </style>
    <script type="text/javascript">
        function toggleButton(input) {
            // Get the parent label of the input (checkbox or radio button)
            var label = input.parentElement;

            // Check if the input is a radio button
            if (input.type === "radio") {
                // Remove 'active' class from all radio button labels in the same group
                var radioGroup = document.querySelectorAll('input[name="' + input.name + '"]');
                radioGroup.forEach(function (radio) {
                    radio.parentElement.classList.remove("active");
                });

                // Add 'active' class to the selected radio button's label
                if (input.checked) {
                    label.classList.add("active");
                }
            } else if (input.type === "checkbox") {
                // Toggle 'active' class for checkboxes
                if (input.checked) {
                    label.classList.add("active");
                } else {
                    label.classList.remove("active");
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <h1><center>Book a Chef</center></h1>
        <div class="container">
            <!-- Occasion DropDown -->
            <div class="form-group">
                <label for="ddlOccasion">Select Occasion</label>
                <asp:DropDownList ID="ddlOccasion" runat="server" CssClass="form-control">
                    <asp:ListItem>Birthday Party</asp:ListItem>
                    <asp:ListItem>Wedding</asp:ListItem>
                    <asp:ListItem>Anniversary</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Date Input with Validation -->
            <div class="form-group">
                <label for="txtDate">Select Dates</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate"
                    ErrorMessage="Date is required." CssClass="validation-error" Display="Dynamic" />
                <asp:CompareValidator ID="cvDate" runat="server" ControlToValidate="txtDate"
                    Operator="DataTypeCheck" Type="Date" ErrorMessage="Please enter a valid date (dd/MM/yyyy)."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <!-- Meals Selection -->
            <div class="form-group">
                <label>Select Meals (Select Multiple)</label>
                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                    <label class="btn btn-outline-secondary" id="labelBreakfast">
                        <asp:CheckBox ID="CheckBoxBreakfast" runat="server" onclick="toggleButton(this)" /> Breakfast
                    </label>
                    <label class="btn btn-outline-secondary" id="labelLunch">
                        <asp:CheckBox ID="CheckBoxLunch" runat="server" onclick="toggleButton(this)" /> Lunch
                    </label>
                    <label class="btn btn-outline-secondary" id="labelEveningSnacks">
                        <asp:CheckBox ID="CheckBoxEveningSnacks" runat="server" onclick="toggleButton(this)" /> Evening Snacks
                    </label>
                    <label class="btn btn-outline-secondary" id="labelDinner">
                        <asp:CheckBox ID="CheckBoxDinner" runat="server" onclick="toggleButton(this)" /> Dinner
                    </label>
                </div>
            </div>

            <!-- Lunch Serving Time -->
            <div class="form-group">
                <label>Lunch Serving Time</label>
                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                    <label class="btn btn-outline-secondary" id="labelLunch1">
                        <asp:RadioButton ID="RadioButton1" runat="server" GroupName="lunchTime" onclick="toggleButton(this)" /> 10 am onwards
                    </label>
                    <label class="btn btn-outline-secondary" id="labelLunch2">
                        <asp:RadioButton ID="RadioButton2" runat="server" GroupName="lunchTime" onclick="toggleButton(this)" /> 11 am onwards
                    </label>
                    <label class="btn btn-outline-secondary" id="labelLunch3">
                        <asp:RadioButton ID="RadioButton3" runat="server" GroupName="lunchTime" onclick="toggleButton(this)" /> 12 pm onwards
                    </label>
                    <label class="btn btn-outline-secondary" id="labelLunch4">
                        <asp:RadioButton ID="RadioButton4" runat="server" GroupName="lunchTime" onclick="toggleButton(this)" /> 1 pm onwards
                    </label>
                    <label class="btn btn-outline-secondary" id="labelLunch5">
                        <asp:RadioButton ID="RadioButton5" runat="server" GroupName="lunchTime" onclick="toggleButton(this)" /> 2 pm onwards
                    </label>
                    <label class="btn btn-outline-secondary" id="labelLunch6">
                        <asp:RadioButton ID="RadioButton6" runat="server" GroupName="lunchTime" onclick="toggleButton(this)" /> 3 pm onwards
                    </label>
                    <label class="btn btn-outline-secondary" id="labelLunch7">
                        <asp:RadioButton ID="RadioButton7" runat="server" GroupName="lunchTime" onclick="toggleButton(this)" /> 4 pm onwards
                    </label>
                </div>
            </div>

            <!-- Gas Burners Selection -->
            <div class="form-group">
                <label>No. of Gas Burners in your kitchen</label>
                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                    <label class="btn btn-outline-secondary">
                        <asp:RadioButton ID="RadioButton8" runat="server" GroupName="burners" /> 1
                    </label>
                    <label class="btn btn-outline-secondary">
                        <asp:RadioButton ID="RadioButton9" runat="server" GroupName="burners" /> 2
                    </label>
                    <label class="btn btn-outline-secondary">
                        <asp:RadioButton ID="RadioButton10" runat="server" GroupName="burners" /> 3
                    </label>
                    <label class="btn btn-outline-secondary">
                        <asp:RadioButton ID="RadioButton11" runat="server" GroupName="burners" /> 4
                    </label>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </form>
</body>
</html>