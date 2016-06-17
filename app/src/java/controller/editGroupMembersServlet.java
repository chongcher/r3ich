/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import model.UserDAO;

/**
 *
 * @author ccchia.2014
 */
public class editGroupMembersServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            String selectedClass = (String) request.getParameter("selectedClass"); //name must be declared in JSP!
            String selectedGroup = (String) request.getParameter("selectedGroup"); //name must be declared in JSP!
            UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
            ArrayList<User> allClassUsers = userDAO.getUsersByClass(selectedClass);
            ArrayList<User> currentGroupMembers = userDAO.getUsersByClassAndGroup(selectedClass, selectedGroup);
            ArrayList<String> updatedMembers;
            String[] membersArray = (String[]) request.getParameterValues("updatedMembers[]");
            if(membersArray == null || membersArray.length == 0){
                updatedMembers = new ArrayList<String>();
            }
            else{
                updatedMembers = new ArrayList<String>(Arrays.asList(membersArray));
            }
            System.out.println("Check2");
            ArrayList<String> addedToGroup = new ArrayList<String>();
            ArrayList<String> removedFromGroup = new ArrayList<String>();
            for(User u: allClassUsers){
                if(currentGroupMembers.contains(u) && !updatedMembers.contains(u.getNric())){
                    removedFromGroup.add(u.getNric());
                }
                else if(!currentGroupMembers.contains(u) && updatedMembers.contains(u.getNric())){
                    addedToGroup.add(u.getNric());
                }
            }
            if(!userDAO.updateGroup(selectedClass, selectedGroup, addedToGroup, removedFromGroup)){
                session.setAttribute("displayMessage", "Could not update group! Please contact an administrator");
            }
            else{
                session.setAttribute("displayMessage", "Updated group successfully");
            }
            session.setAttribute("userDAO", new UserDAO());
            response.sendRedirect("groupUtilities.jsp?selectedClass=" + request.getParameter("selectedClass"));
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
