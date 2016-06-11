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
            PreparedStatement stmt = conn.prepareStatement("Select * FROM users");
            ResultSet rs = stmt.executeQuery("Select * FROM users");
            while(rs.next()){
                int counter = 0;
                String nric = rs.getString(++counter);
                String name = rs.getString(++counter);
                String userClass = rs.getString(++counter);
                String userGroup = rs.getString(++counter);
                int respectLevel = rs.getInt(++counter);
                int resilienceLevel = rs.getInt(++counter);
                int responsibilityLevel = rs.getInt(++counter);
                int integrityLevel = rs.getInt(++counter);
                int careLevel = rs.getInt(++counter);
                int harmonyLevel = rs.getInt(++counter);
                tempUserList.add(new User(nric,name,userClass,userGroup,
                        respectLevel,resilienceLevel,responsibilityLevel,integrityLevel,careLevel,harmonyLevel));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return tempUserList;
    }
    
    public Boolean addNewUser(String userNric, String userName, String userClass){
        int updatedRows = -1;
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (`Nric`, `Name`, `Class`, `Group`, `Respect_Level`, "
                    + "`Resilience_Level`, `Responsibility_Level`, `Integrity_Level`, `Care_Level`, `Harmony_Level`) VALUES (?,?,?,?,?,?,?,?,?,?)");
            stmt.setString(1, userNric);
            stmt.setString(2, userName);
            stmt.setString(3, userClass);
            stmt.setString(4, "");
            stmt.setInt(5, 0);
            stmt.setInt(6, 0);
            stmt.setInt(7, 0);
            stmt.setInt(8, 0);
            stmt.setInt(9, 0);
            stmt.setInt(10, 0);
            updatedRows = stmt.executeUpdate();
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return (1 == updatedRows);
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
    
    public String getName(String userId){
        for(User u : userList){
            if(userId.equals(u.getNric())) return u.getName();
        }
        return null;
    }
    
    public String getClass(String userId){
        for(User u : userList){
            if(userId.equals(u.getNric())) return u.getUserClass();
        }
        return null;
    }
    
    public Boolean exists(String userId){
        for(User u: userList){
            if(userId.equals(u.getNric())){
                return true;
            }
        }
        return false;
    }
}
