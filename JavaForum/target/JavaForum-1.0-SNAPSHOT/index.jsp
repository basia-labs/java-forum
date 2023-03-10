<%-- 
    Document   : index
    Created on : 22 lis 2022, 22:00:03
    Author     : pawel
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.mycompany.javaforum.Question"%>
<%@page import="Db.DbQuestions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String neQuestionsLimit = getServletContext().getInitParameter("NewQuestionsAmount");
    String questionsLimit = getServletContext().getInitParameter("QuestionsPerPage");
    int contentLimit = Integer.parseInt(getServletContext().getInitParameter("QuestionContentPreviewLength"));

    LinkedList<Question> newQuestionsList = DbQuestions.getDbQuestionList("", "ORDER BY qId DESC", neQuestionsLimit);
    LinkedList<Question> questionsList = DbQuestions.getDbQuestionList("", "ORDER BY qId DESC", questionsLimit);

    request.setAttribute("contentLimit", contentLimit);
    request.setAttribute("newQuestionsList", newQuestionsList);
    request.setAttribute("questionsList", questionsList);

%>

<%
    //search
    if (request.getMethod().equals("POST")) {
        //read POST
        String searchedTitle = request.getParameter("search");
        String sql = "WHERE title LIKE '%" + searchedTitle + "%'";
        questionsList = DbQuestions.getDbQuestionList(sql, "ORDER BY qId DESC", questionsLimit);
        request.setAttribute("questionsList", questionsList);
    }
%>

<!DOCTYPE html>
<head>
    <jsp:include page="Partial/headDefault.html" />
    <title>Java forum</title>
</head>
<body>
    <jsp:include page="Partial/banner.jsp" />
    <div class="container body-content min-vh-100 d-flex">    
        <!--Left block-->
        <div class="col-md-2 pt-4">  
            <h5 class="text-center">New questions:</h5>
            <div class="sticky-top mt-2" style="top:2vh">
                <c:forEach items="${newQuestionsList}" var="q">
                    <div class="pb-3">
                        <div class="card small">
                            <div class="card-header p-4">
                                <p class="m-0">${q.date}</p>   
                            </div>
                            <div class="card-body">
                                <h6 class="card-title"><a href="question.jsp?id=${q.id}">${q.title}</a></h6>
                                <p class="card-text">                                  
                                    ${contentLimit > q.content.length() ? q.content : q.content.substring(0,contentLimit)}
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <a class="btn btn-primary" href="https://github.com/BristolEcru" target="_blank">Przycisk</a>
            </div>
        </div>
        <!--Left block-->

        <!--Right block-->
        <div class="col-md-9 offset-1">
            <form class="d-flex col-md-8 offset-1 pb-3" method="POST">
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
        <!--Right block-->

    </div>
    <jsp:include page="Partial/footer.jsp" />
</body>
</html>
