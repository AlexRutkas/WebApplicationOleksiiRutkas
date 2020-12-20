<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

        if (request.getParameter("submit") != null) {

        String name = request.getParameter("name");
        int salary = Integer.valueOf(request.getParameter("salary"));

        Connection connection = null;
        PreparedStatement pst;
        ResultSet resultSet;

        connection = ConnectionFactory.getConnection();
        try {


                pst = connection.prepareStatement("insert into positions(name, salary) values (?,?)");
                pst.setInt(2, salary);
                pst.setString(1, name);
                pst.executeUpdate();

            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

%>
<fmt:setBundle basename="message" />
<fmt:setLocale value="${cookie['lang'].value}" scope="application"/>

<html>
<head>
    <title><fmt:message key="positions.title" /></title>
    <style>
        @import "../styles/dropbox.css";
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>
<div style="padding: 20px">

    <h1><fmt:message key="data.add" /></h1>
    <div class="row">
        <div class="col-sm-4">
            <form method="post" action="#">
                </br>

                <div align="left">
                    <label class="form-label"><fmt:message key="positions.posit"/></label>
                    <input type="text" class="form-control" placeholder=<fmt:message key="positions.posit"/> name="name" id="name" required>
                </div>
                <div align="left">
                    <label class="form-label"><fmt:message key="positions.salary"/></label>
                    <input type="number" class="form-control" placeholder=<fmt:message key="positions.salary"/> name="salary" id="salary" required>
                </div>
                </br>
                <div align="rigth">
                    <input type="submit" id="submit" value=<fmt:message key="button.submit"/> name="submit" class="btn btn-info">
                    <input type="reset" id="reset" value=<fmt:message key="button.cancel"/> name="reset" class="btn btn-warning">

                </div>
            </form>
        </div>


        <div class="col-sm-6">
            <div class="panel-body">
                <table id="tbl-subjects" class="table table-responsive table-bordered" cellpadding="0" width="100%">
                    <thead>
                    <tr>
                        <th><fmt:message key="positions.posit"/></th>
                        <th><fmt:message key="positions.salary"/></th>
                        <th><fmt:message key="data.edit"/></th>
                        <th><fmt:message key="data.delete"/></th>
                    </tr>

                        <%
                        Connection connection = ConnectionFactory.getConnection();
                        ResultSet resultSet;

                        try {
                            resultSet = connection.createStatement().executeQuery("select * from positions order by name");

                            while (resultSet.next()) {
                                %>
                    <tr>
                        <td><%=resultSet.getString("name")%>
                        </td>
                        <td align="center"><%=resultSet.getInt("salary")%>
                        </td>

                        <td align="center"><a href="/updateP?id=<%=resultSet.getInt("id")%>"><img
                                src="../images/edit.png" alt="Edit" width="24"></a></td>
                        <td align="center"><a href="/deleteP?id=<%=resultSet.getInt("id")%>"><img
                                src="../images/delete.png" alt="Delete" width="24"></a></td>
                    </tr>

                        <%
                            }
                            connection.close();
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                    %>
                </table>
              <%--  <button id="emplos" name="emplos" class="btn btn-info"><fmt:message key="button.emplos"/></button>--%>
                <a href="/departs" id="departs" name="departs" class="btn btn-info"><fmt:message key="button.departs"/></a>

            </div>
        </div>
    </div>
</div>


<form action="/logout" method="get">
    <input type="submit" value=<fmt:message key="user.logout"/> id="frm1_submit" />
</form>

</body>
</html>
