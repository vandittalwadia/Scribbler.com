/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.techservlets;

import com.entities.User;
import com.techdao.UserDao;
import com.techhelpers.ConnectionProvider;
import com.techhelpers.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author admin
 */
@MultipartConfig

public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
//            out.println("<h1>Servlet EditServlet at " + request.getContextPath() + "</h1>");
            String mail = request.getParameter("txtemail");
            String mob = request.getParameter("txtmobile");
            String med = request.getParameter("txtmedium");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();
            
            //get user session
            
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            user.setEmail(mail);
            user.setMobile(mob);
            user.setMedium(med);
            String oldFile = user.getProfile();
            user.setProfile(imageName);
            //update database
            
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            
            boolean ans = userDao.updateUser(user);
            
            if(ans){
                 String path = request.getRealPath("/") + "profilepics" + File.separator + user.getProfile();
                 
                 String pathOldFile = request.getRealPath("/") + "profilepics" + File.separator + oldFile;
                 
                  if (!oldFile.equals("default.png")) {
                    Helper.deleteFile(pathOldFile);
                }
                 
                 if (Helper.saveFile(part.getInputStream(), path)) {
                    //out.println("Profile updated...");
                    
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Profile Details Updated Successfully');");
                    out.println("location='profile.jsp';");    
                    out.println("</script>");
                 }
                 else{
                     
                     //out.println("not updated");
                     out.println("<script type=\"text/javascript\">");
                     out.println("alert('Details Not Updated ..');");
                     out.println("</script>");

                }
            }
            else{
                out.println("details not updated");
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
