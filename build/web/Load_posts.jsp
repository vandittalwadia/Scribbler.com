<%-- 
    Document   : Load_posts
    Created on : 10-Nov-2022, 7:22:08 pm
    Author     : admin
--%>
<%@page import="java.util.List"%>
<%@page import="com.entities.Post"%>
<%@page import="com.techdao.PostDao"%>
<%@page import="com.techhelpers.ConnectionProvider"%>
<div class="row">
<% 
   PostDao d = new PostDao(ConnectionProvider.getConnection());
   int cid = Integer.parseInt(request.getParameter("cid"));
    List<Post> posts = null;
    if (cid == 0) {
        posts = d.getAllPosts();
    } else {
        posts = d.getPostByCatId(cid);
    }

    if (posts.size() == 0) {
        out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>");
        return;
    }

   for(Post p : posts){
 %>
    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%= p.getPpic()%>" alt="Card image cap">
                    <div class="card-body">
                        <b><%= p.getPtitle()%></b>
                        <p><%= p.getPcontent()%></p>

                        <b>Posted on : <%= p.getPdate().toLocaleString()%></b>
                    </div>
                    <div>
                        <div class="card-footer">
<!--                            url rewriting-->
                            <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>" class="btn btn-outline-primary btn-sm">Read More ...</a>
                        </div>
                    </div>
        </div>
    </div>
           
 <%
   }
%>
</div>