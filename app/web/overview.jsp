<%-- 
    Document   : overview
    Created on : 09-May-2016, 08:58:47
    Author     : ccchia.2014
--%>

<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.UserDAO"%>
<%@page import="model.TransactionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Overview</title>
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
                if(null == session.getAttribute("userId") && null == request.getParameter("userId")){
            %>
            <div class="form">
                <form action="overview.jsp" method="get">
                    <table>
                        <tr>
                            <td class="alignRight">Student ID:</td>
                            <td class="alignLeft"><input name="userId"></td>
                        </tr>
                        <tr>
                            <td class="centered" colspan="2"><button type="submit">View my points!</button></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="footer">
                <form action="login.jsp" method="post">
                    <button type="submit">Staff Login</button>
                </form>
            </div>
            <%
                    return;
                }
                else{
                    String userId = (String) session.getAttribute("userId");
                    if(null == userId){
                        userId = (String) request.getParameter("userId");
                        session.setAttribute("userId", userId);
                    }
                    TransactionDAO transactionDAO = new TransactionDAO();
                    UserDAO userDAO = new UserDAO();
                    if(!userDAO.exists(userId)){
                        session.setAttribute("displayMessage","Unknown ID! Please try again!");
                        session.setAttribute("userId", null);
                        response.sendRedirect("overview.jsp");
                        return;
                    }
                    session.setAttribute("transactionDAO", transactionDAO);
                    session.setAttribute("userDAO", userDAO);
            %>
            <div class="form">
                <p>
                    Hi <%= userDAO.getName(userId)%>!
                    </br>Current points: <%= transactionDAO.getTotalPoints(userId) %>
                </p>
                <table>
                    <tr>
                        <td class="centered" colspan="2"><u>Top of the class</u></td>
                    </tr>
                    <tr>
                        <td class="centered" style="border-style:solid;border-width:1px;border-color:white;">Name</td>
                        <td class="centered" style="border-style:solid;border-width:1px;border-color:white;">Points</td>
                    </tr>
            <%
                    String userClass = userDAO.getClass(userId);
                    ArrayList<User> classlist = userDAO.getUsersByClass(userClass);
                    final int usersToDisplay = 5;
                    ArrayList<String> rankedClassList = userDAO.getRankedClassList(userClass, usersToDisplay);
                    for(String u: rankedClassList){
            %>
                    <tr>
                        <td class="centered"><%=u%></td>
                        <td class="centered"><%=transactionDAO.getTotalPoints(u)%></td>
                    </tr>
            <%
                    }
            %>
                </table>
            </div>
            <div class="footer">
                <form action="showSkills.jsp" method="get">
                    <input type="hidden" name="userId" value=<%= "\"" + userId + "\""%>>
                    <button type="submit">Show my skills!</button>
                </form>
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>
