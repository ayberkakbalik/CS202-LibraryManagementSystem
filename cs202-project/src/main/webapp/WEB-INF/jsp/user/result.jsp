<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Library</title>
</head>
<body>

<%@ include file="../userSideBar.jsp" %>
<div style="margin-left: 250px;">
    <table>
        <tr>
            <th>Title</th>
            <th>Publication Date</th>
            <th>Author</th>
            <th>Genre</th>
            <th>Publisher</th>
            <th>Availability</th>
            <th>Operation</th>
        </tr>
        <%
            String[][] books = (String[][]) session.getAttribute("books");
        %>
        <%
            for (String[] item : books) {
        %>
        <tr>
            <td><%= item[0] %></td>
            <td><%= item[1] %></td>
            <td><%= item[2] %></td>
            <td><%= item[3] %></td>
            <td><%= item[4] %></td>
            <td style="text-align: center"><%= item[5] %></td>
            <% if (item[5].equals("1")){%>
            <td><form method="POST" action="/borrow/<%=id%>/<%=item[6]%>"><button>Borrow</button></form></td>
            <%
            } else{
            %>
            <td><button disabled>Borrowed</button></td>
            <%
                }
            %>
        </tr>
        <%
            }
        %>
    </table>
</div>

</body>
</html>
