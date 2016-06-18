<%-- 
    Document   : dashboard
    Created on : 13-May-2016, 15:22:35
    Author     : ccchia.2014
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.UserDAO"%>
<%@page import="model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Dashboard</title>
    </head>
    <body>
        <%
            String errorMsg = (String) session.getAttribute("displayMessage");
            if(errorMsg != null){
                out.println("<p><h2>" + errorMsg + "</h2></p>");
                session.setAttribute("displayMessage" , null);
            }
        %>
        <div>
            <form action="groupOverview.jsp" method="get">
                Select a group 
                <select name="selectedClassAndGroup">
                    <%
                        UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
                        for(String s: staff.getClasses()){
                            ArrayList<String> classGroups = userDAO.getGroupsByClass(s);
                            for(String classGroup: classGroups){
                                out.println("<option value='" + s + " " + classGroup + "'>" + s + " " + classGroup + "</option>");
                            }
                        }
                    %>
                </select>
                <button type="submit">View Selected Group</button>
            </form>
        </div>
        <div>
            <form action="groupUtilities.jsp" method="get">
                Select a class
                <select name="selectedClass">
                    <%
                        for(String s: UserDAO.getAllClasses()){
                            out.println("<option value='" + s + "'>" + s + "</option>");
                        }
                    %>
                </select>
                <button type="submit">View Group Utilities</button>
            </form>
        </div>
        <div>
            <form action="changePassword.jsp" method="post">
                <button type="submit">Change Password</button>
            </form>
        </div>
        <div>
            <form action="addStaff.jsp" method="post">
                <button type="submit">Add Staff</button>
            </form>
        </div>
        <div>
            <form action="addStudent.jsp" method="post">
                <button type="submit">Add Student</button>
            </form>
        </div>
        <div>
            <form action="assignGroupToStaff.jsp" method="post">
                <button type="submit">Add Student</button>
            </form>
        </div>
        <div>
            <button id="logoutButton">Logout</button>
            <script type="text/javascript">
                document.getElementById("logoutButton").onclick = function(){
                    location.href = "${pageContext.request.contextPath}/logoutServlet";
                }
            </script>
        </div>
    </body>
</html>
