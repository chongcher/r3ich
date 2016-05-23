/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Staff;
import model.StaffDAO;

/**
 *
 * @author ccchia.2014
 */
public class changePasswordServlet extends HttpServlet {

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
        //response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            String currentPassword = (String) request.getParameter("currentPassword"); //name must be declared in JSP!
            String newCandidate = (String) request.getParameter("newCandidate");
            Staff staff;
            staff = (Staff) session.getAttribute("staff");
            StaffDAO staffDAO = (StaffDAO) session.getAttribute("staffDAO");
            if(null == staffDAO || !staffDAO.login(staff.getNric(), currentPassword)){
                session.setAttribute("displayMessage", "Please log in before changing your password!");
                response.sendRedirect("login.jsp");
                return;
            }
            else{
                boolean passwordChangeSuccessfully = staffDAO.changePassword(staff.getNric(), newCandidate);
                if(passwordChangeSuccessfully){
                    session.setAttribute("displayMessage", "Password has been successfully changed!");
                    response.sendRedirect("dashboard.jsp");
                    return;
                }
                else{
                    session.setAttribute("displayMessage", "An unknown error has occured! Your password has not been changed. Please inform an admininstrator!");
                    response.sendRedirect("dashboard.jsp");
                    return;
                }
            }
        }
        catch(Exception e){
            e.printStackTrace();
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
