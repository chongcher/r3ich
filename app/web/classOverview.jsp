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
        <title>Class Overview</title>
    </head>
    <body>
        <%
            String selectedClass = (String) request.getParameter("selectedClass");
            UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
            TransactionDAO transactionDAO = (TransactionDAO) session.getAttribute("transactionDAO");
            ArrayList<User> users = userDAO.getUsersByClass(selectedClass);
            for(User u: users){
        %>
                <p>
                    <%= u.getName()%>
                    <%= "\nCurrent Points: " + transactionDAO.getTotalPoints(u.getNric()) %>
                    <form action="newTransaction" method="post">
                        <input type="hidden" name="staffID" value=<%= "\"" + staff.getNric() + "\"" %>>
                        <input type="hidden" name="userID" value=<%= "\"" + u.getNric() + "\"" %>>
                        <input type="hidden" name="delta" value="5">
                        <input type="hidden" name="reason" value="Correct answer in class">
                        <button type="submit">Correct Answer</button>
                    </form>
                </p>
        <%
            }
        %>
    </body>
</html>
