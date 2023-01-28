<%-- 
    Document   : my-answers
    Created on : 6 gru 2022, 17:38:04
    Author     : pawel
--%>

<%@page import="com.mycompany.javaforum.User"%>
<%@page import="Db.DbAnswers"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.mycompany.javaforum.Answer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    //load answers
    String statement = "SELECT *"
            + "FROM answers "
            + "WHERE answers.userId = " + ((User)request.getSession().getAttribute("user")).id;
    LinkedList<Answer> answers = DbAnswers.getDbAnswersListByStatement(statement);
    request.setAttribute("answers", answers);
%>  

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Partial/headDefault.html" />
        <title>My answers</title>
    </head>
    <body>
        <jsp:include page="Partial/banner.jsp" />
        <div class="container body-content min-vh-100">    
            <h2 class="text-center">My answers</h2>
            <form class="d-flex col-md-8 offset-1 pb-3" method="GET">
                <input class="form-control me-sm-2 col-md-6 offset-1" type="text" id="search" name="search" placeholder="Search">
                <button class="btn btn-primary" type="submit">Szukaj</button>
            </form>

            <c:forEach items="${answers}" var="a">
                <div class="pb-3">
                    <div class="card">
                        <div class="card-header text-end">
                            <p>Added: ${a.date}</p>
                        </div>
                        <div class="card-body">
                            <p class="card-text">${a.content}</p>
                            <a href="question.jsp?id=${a.questionId}" class="btn btn-primary">More</a>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
        <jsp:include page="Partial/footer.jsp" />
    </body>
</html>
