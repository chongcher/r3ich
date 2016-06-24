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
        <link rel="stylesheet" href="style.css" type="text/css">
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
            <%
                String selectedClass = (String) request.getParameter("selectedClass");
                UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
                ArrayList<String> allGroups = userDAO.getGroupsByClass(selectedClass);
            %>
            <table>
                <form action="createNewGroup.jsp" method="get">
                    <input type="hidden" name="selectedClass" value=<%=selectedClass%>>
                    <tr>
                        <td class="centered" colspan="2"><button type="submit">Create New Group</button></td>
                    </tr>
                </form>
                <form action="editGroupMembers.jsp" method="get">
                    <input type="hidden" name="selectedClass" value=<%=selectedClass%>>
                    <tr>
                        <td class="alignRight">
                            <select name="selectedGroup">
                                <%
                                    for(String s: allGroups){                            
                                %> 
                                        <option value=<%= "\"" + s + "\""%>><%=s%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                        <td class="alignLeft"><button type="submit">Edit Group Members</button></td>
                    </tr>
                </form>
            </table>
        </div>
        <div class="footer">
            <form action="dashboard.jsp" method="post">
                <button type="submit">Back to dashboard</button>
            </form>
        </div>
    </body>
</html>
