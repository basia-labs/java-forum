<%-- 
    Document   : new-question
    Created on : 23 lis 2022, 10:21:48
    Author     : pawel
--%>

<%@page import="com.mycompany.javaforum.User"%>
<%@page import="com.mycompany.javaforum.Question"%>
<%@page import="Db.DbQuestions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String errorMessage = "";
    if (request.getMethod().equals("POST")) {
        //read POST
        String userId = request.getParameter("userId");
        String titlePOST = request.getParameter("title");
        String contentPOST = request.getParameter("content");

        //validate input
        boolean validData = titlePOST != null && contentPOST != null
                && titlePOST.length() > 4 && contentPOST.length() > 4;

        //insert if valid
        if (validData) {
            if (DbQuestions.insertQuestion(userId, titlePOST, contentPOST)) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            } else {
                errorMessage = "Internal server error";
            }
        } else {
            errorMessage = "Invalid data";
        }
    }
%>

<!DOCTYPE html>
<head>
    <jsp:include page="Partial/headDefault.html" />
    <title>New Question</title>
</head>
<body>
    <jsp:include page="Partial/banner.jsp" />
    <div class="container body-content min-vh-100">
        <h2>New Question</h2>
        <form method="POST">

            <div class="mb-3 col-6">
                <%=errorMessage%>

                <input type="hidden" name="userId" value="<%=((User) request.getSession().getAttribute("user")).id%>"/>

                <div>
                    <label for="email" class="form-label">Title</label>
                    <input type="text"class="form-control" id="title" name="title"/>
                </div>

                <div>
                    <label for="content" class="form-label">Content</label>
                    <textarea class="form-control input-group col-md-10" id="content" name="content" cols="40" rows="5"></textarea>
                </div>

                <button type="submit" class="btn btn-primary mt-2" style="width: 100%">Ask</button>
            </div>
        </form>

    </div>

    <jsp:include page="Partial/footer.jsp" />
</body>
</html>
