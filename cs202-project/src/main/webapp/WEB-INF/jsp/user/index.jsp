<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    String overdue = (String) session.getAttribute("overdue");
    String genre = (String) session.getAttribute("genre");
    String borrowedTime =  (String) session.getAttribute("borrowedTime");
    if (username == null) {

%>
<p style="color:red">${message}</p>

<%
} else {
%>
<%@ include file="../userSideBar.jsp" %>
<div style="margin-left: 250px">
    <p> You are logged in as : <%= username%>
    <p>Total number of books that are and were overdue: <%=overdue%>
    </p>
    <p>Favourite genre: <%=genre%>
    </p>
    <p>Total borrowed books: <%=borrowedTime%>
    </p>
</div>
<%
    }
%>
</body>
</html>
