<%-- 
    Document   : security
    Created on : 13-May-2016, 17:19:30
    Author     : ccchia.2014
--%>

<%@page import="model.StaffDAO"%>
<%@page import="model.Staff"%>
<%
    Staff staff = (Staff) session.getAttribute("staff");
    if(null == staff){
        session.setAttribute("errorMessage", "Please log in!");
        response.sendRedirect("login.jsp");
        return;
    }
%>
