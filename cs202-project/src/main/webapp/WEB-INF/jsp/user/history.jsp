<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%@ include file="../userSideBar.jsp" %>
<table style="margin: auto;">
    <tr>
        <th>Title</th>
        <th>Borrowing Date</th>
        <th>Due Date</th>
        <th>Return Date</th>
        <th>Penalty</th>
        <th>Status</th>
    </tr>
        <%
       String[][] history = (String[][]) session.getAttribute("history");
           if (history != null) {
%>
        <%
    for (String[] item: history) {
%>
    <tr>
        <td><%= item[0] %>
        </td>
        <td><%= item[1] %>
        </td>
        <td><%= item[2] %>
        </td>
        <%
            if (item[5] != null){
                Timestamp returnDate = Timestamp.valueOf(item[5]);
                Timestamp dueDate = Timestamp.valueOf(item[2]);
        %>
        <td><%= item[5] %>
        </td>

            <%
                long result =(returnDate.getTime() - dueDate.getTime()) / (1000 * 60 * 60 * 24);
                if (result > 0){
                    %>
        <td>
           <%=result%>
        </td>
        <%
                }else{
            %>
        <td>0</td>
        <%
            }
        %>
        <td>
            <form>
                <button disabled>Returned</button>
            </form>
        </td>
        <%
            }else{
        %>
        <%
            Timestamp dueDate = Timestamp.valueOf(item[2]);
            Timestamp today = new Timestamp(System.currentTimeMillis());
        %>
        <td>Not Returned
        </td>
        <%
            long result =(today.getTime() - dueDate.getTime()) / (1000 * 60 * 60 * 24);
            if (result > 0){
        %>
        <td>
            <%=result%>
        </td>
        <%
        }else{
        %>
        <td>0</td>
        <%
            }
        %>
        <td>
            <form method="POST" action="/return/<%=id%>/<%=item[3]%>/<%=item[4]%>">
                <input type="submit" value="Return"/>
            </form>
        </td>
        <%
            }
        %>
    </tr>
        <%
    }}else{
%>
    <p>Not Allowed</p>
        <%
       }
%>
</body>
</html>
