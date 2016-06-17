<%-- 
    Document   : editGroupMembers
    Created on : 17-Jun-2016, 22:55:43
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
        <title>Edit Group Members</title>
    </head>
    <body>
        <%
            String selectedClass = (String) request.getParameter("selectedClass");
            String selectedGroup = (String) request.getParameter("selectedGroup");
            if(null == selectedGroup || selectedGroup == ""){
                session.setAttribute("displayMessage", "Please select a group!");
                response.sendRedirect("dashboard.jsp");
                return;
            }
            UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
            ArrayList<User> users = userDAO.getUsersByClass(selectedClass);
        %>
        <h2>Group Name: <%= selectedGroup %></h2>
        <form action="editGroupMembersServlet" method="post">
            <input type="hidden" name="selectedClass" value=<%="\"" + selectedClass + "\""%>>
            <input type="hidden" name="selectedGroup" value=<%="\"" + selectedGroup + "\""%>>
        <%
            for(User u: users){
                boolean currentlyInGroup = u.getGroupList().contains(selectedGroup);
        %>
        <input type="checkbox" name="updatedMembers[]" value=<%= "\"" + u.getNric() + "\""%> <% if(currentlyInGroup) out.print("checked");%>><%= u.getName()%></option></br>
        <%        
            }
        %>
            <button type="submit">Update group</button>
        </form>
    </body>
</html>
