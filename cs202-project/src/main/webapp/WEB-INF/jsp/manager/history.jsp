<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Borrow History</title>
</head>
<body>
<%
    Object level = session.getAttribute("level");
    String[][] history = (String[][]) session.getAttribute("history");
    if (level != null && level.equals(3)){

%>
<%@ include file="../sideBar.jsp" %>
<table style="margin: auto;">
    <tr>
        <th>Name</th>
        <th>Title</th>
        <th>Borrowing Date</th>
        <th>Due Date</th>
        <th>Return Date</th>
    </tr>
        <%
           if (history != null) {
%>
        <%
    for (String[] item: history) {
%>
    <tr>
        <td><%= item[0] %></td>
        <td><%= item[1] %></td>
        <td><%= item[2] %></td>
        <td><%= item[3] %></td>
        <%
           if (item[4] == null){
        %>
        <td>Not Returned</td>
        <%
        }else{
        %>
        <td><%= item[4] %></td>
        <%
            }
        %>
        <td><form method="POST" action="${pageContext.request.contextPath}/manager/borrow-history/<%=item[5]%>/<%=item[6]%>"><button>Unassign</button></form></td>

    </tr>
        <%
    }}else{
%>
    <p>Hata</p>
        <%
       }}else{
%>
    <p>Not Allowed</p>
    <%
        }
    %>
</body>
</html>
