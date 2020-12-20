<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    boolean msgError=false;
    String dnum="0";

        if (request.getParameter("submit") != null) {
        String dname = request.getParameter("dname");
        String descr = request.getParameter("descr");
                dnum = request.getParameter("dnum");
        Connection connection = null;
        PreparedStatement pst;
        ResultSet resultSet;

        connection = ConnectionFactory.getConnection();
        try {
            pst = connection.prepareStatement("select num from departments where num =?");
            Integer n = Integer.valueOf(dnum);
            pst.setInt(1, n);
            resultSet=pst.executeQuery();
            if(!resultSet.next()) {
                pst = connection.prepareStatement("insert into departments(num, name, descr) values (?,?,?)");
                pst.setString(3, descr);
                pst.setString(2, dname);
                n = Integer.valueOf(dnum);
                pst.setInt(1, n);
                pst.executeUpdate();
            }else
                msgError=true;

            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
    else msgError=false;
%>
<fmt:setBundle basename="message" />
<fmt:setLocale value="${cookie['lang'].value}" scope="application"/>

<html>
<head>
    <title><fmt:message key="site_title" /></title>
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
                    <label class="form-label"><fmt:message key="entity.number"/></label>
                    <input type="number" class="form-control" placeholder=<fmt:message key="entity.number"/> name="dnum" id="dnum"
                           required>
                </div>
                <div align="left">
                    <label class="form-label"><fmt:message key="entity.dname"/></label>
                    <input type="text" class="form-control" placeholder=<fmt:message key="entity.dname"/> name="dname" id="dname" required>
                </div>
                <div align="left">
                    <label class="form-label"><fmt:message key="entity.descr"/></label>
                    <input type="text" class="form-control" placeholder=<fmt:message key="entity.descr"/> name="descr" id="descr" required>
                </div>
                </br>
                <div align="rigth">
                    <input type="submit" id="submit" value=<fmt:message key="button.submit"/> name="submit" class="btn btn-info">
                    <input type="reset" id="reset" value=<fmt:message key="button.cancel"/> name="reset" class="btn btn-warning">
                    <% if(msgError){ %> <img src="../images/error.png" alt="Error" width="64"><%=dnum+"   "%><fmt:message key="error.ex_dep"/>
                            <% } %>
                </div>
            </form>
        </div>


        <div class="col-sm-6">
            <div class="panel-body">
                <table id="tbl-subjects" class="table table-responsive table-bordered" cellpadding="0" width="100%">
                    <thead>
                    <tr>
                        <th><fmt:message key="entity.number"/></th>
                        <th><fmt:message key="entity.dname"/></th>
                        <th><fmt:message key="entity.descr"/></th>
                        <th><fmt:message key="data.edit"/></th>
                        <th><fmt:message key="data.delete"/></th>
                    </tr>

                        <%
                        Connection connection = ConnectionFactory.getConnection();
                        ResultSet resultSet;

                        try {
                            resultSet = connection.createStatement().executeQuery("select * from departments order by num");

                            while (resultSet.next()) {
                                %>
                    <tr>
                        <td align="center"><%=resultSet.getInt("num")%>
                        </td>
                        <td><%=resultSet.getString("name")%>
                        </td>
                        <td><%=resultSet.getString("descr")%>
                        </td>

                        <td align="center"><a href="/update?id=<%=resultSet.getInt("id")%>"><img
                                src="../images/edit.png" alt="Edit" width="24"></a></td>
                        <td align="center"><a href="/delete?id=<%=resultSet.getInt("id")%>"><img
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

                <a href="/emplos" id="emplos" name="emplos" class="btn btn-info"><fmt:message key="button.emplos"/></a>
                <a href="/posits" id="posits" name="posits" class="btn btn-info"><fmt:message key="button.posits"/></a>

            </div>
        </div>
    </div>
</div>

<div>
    <h5>
        <fmt:message key="cookie.ChooseLocale" />
    </h5>
    <ul>

        <li><a href="confirm?cookieLocale=en_US"><fmt:message key="lang.en" /></a></li>
        <li><a href="confirm?cookieLocale=uk_UA"><fmt:message key="lang.ua" /></a></li>
        <li><a href="confirm?cookieLocale=de_DE"><fmt:message key="lang.de" /></a></li>
    </ul>
</div>

<div id="report_div">
    <p><a href="/getPdfFile" target="_blank">Get report in PDF</a></p>
    <p><a href="/downloadJson">Отримати звіт-файл у форматі JSON</a></p>
</div>

<form action="/logout" method="get">
    <input type="submit" value=<fmt:message key="user.logout"/> id="frm1_submit" />
</form>

</body>
</html>
