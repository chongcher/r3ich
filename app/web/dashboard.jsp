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
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Staff Dashboard</title>
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
            <table>
                <form action="groupOverview.jsp" method="get">
                    <tr>
                        <td class="alignRight">Group: </td>
                        <td class="alignLeft">
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
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="centered">
                            <button type="submit">View Selected Group</button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="spacer"></td>
                    </tr>
                </form>
                <form action="groupUtilities.jsp" method="get">
                    <tr>
                        <td class="alignRight">Class: </td>
                        <td>
                            <select name="selectedClass">
                                <%
                                    for(String s: UserDAO.getAllClasses()){
                                        out.println("<option value='" + s + "'>" + s + "</option>");
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="centered">
                            <button type="submit">View Group Utilities</button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="spacer"></td>
                    </tr>
                </form>
                <form action="changePassword.jsp" method="post">
                    <tr>
                        <td class="centered" colspan="2"><button type="submit">Change Password</button></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="spacer"></td>
                    </tr>
                </form>
                <form action="addStaff.jsp" method="post">
                    <tr>
                        <td class="centered" colspan="2"><button type="submit">Add Staff</button></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="spacer"></td>
                    </tr>
                </form>
                <form action="addStudent.jsp" method="post">
                    <tr>
                        <td class="centered" colspan="2"><button type="submit">Add Student</button></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="spacer"></td>
                    </tr>
                </form>
                <form action="editStaffClasses.jsp" method="post">
                    <tr>
                        <td class="alignRight">Select a staff member:</td>
                        <td class="alignLeft">
                            <select name="selectedStaff">
                                <%
                                    StaffDAO staffDAO = (StaffDAO) session.getAttribute("staffDAO");
                                    for(Staff s: staffDAO.getAllStaff()){
                                        out.println("<option value='" + s.getNric() + "'>" + s.getSalutation() + " " + s.getName() + "</option>");
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="centered" colspan="2"><button type="submit">Assign Class to Staff</button></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="spacer"></td>
                    </tr>
                </form>
            </table>
        </div>
        <div class="footer">
            <button id="logoutButton">Logout</button>
            <script type="text/javascript">
                document.getElementById("logoutButton").onclick = function(){
                    location.href = "${pageContext.request.contextPath}/logoutServlet";
                }
            </script>
        </div>
    </body>
</html>
