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
            PreparedStatement stmt = conn.prepareStatement("Select * FROM USERS");
            ResultSet rs = stmt.executeQuery("Select * FROM USERS");
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
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO USERS (`Nric`, `Name`, `Class`, `Group`, `Respect_Level`, "
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
    
    public User getUserByNric(String nric){
        for(User u: userList){
            if(nric == u.getNric()) return u;
        }
        return null;
    }
    
    public ArrayList<User> getUsersByClass(String userClass){
        ArrayList<User> sortedUserList = new ArrayList<>();
        for(User u : userList){
            if(u.getUserClass().equals(userClass)){
                sortedUserList.add(u);
            }
        }
        return sortedUserList;
    }
    
    public ArrayList<User> getUsersByClassAndGroup(String userClass, String userGroup){
        ArrayList<User> sortedUserList = new ArrayList<>();
        for(User u : userList){
            if(u.getUserClass().equals(userClass) && u.getGroupList().contains(userGroup)){
                sortedUserList.add(u);
            }
        }
        return sortedUserList;
    }
    
    public ArrayList<String> getGroupsByClass(String userClass){
        ArrayList<String> groupList = new ArrayList<String>();
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("SELECT DISTINCT `Group` FROM USERS WHERE Class LIKE ?");
            stmt.setString(1, userClass);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                String[] result = rs.getString(1).split(",");
                for(String s: result){
                    if(!groupList.contains(s.trim())){
                        groupList.add(s.trim());
                    }
                }
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return groupList;
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
    
    public static ArrayList<String> getAllClasses(){
        ArrayList<String> result = new ArrayList<String>();
        try(Connection conn = ConnectionManager.getConnection();){
            String query = "SELECT DISTINCT Class FROM USERS";
            ResultSet rs = conn.createStatement().executeQuery(query);
            while(rs.next()){
                result.add(rs.getString(1));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return result;
    }
    
    public boolean createNewGroup(String subject, String groupName, String[] members){
        boolean querySuccessful = false;
        if(null == subject || null == groupName || "".equals(subject) || "".equals(groupName) || members.length == 0){
            return false;
        }
        String group = "," + subject + " " + groupName;
        String sql = "UPDATE USERS SET `Group` = CONCAT(`Group`, ?) WHERE NRIC LIKE ?";
        int counter = 1;
        while(counter < members.length){
            sql = sql + " OR NRIC LIKE ?";
            counter++;
        }
        counter = 0;
        try(Connection conn = ConnectionManager.getConnection();){
            conn.setAutoCommit(false);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(++counter, group);
            while(counter <= members.length){
                stmt.setString(++counter, members[counter-2]);
            }
            int updatedRows = stmt.executeUpdate();
            querySuccessful = (members.length == updatedRows);
            if(!querySuccessful){
                conn.rollback();
                conn.setAutoCommit(true);
            }
            else{
                conn.commit();
                conn.setAutoCommit(true);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return querySuccessful;
    }
    
    public boolean updateGroup(String selectedClass, String selectedGroup, ArrayList<String> addToGroup, ArrayList<String> removeFromGroup){
        boolean querySuccessful = false;
        querySuccessful = addToGroup(selectedClass, selectedGroup, addToGroup) && removeFromGroup(selectedClass, selectedGroup, removeFromGroup);
        return querySuccessful;
    }
    
    private boolean addToGroup(String selectedClass, String selectedGroup, ArrayList<String> addToGroup){
        boolean querySuccessful = false;
        if(null == selectedClass || null == selectedGroup || "".equals(selectedClass) || "".equals(selectedGroup) || addToGroup.size() == 0){
            return true;
        }
        String group = "," + selectedGroup;
        String sql = "UPDATE USERS SET `Group` = CONCAT(`Group`, ?) WHERE NRIC LIKE ?";
        int counter = 1;
        while(counter < addToGroup.size()){
            sql = sql + " OR NRIC LIKE ?";
            counter++;
        }
        counter = 0;
        try(Connection conn = ConnectionManager.getConnection();){
            conn.setAutoCommit(false);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(++counter, group);
            while(counter <= addToGroup.size()){
                stmt.setString(++counter, addToGroup.get(counter-2));
            }
            int updatedRows = stmt.executeUpdate();
            querySuccessful = (addToGroup.size() == updatedRows);
            if(!querySuccessful){
                conn.rollback();
                conn.setAutoCommit(true);
            }
            else{
                conn.commit();
                conn.setAutoCommit(true);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return querySuccessful;
    }
    
    private boolean removeFromGroup(String selectedClass, String selectedGroup, ArrayList<String> removeFromGroup){
        boolean querySuccessful = false;
        if(null == selectedClass || null == selectedGroup || "".equals(selectedClass) || "".equals(selectedGroup) || removeFromGroup.size() == 0){
            return true;
        }
        String group = "," + selectedGroup;
        String sql = "UPDATE USERS SET `Group` = REPLACE(`Group`, ?, \"\") WHERE NRIC LIKE ?";
        int counter = 1;
        while(counter < removeFromGroup.size()){
            sql = sql + " OR NRIC LIKE ?";
            counter++;
        }
        counter = 0;
        try(Connection conn = ConnectionManager.getConnection();){
            conn.setAutoCommit(false);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(++counter, group);
            while(counter <= removeFromGroup.size()){
                stmt.setString(++counter, removeFromGroup.get(counter-2));
            }
            int updatedRows = stmt.executeUpdate();
            querySuccessful = (removeFromGroup.size() == updatedRows);
            if(!querySuccessful){
                conn.rollback();
                conn.setAutoCommit(true);
            }
            else{
                conn.commit();
                conn.setAutoCommit(true);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return querySuccessful;
    }
    
    public ArrayList<String> getRankedClassList(String userClass, int usersToReturn){
        ArrayList<String> rankedClassList = new ArrayList<String>();
        try(Connection conn = ConnectionManager.getConnection();){
            String sql = "SELECT t.User, SUM(t.Delta), u.`Class` FROM TRANSACTION_DETAILS as t, USERS as u WHERE t.User = u.Nric AND u.`Class` = ? GROUP BY User ORDER BY SUM(Delta) DESC LIMIT ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userClass);
            stmt.setInt(2, usersToReturn);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                String userId = rs.getString(1);
                rankedClassList.add(userId);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return rankedClassList;
    }
    
    public ArrayList<String> getAllGroups(){
        ArrayList<String> allGroups = new ArrayList<String>();
        for(User u: userList){
            for(String userGroup: u.getGroupList()){
                if(!allGroups.contains(userGroup)){
                    allGroups.add(userGroup);
                }
            }
        }
        return allGroups;
    }
}
