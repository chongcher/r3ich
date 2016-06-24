<%-- 
    Document   : createNewGroup
    Created on : 16-Jun-2016, 10:58:48
    Author     : ccchia.2014
--%>

<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Create New Group</title>
    </head>
    <body>
        <div class="main">
            <%
                String selectedClass = (String) request.getParameter("selectedClass");
                if(null == selectedClass || selectedClass == ""){
                    session.setAttribute("displayMessage", "Please select a class!");
                    response.sendRedirect("dashboard.jsp");
                    return;
                }
                UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
                ArrayList<User> users = userDAO.getUsersByClass(selectedClass);
            %>
            <form action="createNewGroup" method="post">
                <input type="hidden" value=<%=selectedClass%> name="selectedClass">
                <table>
                    <tr>
                        <td class="alignRight">Subject: </td>
                        <td class="alignLeft"><input name="subject" type="hidden" value="Maths">Maths</td>
                    </tr>
                    <tr>
                        <td class="alignRight">Group name: </td>
                        <td class="alignLeft"><input name="groupName" type="text"></td>
                    </tr>
                    <%
                        for(User u: users){
                    %>
                    <tr>
                        <td class="alignRight">
                            <input name="members[]" type="checkbox" value=<%= u.getNric() %>></input>
                        </td>
                        <td class="alignLeft"><%= u.getName() %></td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td class="centered" colspan="2"><button type="submit">Create group</button></td>
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
