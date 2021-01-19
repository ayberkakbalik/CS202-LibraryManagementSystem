<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {

%>

<form method="post" action="/login">
    Username : <input type="text" name="username">
    Password : <input type="password" name="password">
    <input type="submit" value="Login"/>
</form>
<p style="color:red">${errorMessage}</p>
<%
} else {
%>
<p> You are logged in as : <%= username%>
</p>
<a href="/logout">Logout</a>
<%
    }
%>
</body>
</html>
