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

            <div class="card mb-3">
                <div class="card-header">
                    <p>${user.nick}</p>
                    <p>${user.email}</p>
                </div>
                <div class="card-body">
                    <p class="col-md-9 text-justify" style="white-space:pre-line;">
                        
                    </p>
                </div>
            </div>

        </div>

        <jsp:include page="Partial/footer.jsp" />
    </body>
</html>
