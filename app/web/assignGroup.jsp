<%-- 
    Document   : assignGroup
    Created on : 16-Jun-2016, 10:05:28
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
        <title>Assign Group</title>
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
            ArrayList<String> classGroups = userDAO.getGroupsByClass(selectedClass);
        %>
        <form action="assignGroups" method="post">
            <select name="selectedGroup">
                <%
                    for(String s: classGroups){
                        
                %>
                    <option value=<%= s %>><%= s %></option>
                <%
                    }
                %>
            </select></br>
            <%
                for(User u: users){
            %>
                <input type="checkbox" value=<%= u.getNric() %>><%= u.getName() %></input></br>
            <%
                }
            %>
            <button type="submit">Submit</button>
        </form>
        <div>
            <form action="createNewGroup.jsp" method="get">
                <input type="hidden" name="selectedClass" value=<%= selectedClass%>>
                <button type="submit">Create new group</button>
            </form>
        </div>
        <div>
            <form action="dashboard.jsp" method="post">
                <button type="submit">Back to dashboard</button>
            </form>
        </div>
    </body>
</html>
