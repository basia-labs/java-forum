<%-- 
    Document   : my-account
    Created on : 6 gru 2022, 17:17:08
    Author     : pawel
--%>

<%@page import="com.mycompany.javaforum.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Partial/headDefault.html" />
        <title>My Account</title>
    </head>
    <body>
        <jsp:include page="Partial/banner.jsp" />
        <div class="container body-content min-vh-100">
            <h4 style="display: inline-block;">Username: </h4> <h5 style="display: inline-block;">${user.nick}</h5>    <br>    
            <h4 style="display: inline-block;">Email: </h4> <h5 style="display: inline-block;">${user.email}</h5>
        </div>

        <jsp:include page="Partial/footer.jsp" />
    </body>
</html>
