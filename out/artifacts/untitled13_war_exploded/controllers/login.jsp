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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% try {
  MongoClient mongoClient = new MongoClient( "localhost" , 27017 );

  MongoDatabase db = mongoClient.getDatabase("mydb");
  MongoCollection coll = db.getCollection("user");

  Document user = new Document("username", request.getParameter("username"))
          .append("password", request.getParameter("password"));
  coll.insertOne(user);
  String userID = user.get("_id").toString();
  session.setAttribute("userID", userID);
  response.setStatus(response.SC_MOVED_TEMPORARILY);
  response.setHeader("Location", "/index.jsp");

}
catch (Exception e){
  e.printStackTrace();
}%>


