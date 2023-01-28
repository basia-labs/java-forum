<%-- 
    Document   : banner
    Created on : 22 lis 2022, 21:47:21
    Author     : pawel
--%>

<%@page import="Db.DbAnswers"%>
<%@page import="Db.DbQuestions"%>
<%@page import="com.mycompany.javaforum.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ServletContext ctx = getServletContext();
    String loggedUsers = String.valueOf(ctx.getAttribute("logged"));
    String activeUsers = String.valueOf(ctx.getAttribute("active"));

    String totalQuestions = DbQuestions.getQuestionsAmount();
    String totalAnswers = DbAnswers.getAnswersAmount();

    boolean isFirefox = !Boolean.valueOf(String.valueOf(request.getAttribute("isFirefox")));;
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-<%= isFirefox ? "dark" : "primary" %>">

    <div class="container-fluid">
        <a class="navbar-brand" href="/JavaForum">Java forum</a>
        <div class="collapse navbar-collapse" id="navbarColor01">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="new-question.jsp">New question</a>
                </li>
            </ul>

            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="#">Questions: <%=totalQuestions%> Answers: <%=totalAnswers%></a></li>
                <li class="nav-item"><a class="nav-link" href="#">Logged: <%=loggedUsers%> Active: <%=activeUsers%></a></li>
                    <%
                        if (request.getSession().getAttribute("user") == null) {
                    %>
                <li class="nav-item"><a class="nav-link" href="register.jsp" id="registerLink">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp" id="loginLink">Log in</a></li>
                    <%
                    } else {
                    %>
                <li class="nav-item"><a class="nav-link" href="#">Hi <%=((User) request.getSession().getAttribute("user")).nick%></a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp" id="loginLink">Log out</a></li>
                    <%
                        }
                    %>
            </ul>


        </div>
    </div>
</nav>
<br/>
