<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.EmploeerDaoImpl" %>
<%@ page import="dao.DepartDaoImpl" %>

<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.PositionDao" %>
<%@ page import="model.Position" %>
<%@ page import="dao.PositionDaoImpl" %>
<%@ page import="java.util.LinkedList" %>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>

<%
    boolean msgError=false;
    PositionDao positionDao=new PositionDaoImpl();

    if (request.getParameter("submit") != null) {
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String profession = request.getParameter("profession");
        String age = request.getParameter("age");
        String number = request.getParameter("number");
        String position = request.getParameter("position");

        Connection connection = ConnectionFactory.getConnection();
        PreparedStatement pst;
        ResultSet resultSet;


        try {

            pst = connection.prepareStatement("select id from departments where num =?");
            int n = Integer.valueOf(number);
            pst.setInt(1, n);
            resultSet = pst.executeQuery();

            if (resultSet.next()) {

                int depid = resultSet.getInt("id");
                pst = connection.prepareStatement("insert into emploeers(name, surname, age,profession,departmentid, positionid ) values (?,?,?,?,?,?)");
                pst.setString(1, name);
                pst.setString(2, surname);
                n = Integer.valueOf(age);
                pst.setInt(3, n);
                pst.setString(4, profession);
                pst.setInt(5, depid);
                n = positionDao.getIdByName(position);
                pst.setInt(6, n);
                pst.executeUpdate();
                msgError=false;
                connection.close();
                response.sendRedirect("/emplos");
            }
            else msgError=true;
             }catch (SQLException throwables) {
                throwables.printStackTrace();
            }
    }

%>

<fmt:setBundle basename="message" />

<html>
<head>
    <title>emploeers</title>
    <style>
        @import "../styles/dropbox.css";
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>

<div>
<h1><fmt:message key="entity.emploeers"/></h1>
<a href="/emplos?page=0">All</a>
<c:forEach var = "i" begin = "1" end = "${pages}">
    <a href="?page=${i}">Page <c:out value = "${i}"/></a>
</c:forEach>

<div class="row">
  <div class="col-sm-1">
  </div>
    <div class="col-sm-6">
        <br>
        <br>
        <br>
        <br>
        <table  class="table table-bordered table-responsive" border="2" cellpadding="0"  align="center">
            <tr>
                <th><fmt:message key="emploeer.name"/></th>
                <th><fmt:message key="emploeer.surname"/></th>
                <th><fmt:message key="emploeer.age"/></th>
                <th><fmt:message key="emploeer.profession"/></th>
                <th><fmt:message key="entity.dname"/></th>
                <th><fmt:message key="emploeer.position"/></th>
                <th><fmt:message key="data.edit"/></th>
                <th><fmt:message key="data.delete"/></th>
            </tr>
            <jsp:useBean id="emploeerList" scope="request" type="java.util.List"/>
            <c:forEach items="${emploeerList}" var="emploeer">
                <tr>
                    <td>${emploeer.name}</td>
                    <td>${emploeer.surname}</td>
                    <td>${emploeer.age}</td>
                    <td>${emploeer.profession}</td>
                    <td>${emploeer.department}</td>
                    <td>${emploeer.position}</td>

                    <td align="center"><a href="/updateE?id=${emploeer.id}"><img
                            src="../images/edit.png" alt="Edit" width="24"></a></td>
                    <td align="center"><a href="/deleteE?id=${emploeer.id}"><img
                            src="../images/delete.png" alt="Delete" width="24"></a></td>
                </tr>
            </c:forEach>
        </table>
        <a href="/departs" id="departs" name="departs" class="btn btn-info"><fmt:message key="button.departs"/></a>
     </div>



    <div class="col-sm-4">
        <h2><fmt:message key="data.add" /></h2>
        <form accept-charset="UTF-8" method="post"  action="#">
            </br>
            <div align="left">
                <label class="form-label"><fmt:message key="emploeer.name"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="emploeer.name"/> name="name" id="name"
                       required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="emploeer.surname"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="emploeer.surname"/> name="surname" id="surname" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="emploeer.age"/></label>
                <input type="number" class="form-control" placeholder=<fmt:message key="emploeer.age"/> name="age" id="age" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="emploeer.profession"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="emploeer.profession"/> name="profession" id="profession" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="entity.number"/></label>
                <input type="number" class="form-control" placeholder=<fmt:message key="entity.number"/> name="number" id="number" required>
            </div>

            <div align="left">
            <label class="form-label"><fmt:message key="emploeer.position"/></label>
                <br>

               <select class="form-control" name="position" id="position" required>
              <%
              List<Position> positions=positionDao.getAllPositions();
                  for (Position position:positions) {
                  %>
//drop down list
                    <option value="<%=position.getName()%>" selected><%=position.getName()%> </option>
                   <%}%>
                </select>
            </div>
            </br>
            <div align="rigth">
                <input type="submit" id="submit" value=<fmt:message key="button.submit"/> name="submit" class="btn btn-info">
                <input type="reset" id="reset" value=<fmt:message key="button.cancel"/> name="reset" class="btn btn-warning">
                <% if(msgError){ %> <img src="../images/error.png" alt="Error" width="64"><fmt:message key="error.no_dep"/>
                <% } %>
            </div>
        </form>
    </div>

</div>
</div>
</body>
</html>
