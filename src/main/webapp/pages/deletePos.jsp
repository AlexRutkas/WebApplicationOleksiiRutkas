<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>

<%
    Integer id = Integer.valueOf(request.getParameter("id"));
    Connection connection;
    PreparedStatement pst;
    ResultSet resultSet;

    connection = ConnectionFactory.getConnection();
    try {
        pst = connection.prepareStatement("delete from positions where id = ?");
        pst.setInt(1, id);
        pst.executeUpdate();
        connection.close();
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
    response.sendRedirect("/posits");
%>

<html>
<body>


