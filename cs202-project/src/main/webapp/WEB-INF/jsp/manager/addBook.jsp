<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Book</title>
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

    if (level != null && level.equals(3)){

%>
<%@ include file="../sideBar.jsp" %>
<div>
    <form method="post" action="${pageContext.request.contextPath}/manager/add-book">
        <label>Title </label>
        <input type="text" name="title" required>
        <label>Publication Date </label><br>
        <input type="date" name="date" required><br>
        <label>Author</label>
        <input type="text" name="authorId" required>
        <label>Publisher</label>
        <select name="publisherId" required>
            <%
                for (String[] publisher : publishers) {
            %>
            <option value=<%=publisher[0]%>><%=publisher[1]%></option>
            <%
                }
            %>
        </select>
        <label>Genre</label>
        <select name="genreId" required>
            <%
                for (String[] genre : genres) {
            %>
            <option value=<%=genre[0]%>><%=genre[1]%></option>
            <%
                }
            %>
        </select>
        <label>Topic</label>
        <input type="text" name="topic" required>

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
