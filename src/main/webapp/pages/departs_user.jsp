<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>
<%@ page import="java.util.Locale" %>

<fmt:setBundle basename="message"/>

<html>

<head>
    <title><fmt:message key="site_title"/></title>
    <style>
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>



<div style="padding: 20px">
    <h1><fmt:message key="site_title"/></h1>
    <div class="row">
        <div class="col-sm-1">
        </div>
        <div class="col-sm-10">
                <table border="3" cellpadding="20" cellspacing="0" width="100%">
                    <thead>
                    <tr>
                        <th width="10%"><fmt:message key="entity.number"/></th>
                        <th width="20%"><fmt:message key="entity.title"/></th>
                        <th width="25%"><fmt:message key="entity.descr"/></th>
                        <th width="40%"><fmt:message key="entity.emploeers"/></th>
                        <th width="5%"> <fmt:message key="entity.count"/></th>
                    </tr>

                        <%
                        Connection connection = ConnectionFactory.getConnection();
                        ResultSet resultSet;

                        try {

                    resultSet = connection.createStatement()
                           .executeQuery("select d.num, d.name as title, d.descr, e.name, e.surname, p.name as posn from departments d left join emploeers e on d.id = e.departmentid " +
                            " left join positions p on p.id = e.positionid order by num");
                    int i;
                    boolean f=resultSet.next();
                     while (f) {
                      i=  resultSet.getInt("num");
                                           %>
                    <tr>
                        <td align="center"><%=resultSet.getInt("num")%>
                        </td>
                        <td><%=resultSet.getString("title")%>
                        </td>
                        <td><%=resultSet.getString("descr")%>
                        </td>

                        <td align="center">
                        <%
                        int count=0;
                        while (i == resultSet.getInt("num")) {
                         String s=resultSet.getString("name");
                         if(s!=null)  {
                             out.println(s+"  "+resultSet.getString("surname")+" <b>("+resultSet.getString("posn")+")</b>, ");
                             count++;
                            }
                         f=resultSet.next();
                         if(!f)  break;
                         }
                            %>

                         </td>
                         <td align="center"><%=count%> </td>
                         </tr>

                        <%
                            }
                            connection.close();
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                    %>
                </table>
        </div>
    </div>


    <form action="/logout" method="get">
        <input type="submit" value=<fmt:message key="user.logout"/>
               name="Submit" id="frm1_submit" />
    </form>

</div>
</body>
</html>
