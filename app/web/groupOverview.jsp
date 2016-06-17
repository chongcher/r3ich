<%-- 
    Document   : classOverview
    Created on : 13-May-2016, 17:05:55
    Author     : ccchia.2014
--%>

<%@page import="model.Staff"%>
<%@page import="model.TransactionDAO"%>
<%@page import="model.UserDAO"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Group Overview</title>
    </head>
    <body>
        <%
            String selectedClassAndGroup = (String) request.getParameter("selectedClassAndGroup");
            if(null == selectedClassAndGroup || selectedClassAndGroup == ""){
                session.setAttribute("displayMessage", "Please select a group!");
                response.sendRedirect("dashboard.jsp");
                return;
            }
            String selectedClass = selectedClassAndGroup.substring(0, selectedClassAndGroup.indexOf(" "));
            String selectedGroup = selectedClassAndGroup.substring(selectedClassAndGroup.indexOf(" ")+1);
            UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
            TransactionDAO transactionDAO = (TransactionDAO) session.getAttribute("transactionDAO");
            ArrayList<User> users = userDAO.getUsersByClassAndGroup(selectedClass, selectedGroup);
            for(User u: users){
        %>
                <p>
                    <%= u.getName() %>
                    <%= "<br>Current Points: " + transactionDAO.getTotalPoints(u.getNric()) %>
                    <form action="newTransaction" method="post">
                        <input type="hidden" name="staffID" value=<%= "\"" + staff.getNric() + "\"" %>>
                        <input type="hidden" name="userID" value=<%= "\"" + u.getNric() + "\"" %>>
                        <input type="hidden" name="delta" value="5">
                        <input type="hidden" name="reason" value="Correct answer in class">
                        <input type="hidden" name="selectedClassAndGroup" value=<%="\"" + selectedClassAndGroup.replaceAll(" ", "+") + "\""%>>
                        <button type="submit">Correct Answer</button>
                    </form>
                </p>
        <%
            }
        %>
        <div>
            <form action="dashboard.jsp" method="post">
                <button type="submit">Back to dashboard</button>
            </form>
        </div>
    </body>
</html>
