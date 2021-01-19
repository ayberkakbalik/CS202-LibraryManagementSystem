<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search</title>
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
    String[][] genres = (String[][]) session.getAttribute("genres");
    String[][] publishers = (String[][]) session.getAttribute("publishers");
    if (level != null){

%>
<%@ include file="../userSideBar.jsp" %>
<div style="margin: auto">
    <form method="post" action="${pageContext.request.contextPath}/search">
        <label>Title </label>
            <input type="text" name="title">
        <label>Publication Year </label>
            <input type="text" name="year">
        <label>Author</label>
            <input type="text" name="author">
        <label>Genre</label>
        <select name="genre">
            <option value="">Genres</option>

            <%
                for (String[] genre : genres) {
            %>
            <option value=<%=genre[0]%>><%=genre[1]%></option>
            <%
                }
            %>
        </select>
        <label>publisher</label>
        <select name="publisher">
            <option value="">Publishers</option>
            <%
                for (String[] publisher : publishers) {
            %>
            <option value=<%=publisher[0]%>><%=publisher[1]%></option>
            <%
                }
            %>
        </select>
        <label>Availability</label>
            <select name="availability">
                <option value="1">Available</option>
                <option value="0">Not Available</option>
            </select>
        <input type="submit" value="Search"/>
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
