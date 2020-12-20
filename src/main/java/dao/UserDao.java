package dao;

import model.Role;

public interface UserDao {
    boolean isExist(String login, String password);
    Role getRoleByLoginPassword(String login, String password);
}
