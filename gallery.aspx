<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gallery.aspx.cs" Inherits="YourChef.gallery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset='utf-8'/>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'/>
    <title>Gallery</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'/>
    <link rel='stylesheet' type='text/css' media='screen' href='CSS/styles.css'/>
    <link rel="stylesheet" href="CSS/gl.css"/>
    <script src='JS/script.js'></script>
</head>
<body>
    <form id="form1" runat="server">
         <div id="header">
        <div class="back-button" onclick="javascript:history.back();">&larr;</div>
        <div class="title">Gallery</div>
        <div class="close-button" onclick="javascript:window.close();">&times;</div>
    </div>  
    <div class="container">
        <div class="gallery">
          <img src="img/blog1.jpg" class="img img-1" />
          <img src="img/blog2.jpg" class="img img-2" />
          <img src="img/blog3.jpg" class="img img-3" />
          <img src="img/post-thumb-1.jpg" class="img img-4" />
          <img src="img/post-thumb-2.jpg" class="img img-5" />
          <img src="img/post-thumb-3.jpg" class="img img-6" />
          <img src="img/post-thumb-4.jpg" class="img img-7" />
          <img src="img/post-thumb-5.jpg" class="img img-8" />
          <img src="img/post-thumb-6.jpg" class="img img-9" />
          <img src="img/sweetf_01.jpg" class="img img-10" />
          <img src="img/sweetf_02.jpg" class="img img-11" />
          <img src="img/sweetf_03.jpg" class="img img-12" />
         </div>
      </div>
    </form>
</body>
</html>
