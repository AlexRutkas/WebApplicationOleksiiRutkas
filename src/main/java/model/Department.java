package model;

public class Department {
    private int id;
    private int number;
    private String name;
    private String descr;

    public Department() {
    }

    public Department(int id, int number, String name, String descr) {
        this.id = id;
        this.number = number;
        this.name = name;
        this.descr = descr;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }


}
