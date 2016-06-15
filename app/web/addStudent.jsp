<%-- 
    Document   : addStudent
    Created on : 11-Jun-2016, 11:23:16
    Author     : ccchia.2014
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Student</title>
    </head>
    <body>
        <%
            String errorMsg = (String) session.getAttribute("displayMessage");
            if(errorMsg != null){
                out.println("<p><h2>" + errorMsg + "</h2></p>");
                session.setAttribute("displayMessage",null);
            }
        %>
        <form id="addStudentForm" action="addStudentServlet" method="post">
            <table>
                <tr>
                    <td>Student Username:</td>
                    <td><input type="text" id="studentUserName" name="studentUserName"></td>
                </tr>
                <tr>
                    <td>Student Name:</td>
                    <td><input type="text" id="studentName" name="studentName"></td>
                </tr>
                <tr>
                    <td>Student Class:</td>
                    <td><input type="text" id="studentClass" name="studentClass"></td>
                </tr>
            </table>
            <button type="submit">Add new student</button>
        </form>
        <div>
            <form action="dashboard.jsp" method="post">
                <button type="submit">Back to dashboard</button>
            </form>
        </div>
    </body>
</html>