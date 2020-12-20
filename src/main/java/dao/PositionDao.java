package dao;

import model.Position;
import java.util.List;

public interface PositionDao {
    List<Position> getAllPositions();
    int getRecordsCount();
    public Position getPositionById (int id);
    public int getIdByName (String name);
}
