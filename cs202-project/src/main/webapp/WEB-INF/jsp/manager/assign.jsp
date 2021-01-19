<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Assign / unassign</title>
</head>
<body>
<%
    Object level = session.getAttribute("level");
    String[][] users = (String[][]) session.getAttribute("users");
    String[][] books = (String[][]) session.getAttribute("books");
    if (level != null && level.equals(3)) {

%>
<%@ include file="../sideBar.jsp" %>
<div style="margin-left: 500px">
    <form method="POST">

    <select name="accountId">
        <%
            for (String[] user : users) {
        %>
        <option value=<%=user[0]%>><%=user[1]%></option>
        <%
            }
        %>
    </select>
    <select name="bookId">
        <%
            for (String[] book : books) {
        %>
        <option value=<%=book[0]%>><%=book[1]%></option>
        <%
            }
        %>
    </select>
        <button type="submit">Assign</button>
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