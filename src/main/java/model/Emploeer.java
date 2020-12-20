package model;

import java.util.List;

public class Emploeer {
    private int id;
    private String name;
    private String surname;
    private int age;
    private String profession;
    private String department;
    private String position;

    public Emploeer(int id, String name, String surname, int age, String profession, String department, String position) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.age = age;
        this.profession = profession;
        this.department = department;
        this.position = position;
    }

    public Emploeer() {
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

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getdepartment() {
        return department;
    }


    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @Override
    public String toString() {
        return "Emploeer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", age=" + age +
                ", profession='" + profession + '\'' +
                ", department='" + department + '\'' +
                ", position='" + position + '\'' +
                '}';
    }
}
