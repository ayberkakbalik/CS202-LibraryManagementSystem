<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Request</title>
</head>
<body>

<%@ include file="../sideBar.jsp" %>
<table style="margin: auto;">
    <tr>
        <th>Title</th>
        <th>Publication Date</th>
        <th>Author</th>
        <th>Genre</th>
        <th>Publisher</th>
        <th>Status</th>
        <th>Operation</th>
    </tr>
    <%
        String[][] requests = (String[][]) session.getAttribute("requests");
    %>
    <%
        for (String[] item : requests) {
    %>
    <tr>
        <td><%= item[0] %></td>
        <td><%= item[1] %></td>
        <td><%= item[2] %></td>
        <td><%= item[3] %></td>
        <td><%= item[4] %></td>

        <td><form method="POST" action="/manager/requests/<%=item[5]%>/approve"><button>Approve</button></form></td>
        <td><form method="POST" action="/manager/requests/<%=item[5]%>/decline"><button>decline</button></form></td>

    </tr>
    <%
        }
    %>
</table>
</body>
</html>
