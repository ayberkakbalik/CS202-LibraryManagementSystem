<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Remove Book</title>
</head>
<body>
<%
    Object level = session.getAttribute("level");
    String[][] books = (String[][]) session.getAttribute("books");

    if (level != null && level.equals(3)) {
%>
<%@ include file="../sideBar.jsp" %>
<div style="margin-left: 500px;">

<form method="post" action="${pageContext.request.contextPath}/manager/remove-book">
    <select name="id">
        <%
            for (String[] book : books) {
        %>
        <option value=<%=book[0]%>><%=book[1]%>
        </option>
        <%
            }
        %>
    </select>
    <input type="submit" value="Remove"/>
</form>
</div>

<%
} else {
%>

<p>Not Allowed</p>
<%
    }
%>
</body>
</html>
