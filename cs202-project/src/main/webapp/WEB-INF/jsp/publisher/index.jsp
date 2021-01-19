<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Publisher</title>
</head>
<body>
<%
    Object level = session.getAttribute("level");
    String borrowed = (String) session.getAttribute("borrowed");

    if (level != null && level.equals(2)) {
%>
<%@ include file="../publisherSideBar.jsp" %>
<p style="margin-left: 250px">Borrowed Times: <%=borrowed%></p>
<%
} else {
%>

<p style="color:red">${message}</p>
<%
    }
%>
</body>
</html>
