<%-- 
    Document   : login
    Created on : 23 lis 2022, 11:03:48
    Author     : pawel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Partial/headDefault.html" />
        <title>Log in</title>
    </head>
    <body>
        <jsp:include page="Partial/banner.jsp" />
        <div class="container body-content min-vh-100">
            <h2>Log in</h2>
            <form method="POST">
                <span class="text-danger"> <%= request.getAttribute("loginError")%></span>

                <div class="mb-3 col-6">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="email" name="email">
                </div>

                <div class="mb-3 col-6">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>

                <button type="submit" class="btn btn-primary">Log in</button>
            </form>

        </div>
                
        <jsp:include page="Partial/footer.jsp" />
    </body>
</html>
