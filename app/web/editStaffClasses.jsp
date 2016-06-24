<%-- 
    Document   : assignGroupToStaff
    Created on : 20-Jun-2016, 10:13:03
    Author     : ccchia.2014
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Staff Classes</title>
    </head>
    <body>
        <%
            String selectedStaff = (String) request.getParameter("selectedStaff");
            if(null == selectedStaff || selectedStaff.equals("")){
                session.setAttribute("displayMessage", "Please select a staff member!");
                response.sendRedirect("dashboard.jsp");
                return;
            }
            UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
            StaffDAO staffDAO = (StaffDAO) session.getAttribute("staffDAO");
            ArrayList<String> allClasses = userDAO.getAllClasses();
            ArrayList<String> assignedClasses = staffDAO.getAssignedClasses(selectedStaff);
        %>
        <form action="editStaffClassesServlet" method="post">
            <input type="hidden" name="staffId" value=<%= selectedStaff %>>
            <%
                for(String className: allClasses){
                    if(!assignedClasses.contains(className)){
            %>
            <input type="checkbox" name="assignedClasses[]" value=<%= "\"" + className + "\"" %>><%= className %></br>
            <%         
                    }
                    else{
            %>
            <input type="checkbox" name="assignedClasses[]" value=<%= "\"" + className + "\"" %> checked><%= className %></br>
            <%
                    }
                }
            %>
            <button type="submit">Assign classes</button>
        </form>
    </body>
</html>
