package dao;

import db.ConnectionFactory;
import model.Emploeer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmploeerDaoImpl implements EmploeerDao {
    @Override
    public List<Emploeer> getAllEmploeers() {
        List<Emploeer> list = new ArrayList<>();
        ResultSet resultSet;

        try (Connection connection = ConnectionFactory.getConnection()) {
            resultSet = connection.createStatement().executeQuery("select e.*, p.name as position,"+
                    " d.name as department from emploeers e  left join  departments d  on d.id = e.departmentid left join positions p on e.positionid = p.id order by departmentid,e.name");
            while (resultSet.next()) {
                Emploeer emploeer = new Emploeer();
                emploeer.setId(resultSet.getInt("id"));
                emploeer.setName(resultSet.getString("name"));
                emploeer.setSurname(resultSet.getString("surname"));
                emploeer.setProfession(resultSet.getString("profession"));
                emploeer.setDepartment(resultSet.getString("department"));
                emploeer.setAge(resultSet.getInt("age"));
                emploeer.setPosition(resultSet.getString("position"));
                list.add(emploeer);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Emploeer> getPageEmploeers(int pageNumber, int emploeersPerPage) {
        List<Emploeer> list = new ArrayList<>();
        ResultSet resultSet;

        try (Connection connection = ConnectionFactory.getConnection()) {
            PreparedStatement pst = connection.prepareStatement("select e.*, p.name as position, " +
                 " d.name as department from emploeers e  left join  departments d  on d.id = e.departmentid left join positions p on e.positionid = p.id order by departmentid,e.name limit ? offset ?");
            pst.setInt(1,emploeersPerPage);
            pst.setInt(2, (pageNumber - 1) * emploeersPerPage);
            resultSet = pst.executeQuery();
            while (resultSet.next()) {
                Emploeer emploeer = new Emploeer();
                emploeer.setId(resultSet.getInt("id"));
                emploeer.setName(resultSet.getString("name"));
                emploeer.setSurname(resultSet.getString("surname"));
                emploeer.setProfession(resultSet.getString("profession"));
                emploeer.setDepartment(resultSet.getString("department"));
                emploeer.setAge(resultSet.getInt("age"));
                emploeer.setPosition(resultSet.getString("position"));
                list.add(emploeer);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return list;
    }

    @Override
    public int getRecordsCount() {
        try (Connection connection = ConnectionFactory.getConnection()) {
            ResultSet resultSet = connection.createStatement().executeQuery("select count(*) from emploeers");
            int count = 0;
            if (resultSet.next())
                count = resultSet.getInt("count");
            return count;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return 0;
    }


    @Override
    public Emploeer getEmploeerById(int id) {
        return null;
    }
}
