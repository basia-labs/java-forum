<%-- 
    Document   : question
    Created on : 23 lis 2022, 12:52:54
    Author     : pawel
--%>

<%@page import="com.mycompany.javaforum.Answer"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.mycompany.javaforum.Question"%>
<%@page import="Db.DbAnswers"%>
<%@page import="com.mycompany.javaforum.User"%>
<%@page import="Db.DbQuestions"%>
<%@page import="Db.DbRatings"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix = "ex" uri = "WEB-INF/custom.tld"%>

<%
    //load question
    Question question = DbQuestions.getDbQuestion(request.getParameter("id"));
    request.setAttribute("question", question);
%>  
<%
    //insert answer from POST
    String errorMessage = "";
    if (request.getMethod().equals("POST") && request.getParameter("rate") == null) {
        //read POST
        String questionId = request.getParameter("questionId");
        String userId = request.getParameter("userId");
        String contentPOST = request.getParameter("content");

        //validate input
        boolean validData = contentPOST != null && contentPOST.length() > 4;

        //insert if valid
        if (validData) {
            if (DbAnswers.insertAnswer(questionId, userId, contentPOST)) {
                response.sendRedirect(request.getContextPath() + "/question.jsp?id=" + questionId);
                return;
            } else {
                errorMessage = "Internal server error";
            }
        } else {
            errorMessage = "Invalid data";
        }
    }
%>
<%
    //insert rate from POST
    if (request.getMethod().equals("POST") && request.getParameter("content") == null) {
        //read POST
        String answerId = request.getParameter("answerId");
        String rate = request.getParameter("rate");
        String userId = request.getParameter("userId");

        if(!DbRatings.hasUserRated(answerId,userId))
            DbRatings.insertRating(answerId, userId, rate);
    }
%>
<!DOCTYPE html>
<head>
    <jsp:include page="Partial/headDefault.html" />
    <title>${question.title}</title>
</head>
<body>
    <jsp:include page="Partial/banner.jsp" />
    <div class="container body-content min-vh-100">
        <div class="card mb-3">
            <div class="card-header">
                <h4>${question.title}</h4>
                <p>Added by ${question.questionAuthor.nick} (${question.date})</p>
            </div>
            <div class="card-body">
                <p class="col-md-9 text-justify" style="white-space:pre-line;">
                    ${question.content}
                </p>
            </div>
        </div>

        <h2>Answers</h2>
        <hr/>

        <c:if test = "${question.answers == null || question.answers.size() == 0}">
            <h5 class="pb-3">There are no answers yet. Help ${question.questionAuthor.nick}!</h5>
        </c:if>

        <c:forEach items="${question.answers}" var="a">
            <div class="card mb-4">
                <div class="card-header">
                    <div class="container d-flex p-0">
                        <form method="post" class="col-md-2 d-flex flex-row">
                            <button type="submit" class="btn btn-primary col-md-5">Rate</button>
                            <select class="form-select-sm col-md-4" name="rate">
                                <c:forEach var = "i" begin = "1" end = "10">
                                    <option value="${i}">${i}★</option>
                                </c:forEach>
                            </select>
                            <input type="hidden" name="answerId" value="${a.id}"/>
                            <input type="hidden" name="userId" value="<%=((User) request.getSession().getAttribute("user")).id%>"/>
                        </form>
                        <span class="col-md-5 display-6"><ex:rating value="${DbRatings.getAnswerAvgRating(a.id)}"/></span>
                        <span class="col-md-5 text-end">${a.answerAuthor.nick} (${a.date})</span>
                    </div>
                </div>
                <div class="card-body">
                    <p class="card-text" style="white-space:pre-line;">
                        ${a.content}
                    </p>
                </div>
            </div>
        </c:forEach>

        <h2>Your answer</h2>
        <hr/>

        <div class="container">
            <form method="POST">
                <%=errorMessage%>
                <div class="form-horizontal">
                    <input style="display:none" name="questionId" value=<%=request.getParameter("id")%>>
                    <input type="hidden" name="userId" value="<%=((User) request.getSession().getAttribute("user")).id%>"/>
                    <div class="form-group">
                        <div class="col-md-11">
                            <textarea class="form-control input-group col-md-10" id="content" 
                                      name="content" cols="40" rows="5" placeholder="Write your answer"></textarea>
                        </div>
                    </div>
                    <br/>
                    <div class="form-group">
                        <div class="col-md-10">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="Partial/footer.jsp" />
</body>
</html>
