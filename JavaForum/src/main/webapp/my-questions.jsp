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
                <button class="btn btn-secondary my-2 my-sm-0" type="submit">🔍</button>
                <input class="form-control me-sm-2 col-md-6 offset-1" type="text" id="search" name="search" placeholder="Search">
            </form>

            <c:forEach items="${questionsList}" var="q">
                <div class="pb-3">
                    <div class="card">
                        <div class="card-header text-end p-4">
                            <p class="m-0">${q.date} &emsp; Number of answers: ${q.answers.size()}</p>   
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${q.title}</h5>
                            <p class="card-text">
                                ${q.content}
                            </p>
                            <a href="question.jsp?id=${q.id}" class="btn btn-primary">More</a>

                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
        <jsp:include page="Partial/footer.jsp" />
    </body>
</html>
