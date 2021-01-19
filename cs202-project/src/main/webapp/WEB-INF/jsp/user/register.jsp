<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="/register">
    <label>Name </label>
    <input type="text" name="name">
    <label>Username</label>
    <input type="text" name="username">
    <label>Password</label>
    <input type="password" name="password">
    <input type="submit" value="Register"/>
</form>
<p style="color:red">${message}</p>
</body>
</html>
