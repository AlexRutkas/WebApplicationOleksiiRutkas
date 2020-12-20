package dao;

import db.ConnectionFactory;
import model.Department;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DepartDaoImpl implements DepartDao {
    @Override
    public List<Department> listDepartment() {

        List<Department> list = new ArrayList<>();

        PreparedStatement pst;
        ResultSet resultSet;

        try {
           Connection connection = ConnectionFactory.getConnection();
            resultSet = connection.createStatement().executeQuery("select * from departments order by id");

            while (resultSet.next()) {
                Department department = new Department();
                department.setId(resultSet.getInt("id"));
                department.setNumber(resultSet.getInt("num"));
                department.setName(resultSet.getString("name"));
                department.setDescr(resultSet.getString("descr"));
                list.add(department);
            }
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return list;
    }
}
