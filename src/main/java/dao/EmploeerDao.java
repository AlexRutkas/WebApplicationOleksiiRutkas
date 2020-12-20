package dao;

import model.Emploeer;

import java.util.List;

public interface EmploeerDao {
    List<Emploeer> getAllEmploeers();
    List<Emploeer> getPageEmploeers(int pageNumber, int emploeersPerPage);
    int getRecordsCount();
    Emploeer getEmploeerById(int id);

}
