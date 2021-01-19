<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>Manager</title>
    <style>
        .collapsible {
            background-color: #777;
            color: white;
            cursor: pointer;
            padding: 18px;
            width: 400px;
            border: none;
            text-align: center;
            outline: none;
            font-size: 15px;
            margin-right: 100px;
            margin-left: 100px;
        }

        .active, .collapsible:hover {
            background-color: #555;
        }

        .content {
            display: none;
            overflow: hidden;
            background-color: #f1f1f1;
            width: 400px;
            margin-left: 100px;
        }
    </style>
</head>
<body>
<%
    Object level = session.getAttribute("level");
    String[][] mostBorrowed = (String[][]) session.getAttribute("mostBorrowed");
    String[][] mostBorrowed3Months = (String[][]) session.getAttribute("mostBorrowed3Months");
    String[][] users = (String[][]) session.getAttribute("users");
    String[][] publishers = (String[][]) session.getAttribute("publishers");
    String[][] overdueBooks = (String[][]) session.getAttribute("overdueBooks");
    String overdue = (String) session.getAttribute("overdue");
    if (level != null && level.equals(3)) {

%>
<%@ include file="../sideBar.jsp" %>
<div style="margin-left:250px;">
    <button type="button" class="collapsible">The most borrowed book genres (all time)</button>
    <div class="content">
        <table>
            <tr>
                <th>Genre</th>
                <th>Borrowed Times</th>
            </tr>
            <%
                for (String[] item : mostBorrowed) {
            %>
            <tr>
                <td><%= item[1] %>
                </td>
                <td><%= item[0] %>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <button type="button" class="collapsible">The most borrowed books (last three months)</button>
    <div class="content">
        <table>
            <tr>
                <th>Title</th>
                <th>Borrowed Times</th>
            </tr>
            <%
                for (String[] item : mostBorrowed3Months) {
            %>
            <tr>
                <td><%= item[1] %>
                </td>
                <td><%= item[0] %>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <button type="button" class="collapsible">Users who borrowed the most borrowed book</button>
    <div class="content">
        <table>
            <tr>
                <th>Username</th>
            </tr>
            <%
                for (String[] item : users) {
            %>
            <tr>
                <td><%= item[0] %>
                </td>

            </tr>

            <%
                }
            %>
        </table>
    </div>
    <button type="button" class="collapsible">Overdue Books</button>
    <div class="content">
        <table>
            <tr>
                <th>Title</th>
                <th>Borrowed Times</th>
            </tr>
            <%
                for (String[] item : overdueBooks) {
            %>
            <tr>
                <td><%= item[1] %>
                </td>
                <td><%= item[0] %>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <button type="button" class="collapsible">Publishers has most borrowed books</button>
    <div class="content">
        <table>
            <tr>
                <th>Publisher</th>
                <th>Borrowed Times</th>
            </tr>
            <%
                for (String[] item : publishers) {
            %>
            <tr>
                <td><%= item[1] %>
                </td>
                <td><%= item[0] %>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <button type="button" class="collapsible">Overdue Times</button>
    <div class="content">
        <table>
            <tr>
                <th>Overdue Times</th>
            </tr>
            <tr>
                <td><%=overdue%>
                </td>
            </tr>
        </table>
    </div>
    <%
    } else {
    %>
    <p>Not Allowed</p>
    <%
        }
    %>
</div>

<script>
    var coll = document.getElementsByClassName("collapsible");
    var i;

    for (i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var content = this.nextElementSibling;
            if (content.style.display === "block") {
                content.style.display = "none";
            } else {
                content.style.display = "block";
            }
        });
    }
</script>

</body>
</html>
