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
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Add Staff</title>
    </head>
    <body>
        <script src="hashes.js"></script><!-- taken from http://cdn.rawgit.com/h2non/jsHashes/master/hashes.js on 23/05/2016-->
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
            <form id="addStaffForm" action="addStaffServlet" method="post">
                <input type="hidden" id="newCandidate" name="newCandidate">
                <table>
                    <tr>
                        <td class="alignRight">Staff Username:</td>
                        <td class="alignLeft"><input type="text" id="staffUserName" name="staffUserName"></td>
                    </tr>
                    <tr>
                        <td class="alignRight">Salutation:</td>
                        <td class="alignLeft">
                            <select id="staffSalutation" name="staffSalutation">
                                <option value="Mdm">Mdm</option>
                                <option value="Mr">Mr</option>
                                <option value="Mrs">Mrs</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="alignRight">Staff Name:</td>
                        <td class="alignLeft"><input type="text" id="staffName" name="staffName"></td>
                    </tr>
                    <tr>
                        <td class="alignRight">New Password:</td>
                        <!-- TODO implement password validation -->
                        <td class="alignLeft"><input type="password" id="unhashedNewCandidate"></td>
                    </tr>
                    <tr>
                        <td class="alignRight">Confirm New Password:</td>
                        <td class="alignLeft"><input type="password" id="unhashedNewCandidateConfirmation"></td>
                    </tr>
                    <tr>
                        <td class="centered" colspan="2"><input type="button" onclick="hashFormFields()" value="Add New Staff"></td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="footer">
            <form action="dashboard.jsp" method="post">
                    <button type="submit">Back to dashboard</button>
            </form>
        </div>
    </body>
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
</html>
