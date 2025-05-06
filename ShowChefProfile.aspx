<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowChefProfile.aspx.cs" Inherits="YourChef.ShowChefProfile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>All Chefs</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: url('https://images.unsplash.com/photo-1543352632-5a4b16e2e8c3') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        }
        .chef-count {
            text-align: center;
            font-size: 24px;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: bold;
        }
        .chef-card {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .chef-card:hover {
            transform: translateY(-5px);
        }
        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            margin-right: 25px;
        }
        .chef-info {
            flex-grow: 1;
        }
        .chef-info h2 {
            color: #2c3e50;
            font-size: 24px;
            margin: 0 0 10px;
        }
        .info {
            font-size: 15px;
            margin: 8px 0;
            color: #555;
        }
        .info i {
            color: #e74c3c;
            margin-right: 10px;
        }
        .btn-book {
            padding: 10px 20px;
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 15px;
            transition: background 0.3s;
        }
        .btn-book:hover {
            background: #c0392b;
        }
        .rating-section {
            margin-top: 15px;
        }
        .avg-rating {
            margin-bottom: 10px;
        }
        .avg-stars .fa-star {
            color: #f1c40f;
        }
        .avg-stars .fa-star-half-alt {
            color: #f1c40f;
        }
        .avg-stars .far.fa-star {
            color: #ddd;
        }
        .user-stars {
            font-size: 20px;
            cursor: pointer;
        }
        .user-stars .fa-star {
            color: #ddd;
        }
        .user-stars .fa-star.filled {
            color: #f1c40f;
        }
        @media (max-width: 768px) {
            .chef-card {
                flex-direction: column;
                text-align: center;
            }
            .profile-img {
                margin: 0 auto 20px;
            }
            .btn-book {
                margin-top: 15px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="chef-count">
                <asp:Label ID="lblChefCount" runat="server" Text="0 Chefs Available"></asp:Label>
            </div>
            <asp:Repeater ID="rptChefs" runat="server" OnItemDataBound="rptChefs_ItemDataBound">
                <ItemTemplate>
                    <div class="chef-card">
                        <asp:Image ID="imgProfile" runat="server" CssClass="profile-img" ImageUrl='<%# Eval("ProfileImage") %>' />
                        <div class="chef-info">
                            <h2><%# Eval("FullName") %></h2>
                            <div class="info"><i class="fas fa-phone"></i><%# Eval("PhoneNumber") %></div>
                            <div class="info"><i class="fas fa-city"></i><%# Eval("City") %>, <%# Eval("State") %></div>
                            <div class="info"><i class="fas fa-briefcase"></i><%# Eval("Experience") %> Years Experience</div>
                            <div class="info"><i class="fas fa-utensils"></i><%# Eval("CuisineSpecialty") %></div>
                            <div class="info"><i class="fas fa-calendar-check"></i><%# Eval("Availability") %></div>
                            <div class="rating-section">
                                <asp:HiddenField ID="hfChefId" runat="server" Value='<%# Eval("ChefDetailID") %>' />
                                <asp:HiddenField ID="hfUserRating" runat="server" Value='<%# Eval("UserRating") %>' />
                                <div class="avg-rating">
                                    Average Rating: <%# Eval("AverageRating", "{0:F1}") %> / 5 
                                    (<asp:Label ID="lblRatingCount" runat="server" Text='<%# Eval("RatingCount") %>'></asp:Label> reviews)
                                    <span class="avg-stars"><%# GetAverageStars(Convert.ToDouble(Eval("AverageRating"))) %></span>
                                </div>
                                <span class="user-stars" data-chef-id='<%# Eval("ChefDetailID") %>'>
                                    <i class="fas fa-star" data-value="1" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                    <i class="fas fa-star" data-value="2" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                    <i class="fas fa-star" data-value="3" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                    <i class="fas fa-star" data-value="4" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                    <i class="fas fa-star" data-value="5" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                </span>
                            </div>
                        </div>
                        <asp:Button ID="btnBook" runat="server" Text="Book Now" CssClass="btn-book" 
                            CommandArgument='<%# Eval("ChefDetailID") %>' OnClick="btnBook_Click" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.user-stars').forEach(starsContainer => {
                let chefId = starsContainer.getAttribute('data-chef-id');
                let hiddenField = document.querySelector('input[id*="hfUserRating"][id$="_' + chefId + '"]');
                let userRating = hiddenField ? parseInt(hiddenField.value) : 0;
                if (userRating && userRating > 0) {
                    let stars = starsContainer.children;
                    Array.from(stars).forEach((star, index) => {
                        if (index < userRating) {
                            star.classList.add('filled');
                        }
                    });
                }
            });
        });

        function rateChef(star, chefId) {
            let rating = parseInt(star.getAttribute('data-value'));
            let starsContainer = star.parentElement;
            let stars = starsContainer.children;

            // Highlight stars up to the clicked one
            Array.from(stars).forEach((s, index) => {
                if (index < rating) {
                    s.classList.add('filled');
                } else {
                    s.classList.remove('filled');
                }
            });

            // Submit rating to server
            fetch('ShowChefProfile.aspx/SubmitRating', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ chefId: chefId, rating: rating })
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Server returned ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.d.success) {
                        // Update hidden field with new rating
                        let hiddenField = document.querySelector('input[id*="hfUserRating"][id$="_' + chefId + '"]');
                        if (hiddenField) {
                            hiddenField.value = rating;
                        }
                        window.location.reload(); // Refresh to update average rating
                    } else if (data.d.redirect) {
                        window.location.href = data.d.redirect; // Redirect to Login.aspx
                    } else {
                        alert('Error: ' + data.d.message);
                        // Reset stars to previous state on error
                        let hiddenField = document.querySelector('input[id*="hfUserRating"][id$="_' + chefId + '"]');
                        let previousRating = hiddenField ? parseInt(hiddenField.value) : 0;
                        Array.from(stars).forEach((s, index) => {
                            if (previousRating && index < previousRating) {
                                s.classList.add('filled');
                            } else {
                                s.classList.remove('filled');
                            }
                        });
                    }
                })
                .catch(error => {
                    console.error('Fetch error:', error);
                    alert('Failed to submit rating: ' + error.message);
                    // Reset stars to previous state on fetch error
                    let hiddenField = document.querySelector('input[id*="hfUserRating"][id$="_' + chefId + '"]');
                    let previousRating = hiddenField ? parseInt(hiddenField.value) : 0;
                    Array.from(stars).forEach((s, index) => {
                        if (previousRating && index < previousRating) {
                            s.classList.add('filled');
                        } else {
                            s.classList.remove('filled');
                        }
                    });
                });
        }
    </script>
</body>
</html>