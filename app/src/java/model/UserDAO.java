package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;
import java.util.ArrayList;
import utility.ConnectionManager;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccchia.2014
 */
public class UserDAO {
    private ArrayList<User> userList;
    
    public UserDAO(){
        userList = readDatabase();
    }
    
    private ArrayList<User> readDatabase(){
        ArrayList<User> tempUserList = new ArrayList<>();
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("Select * from USERS");
            ResultSet rs = stmt.executeQuery("Select * from USERS");
            int counter = 0;
            while(rs.next()){
                String nric = rs.getString(++counter);
                String name = rs.getString(++counter);
                String userClass = rs.getString(++counter);
                String userGroup = rs.getString(++counter);
                tempUserList.add(new User(nric,name,userClass,userGroup));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return tempUserList;
    }
    
    public ArrayList<User> getUsersByClass(String userClass){
        ArrayList<User> sortedUserList = new ArrayList<>();
        for(User u : userList){
            if(userClass.equals(u.getUserClass())){
                sortedUserList.add(u);
            }
        }
        return sortedUserList;
    }
}
