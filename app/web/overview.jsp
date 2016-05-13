<%-- 
    Document   : overview
    Created on : 09-May-2016, 08:58:47
    Author     : ccchia.2014
--%>

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
        <div>
            <%
                if(session.getAttribute("errorMessage") != null){
                    out.println("<p>" + session.getAttribute("errorMessage") + "</p>");
                    session.setAttribute("errorMessage", null);
                }
            %>
        </div>
        <div>
            <p>Xiao Ming</p>
            <p>
                <%
                    //initialize required DAOs as session attributes
                    TransactionDAO transactionDAO = new TransactionDAO();
                    UserDAO userDAO = new UserDAO();
                    session.setAttribute("transactionDAO", transactionDAO);
                    session.setAttribute("userDAO", userDAO);
                    //TODO if no user selected, prompt for userNRIC
                    //TODO show classmates' scores
                    //TODO show skills
                %>
                Points: <%= transactionDAO.getTotalPoints("S1234567A")%>
            </p>
        </div>  
        <!--TODO hide forms if not staff!-->
        <form action="newTransaction" method="post">
            <!--TODO get variables from objects!-->
            <input type="hidden" name="staffID" value="S9876543Z">
            <input type="hidden" name="userID" value="S1234567A">
            <input type="hidden" name="delta" value="5">
            <input type="hidden" name="reason" value="Correct answer in class">
            <button type="submit">Correct Answer</button>
        </form>
    </body>
</html>