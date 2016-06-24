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
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Add Student</title>
    </head>
    <body>
        <div class="header">
            <%
                String errorMsg = (String) session.getAttribute("displayMessage");
                if(errorMsg != null){
                    out.println("<p><h2 style=\"color:red;text-align:center;\">" + errorMsg + "</h2></p>");
                    session.setAttribute("displayMessage" , null);
                }
            %>
        </div>
        <div class="main">
            <form id="addStudentForm" action="addStudentServlet" method="post">
                <table>
                    <tr>
                        <td class="alignRight">Student Username:</td>
                        <td class="alignLeft"><input type="text" id="studentUserName" name="studentUserName"></td>
                    </tr>
                    <tr>
                        <td class="alignRight">Student Name:</td>
                        <td class="alignLeft"><input type="text" id="studentName" name="studentName"></td>
                    </tr>
                    <tr>
                        <td class="alignRight">Student Class:</td>
                        <td class="alignLeft"><input type="text" id="studentClass" name="studentClass"></td>
                    </tr>
                    <tr>
                        <td class="centered" colspan="2"><button type="submit">Add new student</button></td>
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