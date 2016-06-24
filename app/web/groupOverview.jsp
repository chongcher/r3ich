<%-- 
    Document   : groupOverview
    Created on : 13-May-2016, 17:05:55
    Author     : ccchia.2014
--%>

<%@page import="model.Staff"%>
<%@page import="model.TransactionDAO"%>
<%@page import="model.UserDAO"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Group Overview</title>
    </head>
    <body>
        <div class="main">
            <%
                String selectedClassAndGroup = (String) request.getParameter("selectedClassAndGroup");
                if(null == selectedClassAndGroup || selectedClassAndGroup == ""){
                    session.setAttribute("displayMessage", "Please select a group!");
                    response.sendRedirect("dashboard.jsp");
                    return;
                }
                String selectedClass = selectedClassAndGroup.substring(0, selectedClassAndGroup.indexOf(" "));
                String selectedGroup = selectedClassAndGroup.substring(selectedClassAndGroup.indexOf(" ")+1);
                UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
                TransactionDAO transactionDAO = (TransactionDAO) session.getAttribute("transactionDAO");
                ArrayList<User> users = userDAO.getUsersByClassAndGroup(selectedClass, selectedGroup);
            %>
            <table>
                <tr>
                    <td class="centered" style="border-style:solid;border-width:0.5px;border-color:white;">Name</td>
                    <td class="centered" style="border-style:solid;border-width:0.5px;border-color:white;">Points</td>
                    <td class="centered" style="border-style:solid;border-width:0.5px;border-color:white;">Level Up</td>
                </tr>
                <% 
                    for(User u: users){ 
                %>
                <tr>
                    <td class="centered"><%= u.getName() %></td>
                    <td class="centered"><%= transactionDAO.getTotalPoints(u.getNric()) %></td>
                    <td class="centered">
                        Points required to level up: <%= userDAO.getPointsRequiredToLevelUp(u.getNric())%>
                        <%
                            if(transactionDAO.getTotalPoints(u.getNric()) >= userDAO.getPointsRequiredToLevelUp(u.getNric())){
                        %>
                                <form action="levelUpServlet" action="post">
                                    <input type="hidden" name="staffID" value=<%= "\"" + staff.getNric() + "\"" %>>
                                    <input type="hidden" name="userID" value=<%= "\"" + u.getNric() + "\"" %>>
                                    <input type="hidden" name="selectedClassAndGroup" value=<%="\"" + selectedClassAndGroup.replaceAll(" ", "+") + "\""%>>
                                    <input type="hidden" name="delta" value=<%="\"" + userDAO.getPointsRequiredToLevelUp(u.getNric()) + "\""%>>
                                    <select name="skillType">
                                        <option value="Respect">Respect</option>
                                        <option value="Respect">Resilience</option>
                                        <option value="Respect">Responsibility</option>
                                        <option value="Respect">Integrity</option>
                                        <option value="Respect">Care</option>
                                        <option value="Respect">Harmony</option>
                                    </select>
                                    <br><button type="submit">Level up</button>
                                </form>
                        <%
                            }
                        %>
                    </td>
                </tr>
                <tr>
                    <td class="centered" colspan="3">
                        <form action="newTransaction" method="post">
                            <input type="hidden" name="delta" value="5">
                            <input type="hidden" name="reason" value="Correct answer in class">
                            <input type="hidden" name="selectedClassAndGroup" value=<%="\"" + selectedClassAndGroup.replaceAll(" ", "+") + "\""%>>
                            <button type="submit">Correct Answer</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <div class="footer">
            <form action="dashboard.jsp" method="post">
                <button type="submit">Back to dashboard</button>
            </form>
        </div>
    </body>
</html>
