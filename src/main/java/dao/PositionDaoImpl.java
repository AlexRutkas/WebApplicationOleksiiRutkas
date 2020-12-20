package dao;

import db.ConnectionFactory;
import model.Position;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PositionDaoImpl implements PositionDao {
    
    @Override
    public List<Position> getAllPositions() {
        List<Position> list = new ArrayList<>();
        ResultSet resultSet;

        try (Connection connection = ConnectionFactory.getConnection()) {
            resultSet = connection.createStatement().executeQuery("select * from positions  order by name");
            while (resultSet.next()) {
                Position Position = new Position();
                Position.setId(resultSet.getInt("id"));
                Position.setName(resultSet.getString("name"));
                Position.setSalary(resultSet.getFloat("salary"));
               
                list.add(Position);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return list;
    }

    @Override
    public int getRecordsCount() {
        try (Connection connection = ConnectionFactory.getConnection()) {
            ResultSet resultSet = connection.createStatement().executeQuery("select count(*) from positions");
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
    public Position getPositionById (int id) {
        List<Position> positions=getAllPositions();
        for (Position position : positions) {
            if (position.getId()==id) {
                return position;
            }
        }
        return null;
    }
    @Override
    public int getIdByName (String name) {
        List<Position> positions=getAllPositions();
        for (Position position : positions) {
            if (position.getName().equals(name)) {
                return position.getId();
            }
        }
        return 0;
    }
}
