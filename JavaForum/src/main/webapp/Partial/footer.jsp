<%-- 
    Document   : footer
    Created on : 6 gru 2022, 16:17:00
    Author     : pawel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<hr>
<footer>
    <p></p>

    <footer class="text-center text-white bg-primary">
        <%
            if (request.getSession().getAttribute("user") != null) {
        %>
        <div class="container p-3 pb-0">
            <p class="d-flex justify-content-center align-items-center">
                <a href="my-account.jsp" class="btn btn-light btn-rounded m-1">
                    My account
                </a>
                <a href="my-questions.jsp" class="btn btn-light btn-rounded m-1">
                    My questions
                </a>
                <a href="my-answers.jsp" class="btn btn-light btn-rounded m-1">
                    My answers
                </a>
            </p>
        </div>
        <%
            }
        %>

        <div class="text-center p-1" style="background-color: rgba(0, 0, 0, 0.15);">
            © 2022 Copyright:
            <a class="text-white" href="https://github.com/PawelDrozdowski" target="_blank">Paweł Drozdowski</a>
        </div>
    </footer>
</footer>
