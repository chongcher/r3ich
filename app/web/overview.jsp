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
        <title>Overview</title>
    </head>
    <body>
        <%
            if(session.getAttribute("displayMessage") != null){
                out.println("<p>" + session.getAttribute("displayMessage") + "</p>");
                session.setAttribute("displayMessage", null);
            }
            if(null == session.getAttribute("userId") && null == request.getParameter("userId")){
        %>
        <div>
            <p>
                <form action="overview.jsp" method="get">
                    Student ID <input name="userId">
                    <button type="submit">View my points!</button>
                </form>
            </p>
        </div>
        <div>
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
        <div>
            <p>
                Hi <%= userDAO.getName(userId) %> !
                </br>Current points: <%= transactionDAO.getTotalPoints(userId) %>
            </p>
            <p>
                <u>Top of the class</u>
                <table>
                    <tr>
                        <td>Name</td>
                        <td>Points</td>
                    </tr>
        <%
                String userClass = userDAO.getClass(userId);
                ArrayList<User> classlist = userDAO.getUsersByClass(userClass);
                final int usersToDisplay = 5;
                ArrayList<String> rankedClassList = userDAO.getRankedClassList(userClass, usersToDisplay);
                for(String u: rankedClassList){
        %>
                <tr>
                    <td><%=u%></td>
                    <td><%=transactionDAO.getTotalPoints(u)%></td>
                </tr>
        <%
                }
        %>
                </table>
            </p>
        </div>
        <div>
            <form action="showSkills.jsp" method="get">
                <input type="hidden" name="userId" value=<%= "\"" + userId + "\""%>>
                <button type="submit">Show my skills!</button>
            </form>
        </div>
        <%
            }
        %>
    </body>
</html>
