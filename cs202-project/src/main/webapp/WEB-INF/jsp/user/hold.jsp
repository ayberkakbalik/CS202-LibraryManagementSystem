<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hold</title>
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
    String[][] books = (String[][]) session.getAttribute("books");
    String[][] holds = (String[][]) session.getAttribute("holds");
    if (level != null){

%>
<%@ include file="../userSideBar.jsp" %>
<div style="margin: auto">
    <form method="post" action="${pageContext.request.contextPath}/hold/<%=id%>">
        <select name="bookId">
            <%
                for (String[] book : books) {
            %>
            <option value=<%=book[0]%>><%=book[1]%></option>
            <%
                }
            %>
        </select>
        <input type="submit" value="Hold"/>
    </form>
    <table>
        <tr>
            <th>Title</th>
            <th>Reserve Date</th>
        </tr>
        <%
            for (String[] hold : holds) {
        %>
        <tr>
            <th><%=hold[0]%></th>
            <th><%=hold[1]%></th>
        </tr>
        <%
            }
        %>
    </table>
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
