<%@page import="java.util.ArrayList"%>
<%@page import="com.entities.Category"%>
<%@page import="com.techdao.PostDao"%>
<%@page import="com.techhelpers.ConnectionProvider"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.entities.User"%>
<%

    User user = (User)session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("login.jsp");
    }




   String start_date= user.getTime().toString();
   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
   LocalDateTime now = LocalDateTime.now();
   String end_date = (dtf.format(now)).toString();
   
   // SimpleDateFormat converts the
		// string format to date object
		SimpleDateFormat sdf
			= new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");

		// Try Class
                String y="";
                String d="";
		try {

			// parse method is used to parse
			// the text from a string to
			// produce the date
			Date d1 = new java.sql.Date(sdf.parse(start_date).getTime());
			Date d2 = new java.sql.Date(sdf.parse(end_date).getTime());

			// Calucalte time difference
			// in milliseconds
			long difference_In_Time
				= d2.getTime() - d1.getTime();

			// Calucalte time difference in seconds,
			// minutes, hours, years, and days
			long difference_In_Seconds
				= TimeUnit.MILLISECONDS
					.toSeconds(difference_In_Time)
				% 60;

			long difference_In_Minutes
				= TimeUnit
					.MILLISECONDS
					.toMinutes(difference_In_Time)
				% 60;

			long difference_In_Hours
				= TimeUnit
					.MILLISECONDS
					.toHours(difference_In_Time)
				% 24;

			long difference_In_Days
				= TimeUnit
					.MILLISECONDS
					.toDays(difference_In_Time)
				% 365;

			long difference_In_Years
				= TimeUnit
					.MILLISECONDS
					.toDays(difference_In_Time)
				/ 365l;

			// Print the date difference in
			// years, in days, in hours, in
			// minutes, and in seconds
			
			// Print result
			
				y = Long.toString(difference_In_Years);
				
				d = Long.toString(difference_In_Days);
				
				
		}
		catch (ParseException e) {
			e.printStackTrace();
		}
	


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
    </head>
    <body>
        <!-- navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#"> <span class="fa fa-address-book"></span> Blogger's Space</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      
<!--      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Categories
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Java Programming</a>
          <a class="dropdown-item" href="#">Python Programming</a>
          <a class="dropdown-item" href="#">C++ Programming</a>
          <a class="dropdown-item" href="#">R Programming</a>
          <a class="dropdown-item" href="#">Javascript Programming</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>-->
      <li class="nav-item">
          <a class="nav-link" href="contactUs.jsp"><span class="fa fa-phone"></span> Contact Me</a>
      </li>
      
       <li class="nav-item">
          <a class="nav-link" href="#" data-toggle = "modal" data-target="#exampleModal"><span class="fa fa-pencil-square-o"></span> Start Post</a>
      </li>
    </ul>
      <ul class="navbar-nav mr-right">
          
          <li class="nav-item">
          <a class="nav-link" href="#!"  data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-plus"></span> <%="Welcome, "+user.getName()%> </a>
      </li>
          <li class="nav-item">
          <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span> Logout </a>
      </li>
      </ul>
  </div>
</nav>

        <!-- nav ends -->
        
 <!-- Button trigger modal -->
<!--<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#profile-modal">
  Launch demo modal
</button>-->


 <!--main body of the page-->

        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first col-->
                    <div class="col-md-4">
                        <!--categories-->
                        <div class="list-group">
                            <a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action active">
                                All Posts
                            </a>
                            <!--categories-->

                            <%  PostDao pod = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list = pod.getAllCategories();
                                for (Category cat : list) {
                            %>
                            <a href="#" onclick="getPosts(<%= cat.getCid()%>,this)" class=" c-link list-group-item list-group-item-action"><%= cat.getName()%></a>


                            <%                                       
                                }
                            %>
                        </div>

                    </div>

                    <!--second col-->
                    <div class="col-md-8" >
                        <!--posts-->
                       
                        <div class="container-fluid" id="post-container">

                        </div>
                    </div>

                </div>

            </div>

        </main>


        <!--end main body of the page-->

<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      
    <div class="modal-header primary-background text-white ">
      <h5 class="modal-title" id="exampleModalLabel">BloggersVAN</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
      
          
      <div class="modal-body  "  >
          <div class="container text-center">
              <img src="profilepics/<%=user.getProfile()%>" class="img-fluid" style="border-radius:50%; max-width: 180px;">
              <h5 class="modal-title" id="exampleModalLabel"><%=user.getName()%></h5>
<!--              table-->
              <div id="profile-details">
              <table class="table">
  
                            <tbody>
                                <tr>
                                <th scope="row">Your Unique ID : </th>
                                <td><%=user.getId()%></td>
                                
                                
                              </tr>
                              <tr>
                                <th scope="row">Your Email : </th>
                                <td><%=user.getEmail()%></td>
                                
                                
                              </tr>
                              <tr>
                                <th scope="row">Your Mobile Number :</th>
                                <td><%=user.getMobile()%></td>
                                
                              </tr>
                              <tr>
                                <th scope="row">Your Medium : </th>
                                <td><%=user.getMedium()%></td>
                               
                              </tr>
                              <tr>
                                <th scope="row">You Registered : </th>
                                <td><%=y+" Years"+" "+d+" days ago"%></td>
                               
                              </tr>
                            </tbody>
                            </table>
              </div>
<!--                                profile edit part-->

              <div id="profile-edit" style="display: none;">
                  <h3>Please Edit Carefully</h3>
                  <form method="post" action="EditServlet" enctype="multipart/form-data">
                      <table class="table">
                          <tr>
                              <td>ID :</td>
                              <td><%= user.getId()%></td>
                               
                          </tr>
                           <tr>
                              <td>Email :</td>
                              <td><input type="email" name="txtemail" class="form-control" value="<%= user.getEmail()%>"></td>
                               
                          </tr>
                          <tr>
                              <td>Mobile :</td>
                              <td><input type="text" name="txtmobile" class="form-control" value="<%= user.getMobile()%>"></td>
                               
                          </tr>
                          <tr>
                              <td>Medium :</td>
                              <td><input type="text" name="txtmedium" class="form-control" value="<%= user.getMedium()%>"></td>
                               
                          </tr>
                          <tr>
                              <td>Upload Photo :</td>
                              <td><input type="file" name = "image" accept="image/*" class="form-control" /></td>
                               
                          </tr>
                      </table>
                              <div class="container">
                                  <button type="submit" class="btn btn-outline-success" >SAVE</button>
                              </div>
                              
    
                              
                  </form>
              </div>
          </div>
          
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="edit-profile-button">EDIT</button>
      </div>
    </div>
  </div>
</div>
                             
                              
                              
<!--          profile modal ends-->

<!--post modal starts-->



<!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add your post details here ...</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                    
                       <form id="add-post-form" method="post" action="AddPostServlet" enctype="multipart/form-data">
                      <table class="table">
                           <tr>
                              <td>Select Category :</td>
                              <td>
                                  <select class = "form-control" name = "cid">
                                       <%                                
                                           PostDao pd = new PostDao(ConnectionProvider.getConnection());
                                           ArrayList<Category> list1 = pd.getAllCategories();
                                           for (Category cc : list1) {
                                        %>
                                            <option value = "<%=cc.getCid()%>"><%=cc.getName()%></option>
                                       
                                        <%
                                            }
                                        %>
                                  </select>
                              </td>
                               
                          </tr>
                           <tr>
                              <td>Enter Post Title  :</td>
                              <td><input type="text" name="txtmypost" class="form-control" ></td>
                               
                          </tr>
                          <tr>
                              <td>Enter Post Content :</td>
                              <td><textarea name="txtpostcontent" class="form-control" ></textarea></td>
                               
                          </tr>
                          <tr>
                              <td>Add More Points or Code for example (if any) :</td>
                              <td><textarea name="txtpostprogram" class="form-control" ></textarea></td>
                               
                          </tr>
                         
                          <tr>
                              <td>Upload Photo :</td>
                              <td><input type="file" name = "mypostimage" accept="image/*" class="form-control" /></td>
                               
                          </tr>
                      </table>
                              <div class="container">
                                  <button type="submit" class="btn btn-outline-success" >SAVE POST</button>
                              </div>
                              
                    </form>
                    
                  </div>
                  
                </div>
              </div>
            </div>

<!--        post modal ends -->
        
        <!--javascripts-->
        
       
        
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        
        
        
        <script>
            $(document).ready(function(){
                //Toggle Logic...
                let editStatus=false;
                $('#edit-profile-button').click(function(){
                    //alert("hi")
                    if(editStatus==false){
                        $('#profile-details').hide();
                        $('#profile-edit').show();
                        editStatus=true;   
                        $(this).text("Back");
                    }
                    else{
                        $('#profile-details').show();
                        $('#profile-edit').hide();
                        editStatus=false; 
                        $(this).text("Edit");
                    }
                })
            });
        </script>
        
<!--        now add post using ajax-->

 <script>
            $(document).ready(function (e) {
                //
                $("#add-post-form").on("submit", function (event) {
                    //this code gets called when form is submitted....
                    event.preventDefault();
                    console.log("you have clicked on submit..")
                    let form = new FormData(this);
                    //now requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //success ..
                            console.log(data);
                            if (data.trim() === 'done')
                            {
                                swal("Good job!", "saved successfully", "success");
                            } else
                            {
                                swal("Error!!", "Something went wrong try again...", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error..
                            swal("Error!!", "Something went wrong try again...", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>
        
<!--        loading posts using ajax-->

        <script>
            
            function getPosts(catid , temp){
                
                $(".c-link").removeClass('active')
                $.ajax({
                    url : "Load_posts.jsp",
                    data: {cid : catid},
                    success: function(data,textStatus,jqXHR){
                        console.log(data);
                        $('#post-container').html(data);
                        $(temp).addClass('active')
                    }
                })
            }
            $(document).ready(function(){
                let allpostsRef = $('.c-link')[0]
                getPosts(0,allpostsRef);
            })

        </script>
        <footer class="background">
        <p class="text-footer">
            Copyright @2022 Vandit Talwadia All rights are reserved.
        </p>
 
    </footer>
    </body>
</html>
