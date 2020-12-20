package dao;

import db.ConnectionFactory;
import logic.HashChecker;
import model.Role;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDaoImpl implements UserDao {
    @Override
    public boolean isExist(String login, String password) {
        Connection connection = ConnectionFactory.getConnection();

        try (PreparedStatement preparedStatement = connection
                .prepareStatement(
                        "select login, password from users where login = ? and password = ?"
                )) {
            preparedStatement.setString(1, login);
            preparedStatement.setString(2, HashChecker.getHash(password));
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet != null && resultSet.next()) {
                System.out.println("Login: " + resultSet.getString("login") + "\n"
                        + "Password: " + resultSet.getString("password"));
                return true;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return false;
    }

    @Override
    public Role getRoleByLoginPassword(String login, String password) {
        Connection connection = ConnectionFactory.getConnection();
        try (PreparedStatement preparedStatement = connection
                .prepareStatement(
                        "select b.role as \"role\" from users a " +
                                "inner join roles b on a.role_id=b.id " +
                                "where a.login = ? and a.password = ?"
                )) {
            preparedStatement.setString(1, login);
            preparedStatement.setString(2, HashChecker.getHash(password));

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet != null && resultSet.next()) {
                return Role.valueOf(resultSet.getString("role").toUpperCase());
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return Role.DEFAULT;
    }
}
