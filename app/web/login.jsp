<%-- 
    Document   : login
    Created on : 13-May-2016, 13:58:34
    Author     : ccchia.2014
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <script src="http://cdn.rawgit.com/h2non/jsHashes/master/hashes.js"></script>
        <%
            String errorMsg = (String) session.getAttribute("errorMessage");
            if(errorMsg != null){
                out.println("<p><h2>" + errorMsg + "</h2></p>");
                session.setAttribute("errorMessage",null);
            }
        %>
        <form id="loginForm" action="loginServlet" method="post">
            Username: <input type="text" id="staffId" name="staffId">
            Password: <input type="password" id="unhashed">
            <input type="hidden" id="candidate" name="candidate">
            <input type="button" onclick="hashPassword()" value="Login">
        </form>
        <script>
            function hashPassword(){
                var unhashed = document.getElementById("unhashed");
                var MD5 = new Hashes.MD5().hex(candidate.value) //https://github.com/h2non/jshashes
                document.getElementById("candidate").value = MD5;
                document.getElementById("loginForm").submit();
            }
        </script>
    </body>
</html>
