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
<%
  String site = new String("http://www.photofuntoos.com");
  response.setStatus(response.SC_MOVED_TEMPORARILY);
  response.setHeader("Location", "/login.jsp");
  try {
    MongoClient mongoClient = new MongoClient( "localhost" , 27017 );


// or

       /*
// or
        MongoClient mongoClient = new MongoClient();
        MongoClient mongoClient = new MongoClient( "localhost" );

// or, to connect to a replica set, with auto-discovery of the primary, supply a seed list of members
        MongoClient mongoClient = new MongoClient(Arrays.asList(new ServerAddress("localhost", 27017),
                new ServerAddress("localhost", 27018),
                new ServerAddress("localhost", 27019)));
*/
    MongoDatabase db = mongoClient.getDatabase("mydb");
    MongoCollection coll = db.getCollection("user");


    /////////////////////////Create documents/////////////////////////

        Document doc = new Document("firstName", "Karlen")
                .append("lastName", "Manaseryan");

        Document doc1 = new Document("firstName", "Raymond")
                .append("lastName", "Zavodnik")
                .append("isStudent", false);

        /*String arr[] = {"OOP", "Theory of computing"};
        Document doc = new Document("firstName", "Raymond")
                .append("lastName", "Zavodnik")
                .append("teaches", arr);

        /*
        Document doc1 = new Document("firstName", "Karlenooo")
                .append("lastName", "Manaseryan");

        Document doc = new Document("firstName", "Raymond")
                .append("lastName", "Zavodnik")
                .append("myStudent", doc1);

        */
       coll.insertOne(doc);

    /////////////////////////Retrieve documents/////////////////////////

/*
        Document query = new Document("LastName", "Manaseryan");
        Document user = (Document)coll.find(query).first();
        System.out.print("First name: " + user.get("firstName") + ", ");
        System.out.print("last name: " + user.get("lastName"));
*/
    Document query = new Document("lastName", "Manaseryan");
    FindIterable iterable = coll.find(query);
    MongoCursor cursor = iterable.iterator();
    out.println("First name: ");
    while(cursor.hasNext()) {
      Document obj = (Document)cursor.next();

      out.println("First name: " + obj.get("firstName") + ", Last name: " + obj.get("lastName"));

    }
    /////////////////////////Update and delete documents/////////////////////////
/*

        Document query = new Document("lastName", "Manaseryan");
        coll.updateOne(query, new Document("$set", new Document("firstName", "Karlos")));

*/
        /*
        Document query = new Document("lastName", "Manaseryan");
        Document user = (Document) coll.find(query).first();

        user.put("firstName", "Karlen");
        coll.replaceOne(query, user);
        */

        /*
        Document query = new Document("lastName", "Manaseryan");
        coll.deleteMany(query);
        */
  }
  catch (Exception e){
    e.printStackTrace();
  }%>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  $END$
  </body>
</html>
