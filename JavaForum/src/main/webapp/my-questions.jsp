<%-- 
    Document   : my-questions
    Created on : 6 gru 2022, 17:33:51
    Author     : pawel
--%>

<%@page import="com.mycompany.javaforum.User"%>
<%@page import="Db.DbQuestions"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.mycompany.javaforum.Question"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String where = "WHERE questions.userid = " + ((User) request.getSession().getAttribute("user")).id;
    String orderBy = "ORDER BY qId DESC";
    LinkedList<Question> questionsList = DbQuestions.getDbQuestionList(where, orderBy, "9999");
    int contentLimit = Integer.parseInt(getServletContext().getInitParameter("QuestionContentPreviewLength"));
    request.setAttribute("contentLimit", contentLimit);
    request.setAttribute("questionsList", questionsList);
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Partial/headDefault.html" />
        <title>My questions</title>
    </head>
    <body>
        <jsp:include page="Partial/banner.jsp" />
        <div class="container body-content min-vh-100">    
            <h2 class="text-center">My questions</h2>
            <form class="d-flex col-md-8 offset-1 pb-3" method="GET">
                <input class="form-control me-sm-2 col-md-6 offset-1" type="text" id="search" name="search" placeholder="Search">
                <button class="btn btn-primary" type="submit">Szukaj</button>
            </form>

            <c:forEach items="${questionsList}" var="q">
                <div class="pb-3">
                    <div class="card">
                        <div class="card-header p-4">
                            <h5 class="card-title "><a href="question.jsp?id=${q.id}">${q.title}</a></h5>
                            <p class="m-0 text-left text-align-left">${q.date} &emsp; Number of answers: ${q.answers.size()}</p>   
                        </div>
                        <div class="card-body">
                            <p class="card-text">
                                ${q.content}
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
        <jsp:include page="Partial/footer.jsp" />
    </body>
</html>
