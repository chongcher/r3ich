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
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Edit Staff Classes</title>
    </head>
    <body>
        <div class="main">
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
                <table>
                <%
                    for(String className: allClasses){
                        if(!assignedClasses.contains(className)){
                %>
                    <tr>
                        <td class="alignRight"><input type="checkbox" name="assignedClasses[]" value=<%= "\"" + className + "\"" %>></td>
                        <td class="alignLeft"><%= className %></td>
                    </tr>
                <%         
                        }
                        else{
                %>
                    <tr>
                        <td class="alignRight"><input type="checkbox" name="assignedClasses[]" value=<%= "\"" + className + "\"" %> checked></td>
                        <td class="alignLeft"><%= className %></td>
                    </tr>
                <%
                        }
                    }
                %>
                    <tr>
                        <td class="centered" colspan="2"><button type="submit">Assign classes</button></td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="footer">
            <form action="dashboard.jsp" method="post">
                <button type="submit">Back to dashboard</button>
            </form>
        </div>
    </body>
</html>
