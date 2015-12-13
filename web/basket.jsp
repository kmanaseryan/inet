<%@ page import="com.mongodb.MongoClient" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
<%@ page import="com.mongodb.Block" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: karlen
  Date: 12/11/15
  Time: 5:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
  FindIterable<Document> iterable;
  double total = 0;
%>
<%

  try {
  MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
  List<String> prods = ( Arrays.asList(((String)request.getParameter("products")).split(",")));
  MongoDatabase db = mongoClient.getDatabase("mydb");
  MongoCollection productColl = db.getCollection("product");
  Document query = new Document("$in", prods);
  query = new Document("name", query);
  iterable = db.getCollection("product").find(query);

}
catch (Exception e){
  e.printStackTrace();
}%>

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
      <a class="navbar-brand" href="#">Foody </a>

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

        <%
          if(iterable != null) {
            final JspWriter finalOut = out;
            iterable.forEach(new Block<Document>() {
              @Override
              public void apply(final Document document) {
                try {
                  total += ((Number)document.get("price")).doubleValue();
                  finalOut.println("<div class='col-sm-4 col-lg-4 col-md-4'>");
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
    <div class="col-md-12">
      <h4 class='pull-right'>
        Total price $<%=total%>
      </h4>
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

