<%-- 
    Document   : groupUtilities
    Created on : 17-Jun-2016, 21:57:44
    Author     : ccchia.2014
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Group Utilities</title>
    </head>
    <body>
        <%
            String errorMsg = (String) session.getAttribute("displayMessage");
            if(errorMsg != null){
                out.println("<p><h2>" + errorMsg + "</h2></p>");
                session.setAttribute("displayMessage" , null);
            }
        %>
        <%
            String selectedClass = (String) request.getParameter("selectedClass");
            UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
            ArrayList<String> allGroups = userDAO.getGroupsByClass(selectedClass);
        %>
        <div>
            <form action="createNewGroup.jsp" method="get">
                <input type="hidden" name="selectedClass" value=<%=selectedClass%>>
                <button type="submit">Create New Group</button>
            </form>
        </div>
        <div>
            <form action="editGroupMembers.jsp" method="get">
                <input type="hidden" name="selectedClass" value=<%=selectedClass%>>
                <select name="selectedGroup">
                    <%
                        for(String s: allGroups){                            
                    %> 
                            <option value=<%= "\"" + s + "\""%>><%=s%></option>
                    <%
                        }
                    %>
                </select>
                <button type="submit">Edit Group Members</button>
            </form>
        </div>
    </body>
</html>
