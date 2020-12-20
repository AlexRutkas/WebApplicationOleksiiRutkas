<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>

<%@ page isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Connection connection;
    PreparedStatement pst;
    ResultSet resultSet;
    Integer id;

    if (request.getParameter("submit") != null) {
        String name = request.getParameter("name");
        id = Integer.valueOf(request.getParameter("id"));
        int salary = Integer.valueOf(request.getParameter("salary"));
        connection = ConnectionFactory.getConnection();

        try {

            pst = connection.prepareStatement("update positions set name = ?, salary = ? where id = ?");
            pst.setInt(3, Integer.valueOf(id));
            pst.setString(1, name);
            pst.setInt(2, salary);
            pst.executeUpdate();
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        response.sendRedirect("/posits");
    }

%>

<fmt:setBundle basename="message" />
<fmt:setLocale value="${cookie['lang'].value}" scope="application"/>

<html>
<head>
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
                    pst = connection.prepareStatement("select * from positions where id = ? ");
                    pst.setInt(1, id);
                    resultSet = pst.executeQuery();
                    while (resultSet.next()) {
            %>

            </br>
            <div align="left">
                <label class="form-label"><fmt:message key="positions.posit"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="positions.posit"/> value="<%=resultSet.getString("name")%>" name="name" id="name" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="positions.salary"/></label>
                <input type="number" class="form-control" placeholder=<fmt:message key="positions.salary"/> value="<%=resultSet.getInt("salary")%>" name="salary" id="salary" required>
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
