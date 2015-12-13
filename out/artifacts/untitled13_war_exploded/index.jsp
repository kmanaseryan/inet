<%@ page import="com.mongodb.MongoClient" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="com.mongodb.client.MongoCursor" %><%--
  Created by IntelliJ IDEA.
  User: karlen
  Date: 12/11/15
  Time: 5:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="org.bson.types.ObjectId" %>
<%@ page import="com.mongodb.Block" %>
<%!
  MongoClient mongoClient;
  MongoDatabase db;
  FindIterable<Document> iterable;
  public void jspInit(){
    mongoClient = new MongoClient("localhost", 27017);
    db = mongoClient.getDatabase("mydb");
    MongoCollection productColl = db.getCollection("product");
    productColl.drop();
    Document product = new Document("name", "Tomato")
            .append("desc", "Some description of tomato. Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
            .append("price", 12.99)
            .append("reviews", 7)
            .append("imgURL", "img/tomato.png");
    productColl.insertOne(product);

    product = new Document("name", "Cucumber")
      .append("desc", "Some description of cucumber. Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
      .append("price", 8.99)
      .append("reviews", 12)
      .append("imgURL", "img/cucumber.jpg");
    productColl.insertOne(product);

    product = new Document("name", "Broccoli")
            .append("desc", "Some description of broccoli. Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
            .append("price", 16.99)
            .append("reviews",9)
            .append("imgURL", "img/broccoli.png");
    productColl.insertOne(product);

    product = new Document("name", "Apple")
            .append("desc", "Some description of apple. Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
            .append("price", 7.99)
            .append("reviews", 14)
            .append("imgURL", "img/apple.png");
    productColl.insertOne(product);

    product = new Document("name", "Pepper")
            .append("desc", "Some description of pepper. Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
            .append("price", 4.99)
            .append("reviews", 20)
            .append("imgURL", "img/pepper.jpg");
    productColl.insertOne(product);
  }
%>
<%
  String username = "";
  if (session.isNew()){
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "/login.jsp");
  }else {
    try {
      String userID = (String)session.getAttribute("userID");
      MongoCollection userColl = db.getCollection("user");
      Document query = new Document("_id", new ObjectId(userID));
      username = (String)((Document)userColl.find(query).first()).get("username");

      iterable = db.getCollection("product").find();
    }
    catch (Exception e){
      e.printStackTrace();
    }
  }
%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Online food store</title>

  <!-- Bootstrap Core CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link href="css/shop-homepage.css" rel="stylesheet">

  <![endif]-->

</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Foody | <%= username %></a>

    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-right">
       <li>
          <form id="basketForm" action="basket.jsp" method="GET">
            <button  id="basket" style="padding: 5px;" class="btn btn-primary navbar-btn">Basket <span class="badge">0</span></button>
          </form>
        </li>
      </ul>
    </div>
    <!-- /.navbar-collapse -->
  </div>
  <!-- /.container -->
</nav>

<!-- Page Content -->
<div class="container">

  <div class="row">

    <div class="col-md-12">

      <div class="row carousel-holder">

        <div class="col-md-12">
          <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
              <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
              <li data-target="#carousel-example-generic" data-slide-to="1"></li>
              <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
              <div class="item active">
                <img class="slide-image" src="/img/slide1.jpg" alt="">
              </div>
              <div class="item">
                <img style="" class="slide-image" src="/img/slide2.jpg" alt="">
              </div>
              <div class="item">
                <img class="slide-image" src="/img/cover.jpg" alt="">
              </div>
            </div>
            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
              <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
              <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
          </div>
        </div>

      </div>

      <div class="row">

        <%
          if(iterable != null) {
            final JspWriter finalOut = out;
            iterable.forEach(new Block<Document>() {
              @Override
              public void apply(final Document document) {
                try {
                  finalOut.println("<div id='pr-"+ document.get("name") +"' class='col-sm-4 col-lg-4 col-md-4'>");
                  finalOut.println("<div class='thumbnail'>");
                  finalOut.println("<img src='"+ document.get("imgURL") +"' alt=''>");
                  finalOut.println("<div class='caption'>");
                  finalOut.println("<h4 class='pull-right'>$"+ document.get("price") +"</h4>");
                  finalOut.println("<h4><a href='#'>"+ document.get("name") + "</a>");
                  finalOut.println("</h4>");
                  finalOut.println("<p>"+ document.get("desc") +"</p>");
                  finalOut.println("</div>");
                  finalOut.println("<div class='ratings'>");
                  finalOut.println("<p class='pull-right'>" + document.get("reviews") + " reviews</p>");
                  finalOut.println("<a onclick=\"add(\'"+ document.get("name") +"\')\" style='margin-bottom: 10px;' class='btn btn-primary' target='_blank' >Add</a>");
                  finalOut.println("</div>");
                  finalOut.println("</div>");
                  finalOut.println("</div>");
                }catch (Exception e){

                }
              }
            });
          }

        %>

      </div>

    </div>

  </div>

</div>
<!-- /.container -->

<div class="container">

  <hr>

  <!-- Footer -->
  <footer>
    <div class="row">
      <div class="col-lg-12">
        <p>Copyright &copy; Karlen Manaseryan</p>
      </div>
    </div>
  </footer>

</div>
<!-- /.container -->

<!-- jQuery -->
<script src="js/jquery.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>
<script src="js/app.js"></script>

</body>

</html>
