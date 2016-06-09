<%-- 
    Document   : addStaff
    Created on : 29-May-2016, 14:19:41
    Author     : ccchia.2014
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Staff</title>
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
        <form id="addStaffForm" action="addStaffServlet" method="post">
            <table>
                <tr>
                    <td>Staff username:</td>
                    <td><input type="text" id="staffUserName" name="staffUserName"></td>
                </tr>
                <tr>
                    <td>Salutation:</td>
                    <!--TODO change to dropdown list -->
                    <td><input type="text" id="staffSalutation" name="staffSalutation"></td>
                </tr>
                <tr>
                    <td>Staff Name:</td>
                    <td><input type="text" id="staffName" name="staffName"></td>
                </tr>
                <tr>
                    <td>New Password:</td>
                    <!-- TODO implement password validation -->
                    <td><input type="password" id="unhashedNewCandidate"></td>
                </tr>
                <tr>
                    <td>Confirm New Password:</td>
                    <td><input type="password" id="unhashedNewCandidateConfirmation"></td>
                </tr>
            </table>
            <input type="hidden" id="newCandidate" name="newCandidate">
            <input type="button" onclick="hashFormFields()" value="Add New Staff">
        </form>
        <script>
            function hashFormFields(){
                //TODO catch form fields empty!
                var unhashedNewCandidate = document.getElementById("unhashedNewCandidate");
                var unhashedNewCandidateConfirmation = document.getElementById("unhashedNewCandidateConfirmation");
                if(unhashedNewCandidate.value !== unhashedNewCandidateConfirmation.value){
                    window.alert("Your passwords do not match! Please try again!");
                    return;
                }
                else{
                    var MD5 = new Hashes.MD5().hex(unhashedNewCandidate.value); //https://github.com/h2non/jshashes
                    document.getElementById("newCandidate").value = MD5;
                    document.getElementById("addStaffForm").submit();
                }
            }
        </script>
    </body>
</html>
