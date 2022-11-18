<%@page import="com.techdao.UserDao"%>
<%@page import="com.techdao.PostDao"%>
<%@page import="com.entities.Post"%>
<%@page import="com.techhelpers.ConnectionProvider"%>
<%@page import="com.entities.User"%>
<%

    User user = (User)session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("login.jsp");
    }
%>

<%
    int post_id = Integer.parseInt(request.getParameter("post_id"));
     PostDao d = new PostDao(ConnectionProvider.getConnection());
     Post p = d.getPostByPostId(post_id);
%>
    

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--        css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
           
        </style>
    </head>
    <body style="background: url(img/showblogback.jpg);">
        <!--main content of body-->


        <div class="container ">

            <div class="row my-4">

                <div class="col-md-8 offset-md-2">


                    <div class="card">

                        <div class="card-header primary-background text-white">

                            <h4 class="post-title"><%= p.getPtitle()%></h4>


                        </div>

                        <div class="card-body">

                            <img class="card-img-top my-2 " src="blog_pics/<%= p.getPpic()%>" alt="Card image cap" style="height : 400px;width:700px;" >


                            <div class="row my-3 row-user">
                                
                                <div class="col-md-8">
                                    <% UserDao ud = new UserDao(ConnectionProvider.getConnection());%>

                                    <b><p class="post-user-info"> <a href="#!"> <%= ud.getUserByUserId(p.getUserid()).getName()%></a> has posted : </p></b>
                                </div>
                               
                            </div>


                            <p class="post-content"><%= p.getPcontent()%></p> 

                            <br>
                            <br>

                            <div class="post-code">
                                <p><%= p.getPcode()%></p>
                            </div>

                        </div>




                    </div>


                </div>

            </div>

        </div>



        <!--end of main content  of body-->
        <footer class="background">
        <p class="text-footer">
            Copyright @2022 Vandit Talwadia All rights are reserved.
        </p>
 
    </footer>

    </body>
</html>
