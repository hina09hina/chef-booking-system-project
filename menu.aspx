<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menu.aspx.cs" Inherits="YourChef.menu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Responsive Multi-Row Navigation Bar</title>
    <link rel="stylesheet" href="css/menu.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    
</head>
<body>
    <form id="form1" runat="server">
        
    <nav class="navbar">
        <div class="navbar-left">
          <i class="fas fa-utensils logo"></i>
          <h1 class="title">Your Chef</h1>
        </div>
        <div class="navbar-center">
          <a href="#" class="nav-link">Book Now</a>
          <a href="#" class="nav-link">Register as Partner</a>
          <div class="search-container">
            <input type="text" class="search-bar1" placeholder="Search...">
            <i class="fas fa-search search-icon1"></i>
          </div>
        </div>
        <div class="navbar-right">
          <a href="signup.aspx" class="nav-link">Sign Up</a>
          <a href="index.aspx" class="nav-link">Home</a>
          <i class="fas fa-user-circle profile-icon">"  "</i>
        </div>
      </nav>
      <br/><br/><br/><br/>
    <header class="menu-header">
        <h1 class="menu-title">Menu</h1>
        <p class="menu-subtitle">Your Chef offers 500+ dishes across 15+ worldwide cuisines</p>
    </header>
    <nav class="navigation-bar">
        <!-- First Row -->
        <div class="nav-row">
            <div class="dropdown">
                <select id="all-dishes" class="dropdown-select">
                    <option value="all">All Dishes</option>
                    <option value="north-indian">North Indian</option>
                    <option value="south-indian">South Indian</option>
                </select>
            </div>
            <div class="search-bar">
                <input type="text" id="search" placeholder="Search Dish">
                <button class="search-icon">🔍</button>
            </div>
        </div>

        <!-- Second Row -->
        <div class="nav-row">
            <a href="#" id="select-cuisines-btn" class="link-btn">Select Cuisines</a>
            <div class="veg-nonveg-container">
                <label class="veg-label">
                    <input type="checkbox" id="veg">
                    <span class="veg-icon">🥦</span>
                </label>
                <label class="nonveg-label">
                    <input type="checkbox" id="nonveg">
                    <span class="nonveg-icon">🍗</span>
                </label>
            </div>
        </div>

        <!-- Third Row -->
        <div id="selected-cuisines-container" class="hidden">
            <select id="cuisine-select" class="multi-select" multiple>
    <option value="North Indian">North Indian</option>
    <option value="Chinese">Chinese</option>
    <option value="Italian">Italian</option>
    <option value="Mexican">Mexican</option>
    <option value="Thai">Thai</option>
</select>

            <div id="selected-cuisines-box" class="selected-cuisines-box"></div>
        </div>
    </nav>
    <br/>
    <h1 class="menu-title">North Indian</h1>   
    <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
        <br/>
        <h1 class="menu-title">Ghar ka Khaana</h1>   
        <br/>
            <main class="menu-container">
                <div class="menu-item">
                    <img src="img/m1.jpg" alt="Hariyali Kebab">
                    <div class="item-info">
                        <p>Hariyali Kebab</p>
                    </div>
                </div>
                <div class="menu-item">
                    <img src="img/m2.jpg" alt="Dahi ke Kebab">
                    <div class="item-info">
                        <p>Dahi ke Kebab</p>
                    </div>
                </div>
                <div class="menu-item">
                    <img src="img/m3.jpg" alt="Dahi ke Sholey">
                    <div class="item-info">
                        <p>Dahi ke Sholey</p>
                    </div>
                </div>
                <div class="menu-item">
                    <img src="img/m4.jpg" alt="Chilli Chicken">
                    <div class="item-info">
                        <p>Chilli Chicken</p>
                    </div>
                </div>
                <div class="menu-item">
                    <img src="img/m1.jpg" alt="Hariyali Kebab">
                    <div class="item-info">
                        <p>Hariyali Kebab</p>
                    </div>
                </div>
                <div class="menu-item">
                    <img src="img/m2.jpg" alt="Dahi ke Kebab">
                    <div class="item-info">
                        <p>Dahi ke Kebab</p>
                    </div>
                </div>
                <div class="menu-item">
                    <img src="img/m3.jpg" alt="Dahi ke Sholey">
                    <div class="item-info">
                        <p>Dahi ke Sholey</p>
                    </div>
                </div>s
                <!-- Add more items following the same structure -->
            </main>
        <br/>
    <h1 class="menu-title">Mexican</h1>   
    <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
        <br/>
    <h1 class="menu-title">Chinese</h1>   
    <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
        <br/>
        <h1 class="menu-title">Breakfast</h1>   
        <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
        <br/>
        <h1 class="menu-title">Italian</h1>   
        <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
        <br/>
        <h1 class="menu-title">South Indian</h1>   
        <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <!-- Add more items following the same structure -->
        </main>
        <br/>
    <h1 class="menu-title">Beverages</h1>   
    <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
        <br/>
    <h1 class="menu-title">American</h1>   
    <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
        <br/>
    <h1 class="menu-title">Desserts</h1>   
    <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
        <br/>
        <h1 class="menu-title">Soups</h1>   
        <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <!-- Add more items following the same structure -->
        </main>
        <br/>
        <h1 class="menu-title">Cocktails</h1>   
        <br/>
        <main class="menu-container">
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m4.jpg" alt="Chilli Chicken">
                <div class="item-info">
                    <p>Chilli Chicken</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m1.jpg" alt="Hariyali Kebab">
                <div class="item-info">
                    <p>Hariyali Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m2.jpg" alt="Dahi ke Kebab">
                <div class="item-info">
                    <p>Dahi ke Kebab</p>
                </div>
            </div>
            <div class="menu-item">
                <img src="img/m3.jpg" alt="Dahi ke Sholey">
                <div class="item-info">
                    <p>Dahi ke Sholey</p>
                </div>
            </div>s
            <!-- Add more items following the same structure -->
        </main>
    <script src="JS/menu.js"></script>
    <script src="JS/script.js"></script>
    </form>
</body>
</html>
