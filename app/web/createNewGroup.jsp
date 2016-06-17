<%-- 
    Document   : createNewGroup
    Created on : 16-Jun-2016, 10:58:48
    Author     : ccchia.2014
--%>

<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Group</title>
    </head>
    <body>
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
                    <td>Subject</td>
                    <td><input name="subject" type="hidden" value="Maths">Maths</td>
                </tr>
                <tr>
                    <td>Group name</td>
                    <td><input name="groupName" type="text"></td>
                </tr>
            </table>
            <%
                for(User u: users){
            %>
                <input name="members[]" type="checkbox" value=<%= u.getNric() %>><%= u.getName() %></input></br>
            <%
                }
            %>
            <button type="submit">Create group</button>
        </form>
    </body>
</html>
