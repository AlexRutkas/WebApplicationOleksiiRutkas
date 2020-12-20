<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>
<%@ page import="model.Position" %>
<%@ page import="java.util.List" %>

<%@ page isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Connection connection;
    PreparedStatement pst;
    ResultSet resultSet;
    Integer id;
    if (request.getParameter("submit") != null) {
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        int age = Integer.valueOf(request.getParameter("age"));
        String profession = request.getParameter("profession");
        id = Integer.valueOf(request.getParameter("id"));


        try {
            connection = ConnectionFactory.getConnection();
            pst = connection.prepareStatement("update emploeers set name=?, surname=?, age=?,profession=? where id = ?");


            pst.setString(1, name);
            pst.setString(2, surname);
            pst.setInt(3,age );
            pst.setString(4, profession);
            pst.setInt(5, id);

            pst.executeUpdate();
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        response.sendRedirect("/emplos");
    }

%>

<fmt:setBundle basename="message" />
<fmt:setLocale value="${cookie['lang'].value}" scope="application"/>

<html>
<head>
<%--    <meta charset="utf-8">--%>
    <title>Редагування</title>
    <style>
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>

<div style="padding: 20px">

<h1><fmt:message key="data.update"/></h1>
<div class="row">
    <div class="col-sm-4">
        <form method="post" action="#">

            <%

                connection = ConnectionFactory.getConnection();
                try {
                    id = Integer.valueOf(request.getParameter("id"));
                    pst = connection.prepareStatement("select * from emploeers where id = ? ");
                    pst.setInt(1, id);
                    resultSet = pst.executeQuery();
                    while (resultSet.next()) {
            %>

            </br>
            <div align="left">
                <label class="form-label"><fmt:message key="emploeer.name"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="emploeer.name"/> value= <%=resultSet.getString("name")%> name="name" id="name"
                       required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="emploeer.surname"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="emploeer.surname"/>  value=<%=resultSet.getString("surname")%> name="surname" id="surname" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="emploeer.age"/></label>
                <input type="number" class="form-control" placeholder=<fmt:message key="emploeer.age"/> value= <%=resultSet.getInt("age")%> name="age" id="age" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="emploeer.profession"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="emploeer.profession"/> value=<%=resultSet.getString("profession")%> name="profession" id="profession" required>
            </div>

            <%
                    }
                    connection.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            %>
            </br>
            <div align="rigth">
                <input type="submit" id="submit" value=<fmt:message key="button.submit"/> name="submit" class="btn btn-info">
                <input type="reset" id="reset" value=<fmt:message key="button.cancel"/> name="reset" class="btn btn-warning" onclick="location.href='/departs'">
            </div>
        </form>
    </div>
</div>
</div>
</body>
</html>
