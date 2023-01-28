<%-- 
    Document   : logout
    Created on : 26 lis 2022, 11:56:46
    Author     : pawel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.getSession().invalidate();
    response.sendRedirect(request.getContextPath() + "/index.jsp");
%>
