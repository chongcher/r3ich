<%-- 
    Document   : changePassword
    Created on : 21-May-2016, 17:42:33
    Author     : ccchia.2014
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
    </head>
    <body>
        <script src="hashes.js"></script><!-- taken from http://cdn.rawgit.com/h2non/jsHashes/master/hashes.js on 23/05/2016-->
        <%
            String errorMsg = (String) session.getAttribute("displayMessage");
            if(errorMsg != null){
                out.println("<p><h2>" + errorMsg + "</h2></p>");
                session.setAttribute("displayMessage",null);
            }
        %>
        <form id="changePasswordForm" action="changePasswordServlet" method="post">
            <table>
                <tr>
                    <td>Current Password:</td>
                    <td><input type="password" id="unhashedCurrentPassword"></td>
                </tr>
                <tr>
                    <td>New Password:</td>
                    <td><input type="password" id="unhashedNewCandidate"></td>
                </tr>
                <tr>
                    <td>Confirm New Password:</td>
                    <td><input type="password" id="unhashedNewCandidateConfirmation"></td>
                </tr>
            </table>
            <input type="hidden" id="currentPassword" name="currentPassword">
            <input type="hidden" id="newCandidate" name="newCandidate">
            <input type="button" onclick="hashFormFields()" value="Change password">
        </form>
        <script>
            function hashFormFields(){
                //TODO catch form fields empty!
                var unhashedCurrentPassword = document.getElementById("unhashedCurrentPassword");
                var unhashedNewCandidate = document.getElementById("unhashedNewCandidate");
                var unhashedNewCandidateConfirmation = document.getElementById("unhashedNewCandidateConfirmation");
                if(unhashedNewCandidate.value !== unhashedNewCandidateConfirmation.value){
                    window.alert("new passwords do not match! Please try again!");
                    return;
                }
                else{
                    var MD5 = new Hashes.MD5().hex(unhashedCurrentPassword.value); //https://github.com/h2non/jshashes
                    document.getElementById("currentPassword").value = MD5;
                    MD5 = new Hashes.MD5().hex(unhashedNewCandidate.value); //https://github.com/h2non/jshashes
                    document.getElementById("newCandidate").value = MD5;
                    document.getElementById("changePasswordForm").submit();
                }
            }
        </script>
    </body>
</html>
