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
            if(null == session.getAttribute("userId") && null == request.getAttribute("userId")){
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
            <button id="staffLoginButton">Staff Login</button>
            <script type="text/javascript">
                document.getElementById("staffLoginButton").onclick = function(){
                    location.href = "login.jsp";
                }
            </script>
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
                session.setAttribute("transactionDAO", new TransactionDAO());
                session.setAttribute("userDAO", new UserDAO());
            }
            TransactionDAO transactionDAO = (TransactionDAO) session.getAttribute("transactionDAO");
            UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
            String userId = (String) session.getAttribute("userId");
            if(!userDAO.exists("userId")){
                session.setAttribute("displayMessage","Unknown ID! Please try again!");
                session.setAttribute("userId", null);
                response.sendRedirect("overview.jsp");
                return;
            }
        %>
        <div>
            <p>
                Hi <%= userDAO.getName(userId) %> !
                </br>Current points: <%= transactionDAO.getTotalPoints(userId) %>
                <!--TODO show classmates' scores
                //TODO show skills-->
            </p>
            <p>
                <u>Top of the class</u>
            </p>
        <%
            String userClass = userDAO.getClass(userId);
            ArrayList<User> classlist = userDAO.getUsersByClass(userClass);
            final int usersToDisplay = 5;
            int currentlyDisplayed = 0;
            while(currentlyDisplayed < usersToDisplay){
                int tmpTopScore = 0;
                ArrayList<User> usersWithTopScore = new ArrayList<>();
                for(User u: classlist){
                    //if(transactionDAO.getTotalPoints(userID))
                    //TODO too expensive! Use SQL to do this instead!
                }
            }
        %>
        </div>
    </body>
</html>
