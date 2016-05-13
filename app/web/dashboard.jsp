<%-- 
    Document   : dashboard
    Created on : 13-May-2016, 15:22:35
    Author     : ccchia.2014
--%>

<%@page import="model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Dashboard</title>
    </head>
    <body>
        <!--TODO implement user verification and error page!-->
        <div>
            <form action="classOverview.jsp" method="get">
                Select a class 
                <select name="selectedClass">
                    <%
                        for(String s: staff.getClasses()){
                            out.println("<option value='" + s + "'>" + s + "</option>");
                        }
                    %>
                </select>
                <button type="submit">View Selected Class</button>
            </form>
        </div>
        <div>
            <button>Change Password (Not working!)</button>
        </div>
        <%
            if(((Staff)session.getAttribute("staff")).getNric().equals("asd")){
        %>
                <div>
                    Add admin functions
                    eg. Add staff
                    <!--TODO add functionality!-->
                </div>
        <%
                
            }
        %>
    </body>
</html>
