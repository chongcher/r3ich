<%@page import="java.sql.SQLException"%>
<%@page import="org.joda.time.format.DateTimeFormat"%>
<%@page import="org.joda.time.format.DateTimeFormatter"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="controller.StaffDAO"%>
<%@page import="controller.UserDAO"%>
<%@page import="controller.TransactionDAO"%>
<%@page import="model.Staff"%>
<%@page import="model.User"%>

<%
    StaffDAO staffDAO = (StaffDAO) session.getAttribute("staffDAO");
    UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
    //TransactionDAO transactionDAO = (TransactionDAO) session.getAttribute("transactionDAO");
                //TODO get TransactionDAO from session attribute!
                TransactionDAO transactionDAO = new TransactionDAO();
    
    String requestStaffID = (String) request.getParameter("staffID");
    String requestUserID = request.getParameter("userID");
    String requestDelta = request.getParameter("delta");
    String requestReason = request.getParameter("reason");
    DateTime requestTimestamp = DateTime.now();
    if(!transactionDAO.newTransaction(requestStaffID,requestUserID,requestDelta,requestReason,requestTimestamp)){
        session.setAttribute("errorMessage", "Could not create a new transaction! Please try again later!");
    }
    response.sendRedirect("overview.jsp");
%>