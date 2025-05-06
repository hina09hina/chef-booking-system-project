<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cheffbookk.aspx.cs" Inherits="YourChef.cheffbookk" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chef Booking - Culinary Experience</title>

    <!-- Bootstrap CSS for Responsive Design -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- jQuery UI CSS for Datepicker -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Custom CSS for Awesome Design -->
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: 'Arial', sans-serif;
            color: #333;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 30px;
            margin-top: 50px;
            margin-bottom: 50px;
        }

        h1 {
            color: #d9534f;
            font-weight: bold;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }

        .chef-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .chef-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .chef-card img {
            height: 250px;
            object-fit: cover;
        }

        .chef-card .card-body {
            background-color: #fff;
            padding: 20px;
        }

        .chef-card .btn {
            background-color: #d9534f;
            border: none;
            transition: background-color 0.3s;
        }

        .chef-card .btn:hover {
            background-color: #c9302c;
        }

        .modal-content {
            border-radius: 10px;
        }

        .modal-header {
            background-color: #d9534f;
            color: white;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control:focus {
            border-color: #d9534f;
            box-shadow: 0 0 5px rgba(217, 83, 79, 0.5);
        }

        .btn-primary {
            background-color: #d9534f;
            border: none;
        }

        .btn-primary:hover {
            background-color: #c9302c;
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
            .chef-card img {
                height: 200px;
            }

            .container {
                margin-top: 20px;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1 class="text-center mb-5">Book Your Personal Chef</h1>
            <div class="row">
                <asp:Repeater ID="rptChefs" runat="server" OnItemDataBound="rptChefs_ItemDataBound">
                    <ItemTemplate>
                        <div class="col-md-4 col-sm-6">
                            <div class="card chef-card">
                                <asp:Image ID="imgProfile" runat="server" CssClass="card-img-top" ImageUrl='<%# Eval("ProfileImage") %>' AlternateText='<%# Eval("FullName") %>'/>
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("FullName") %></h5>
                                    <p class="card-text"><strong>Specialty:</strong> <%# Eval("CuisineSpecialty") %></p>
                                    <p class="card-text"><strong>Experience:</strong> <%# Eval("Experience") %> Years</p>
                                    <div class="rating-section">
                                        <div class="avg-rating">
                                            <strong>Average Rating:</strong> <%# Eval("AverageRating", "{0:F1}") %> / 5 
                                            (<asp:Label ID="lblRatingCount" runat="server" Text='<%# Eval("RatingCount") %>'></asp:Label> reviews)
                                            <span class="avg-stars"><%# GetAverageStars(Convert.ToDouble(Eval("AverageRating"))) %></span>
                                        </div>
                                        <asp:HiddenField ID="hfChefId" runat="server" Value='<%# Eval("ChefDetailID") %>' />
                                        <asp:HiddenField ID="hfUserRating" runat="server" Value='<%# Eval("UserRating") %>' />
                                        <span class="user-stars" data-chef-id='<%# Eval("ChefDetailID") %>'>
                                            <i class="fas fa-star" data-value="1" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                            <i class="fas fa-star" data-value="2" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                            <i class="fas fa-star" data-value="3" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                            <i class="fas fa-star" data-value="4" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                            <i class="fas fa-star" data-value="5" onclick="rateChef(this, <%# Eval("ChefDetailID") %>)"></i>
                                        </span>
                                    </div>
                                    <button type="button" class="btn btn-primary book-now" data-toggle="modal" data-target="#bookingModal" data-chefid='<%# Eval("ChefDetailID") %>'>Book Now</button>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>

    <!-- Booking Modal -->
    <div class="modal fade" id="bookingModal" tabindex="-1" role="dialog" aria-labelledby="bookingModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bookingModalLabel">Book a Chef</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="bookingForm">
                        <input type="hidden" id="SelectedChefId" name="SelectedChefId" />

                        <div class="form-group">
                            <label for="EventDate"><i class="fas fa-calendar-alt"></i> Date of Event</label>
                            <input type="text" class="form-control" id="EventDate" placeholder="Select date" required>
                        </div>

                        <div class="form-group">
                            <label for="EventTime"><i class="fas fa-clock"></i> Time of Event</label>
                            <input type="time" class="form-control" id="EventTime" required>
                        </div>

                        <div class="form-group">
                            <label for="Duration"><i class="fas fa-hourglass-half"></i> Duration (hours)</label>
                            <select class="form-control" id="Duration" required>
                                <option value="">Select duration</option>
                                <option value="1">1 hour</option>
                                <option value="2">2 hours</option>
                                <option value="3">3 hours</option>
                                <option value="4">4 hours</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="Location"><i class="fas fa-map-marker-alt"></i> Location</label>
                            <input type="text" class="form-control" id="Location" placeholder="Enter address" required>
                        </div>

                        <div class="form-group">
                            <label for="NumberOfPeople"><i class="fas fa-users"></i> Number of People</label>
                            <input type="number" class="form-control" id="NumberOfPeople" min="1" placeholder="Enter number" required>
                        </div>

                        <div class="form-group">
                            <label for="CuisineType"><i class="fas fa-utensils"></i> Type of Cuisine</label>
                            <select class="form-control" id="CuisineType" required>
                                <option value="">Select cuisine</option>
                                <option value="Italian">Italian</option>
                                <option value="French">French</option>
                                <option value="Asian">Asian</option>
                                <option value="American">American</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="SpecialRequests"><i class="fas fa-comment"></i> Special Requests</label>
                            <textarea class="form-control" id="SpecialRequests" rows="3" placeholder="Any dietary restrictions or preferences?"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="UserName"><i class="fas fa-user"></i> Your Name</label>
                            <input type="text" class="form-control" id="UserName" placeholder="Enter your name" required>
                        </div>

                        <div class="form-group">
                            <label for="UserEmail"><i class="fas fa-envelope"></i> Your Email</label>
                            <input type="email" class="form-control" id="UserEmail" placeholder="Enter your email" required>
                        </div>

                        <div class="form-group">
                            <label for="UserPhone"><i class="fas fa-phone"></i> Your Phone Number</label>
                            <input type="tel" class="form-control" id="UserPhone" placeholder="Enter your phone" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="submitBooking()">Submit Booking</button>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Custom JavaScript -->
    <script>
        $('#eventDate').on('change', function () {
            let selectedDate = $(this).val(); // Get selected date
            let formattedDate = new Date(selectedDate).toISOString().split('T')[0]; // Convert to YYYY-MM-DD
            $(this).val(formattedDate); // Set correct format in input field
        });

        $(document).ready(function () {
            // Initialize Datepicker
            $("#EventDate").datepicker({
                minDate: 0, // Disable past dates
                dateFormat: "mm/dd/yy"
            });

            // Set Selected Chef ID when "Book Now" is clicked
            $('.book-now').on('click', function () {
                var chefId = $(this).data('chefid');
                $('#SelectedChefId').val(chefId);
            });

            // Initialize stars based on user's current rating
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
            fetch('cheffbookk.aspx/SubmitRating', {
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
                        let hiddenField = document.querySelector('input[id*="hfUserRating"][id$="_' + chefId + '"]');
                        if (hiddenField) {
                            hiddenField.value = rating;
                        }
                        window.location.reload();
                    } else if (data.d.redirect) {
                        window.location.href = data.d.redirect;
                    } else {
                        alert('Error: ' + data.d.message);
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

        function submitBooking() {
            // Client-side validation
            var requiredFields = ['EventDate', 'EventTime', 'Duration', 'Location', 'NumberOfPeople', 'CuisineType', 'UserName', 'UserEmail', 'UserPhone'];
            var isValid = true;

            requiredFields.forEach(function (field) {
                if (!$(`#${field}`).val()) {
                    $(`#${field}`).addClass('is-invalid');
                    isValid = false;
                } else {
                    $(`#${field}`).removeClass('is-invalid');
                }
            });

            if (!isValid) {
                alert('Please fill in all required fields.');
                return;
            }

            // Prepare booking data
            var bookingData = {
                chefId: $('#SelectedChefId').val(),
                eventDate: $('#EventDate').val(),
                eventTime: $('#EventTime').val(),
                duration: parseInt($('#Duration').val()),
                location: $('#Location').val(),
                numberOfPeople: parseInt($('#NumberOfPeople').val()),
                cuisineType: $('#CuisineType').val(),
                specialRequests: $('#SpecialRequests').val(),
                userName: $('#UserName').val(),
                userEmail: $('#UserEmail').val(),
                userPhone: $('#UserPhone').val()
            };

            // Submit booking to server
            fetch('cheffbookk.aspx/SubmitBooking', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(bookingData)
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Server returned ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.d.success) {
                        alert('Booking submitted successfully!');
                        $('#bookingModal').modal('hide');
                        $('#bookingForm')[0].reset();
                    } else if (data.d.redirect) {
                        window.location.href = data.d.redirect;
                    } else {
                        alert('Error: ' + data.d.message);
                    }
                })
                .catch(error => {
                    console.error('Fetch error:', error);
                    alert('Failed to submit booking: ' + error.message);
                });
        }
    </script>
</body>
</html>