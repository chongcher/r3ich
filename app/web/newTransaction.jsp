<%@page import="org.joda.time.DateTime"%>
<%@page import="controller.StaffDAO"%>
<%@page import="controller.UserDAO"%>
<%@page import="controller.TransactionDAO"%>
<%@page import="model.Staff"%>
<%@page import="model.User"%>

<%
    StaffDAO staffDAO = (StaffDAO) session.getAttribute("staffDAO");
    UserDAO userDAO = (UserDAO) session.getAttribute("userDAO");
    TransactionDAO transactionDAO = (TransactionDAO) session.getAttribute("transactionDAO");
    
    String requestStaffID = request.getParameter("staffID");
    String requestUserID = request.getParameter("userID");
    String requestDelta = request.getParameter("delta");
    String requestReason = request.getParameter("reason");
    DateTime requestTimestamp = DateTime.now();
    //TODO make sure that requestTimestamp is formatted properly!
    if(!transactionDAO.newTransaction(requestStaffID,requestUserID,requestDelta,requestReason,requestTimestamp)){
        request.setAttribute("errorMessage", "Could not create a new transaction! Please try again later!");
    }
    //TODO enter default teacher page
    RequestDispatcher rd = request.getRequestDispatcher("");
    rd.forward(request, response);
%>