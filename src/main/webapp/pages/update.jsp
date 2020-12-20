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
        String dnum = request.getParameter("dnum");
        String dname = request.getParameter("dname");
        String descr = request.getParameter("descr");
        id = Integer.valueOf(request.getParameter("id"));
        connection = ConnectionFactory.getConnection();

        try {

            pst = connection.prepareStatement("update departments set num = ?, name = ?, descr = ? where id = ?");
            pst.setInt(1, Integer.valueOf(dnum));
            pst.setString(2, dname);
            pst.setString(3, descr);
            pst.setInt(4, id);
            pst.executeUpdate();
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        response.sendRedirect("/departs");
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
                    pst = connection.prepareStatement("select * from departments where id = ? ");
                    pst.setInt(1, id);
                    resultSet = pst.executeQuery();
                    while (resultSet.next()) {
            %>

            </br>
            <div align="left">
                <label class="form-label"><fmt:message key="entity.number"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="entity.number"/> value="<%=resultSet.getInt("num")%>" name="dnum" id="dnum" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="entity.dname"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="entity.dname"/> value="<%=resultSet.getString("name")%>" name="dname" id="dname" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="entity.descr"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="entity.descr"/> value="<%=resultSet.getString("descr")%>" name="descr" id="descr" required>
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
