<%-- 
    Document   : login
    Created on : 13-May-2016, 13:58:34
    Author     : ccchia.2014
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Login</title>
    </head>
    <body>
        <script src="hashes.js"></script><!-- taken from http://cdn.rawgit.com/h2non/jsHashes/master/hashes.js on 23/05/2016 -->
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
            <form id="loginForm" action="loginServlet" method="post">
                <input type="hidden" id="candidate" name="candidate">
                <table>
                    <tr>
                        <td class="alignRight">Username:</td>
                        <td><input type="text" id="staffId" name="staffId"></td>
                    </tr>
                    <tr>
                        <td class="alignRight">Password:</td>
                        <td><input type="password" id="unhashed"></td>
                    </tr>
                    <tr>
                        <td class="centered" colspan="2"><input type="button" onclick="hashPassword()" value="Login"></td>                
                    </tr>
                </table>
            </form>
        </div>
        <script>
            function hashPassword(){
                var unhashed = document.getElementById("unhashed");
                var MD5 = new Hashes.MD5().hex(unhashed.value); //https://github.com/h2non/jshashes
                document.getElementById("candidate").value = MD5;
                document.getElementById("loginForm").submit();
            }
        </script>
    </body>
</html>
