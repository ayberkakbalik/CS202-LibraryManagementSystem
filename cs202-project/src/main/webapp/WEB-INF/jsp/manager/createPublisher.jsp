<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Publisher</title>
    <style>
        input[type=text], select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type=submit] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background-color: #45a049;
        }

        div {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
            margin: auto;
            width: 400px;
        }
    </style>
</head>
<body>
<%
    Object level = session.getAttribute("level");
    if (level != null && level.equals(3)){

%>
<%@ include file="../sideBar.jsp" %>
<div>
    <form method="post" action="${pageContext.request.contextPath}/manager/add-publisher">
        <label>Name </label>
        <input type="text" name="name">
        <label>Username</label>
        <input type="text" name="username">
        <label>password</label>
        <input type="password" name="password">
        <input type="submit" value="Add"/>
    </form>
    <p style="color:red">${message}</p>
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
