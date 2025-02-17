<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String id = session.getAttribute("id").toString();
%>
<style>
    body {
        font-family: "Lato", sans-serif;
    }

    .sidenav {
        height: 100%;
        width: 160px;
        position: fixed;
        z-index: 1;
        top: 0;
        left: 0;
        background-color: #111;
        overflow-x: hidden;
        padding-top: 20px;
    }

    .sidenav a {
        padding: 6px 8px 6px 16px;
        text-decoration: none;
        font-size: 25px;
        color: #818181;
        display: block;
    }

    .sidenav a:hover {
        color: #f1f1f1;
    }

    .main {
        margin-left: 160px; /* Same as the width of the sidenav */
        font-size: 28px; /* Increased text to enable scrolling */
        padding: 0px 10px;
    }

    @media screen and (max-height: 450px) {
        .sidenav {padding-top: 15px;}
        .sidenav a {font-size: 18px;}
    }
</style>
<div class="sidenav">
    <a href="${pageContext.request.contextPath}/publisher">Home</a>
    <a href="${pageContext.request.contextPath}/publisher/add-book">Add Book</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
</div>
