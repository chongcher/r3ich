package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import utility.BCrypt;
import utility.ConnectionManager;

/**
 *
 * @author chiachongcher
 */
public class StaffDAO {
    private ArrayList<Staff> staff;
    
    public StaffDAO(){
        staff = readDatabase();
    }
    
    private ArrayList<Staff> readDatabase(){
        ArrayList<Staff> staff = new ArrayList<Staff>();
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("SELECT Nric,Salutation,Name,Classes FROM STAFF");
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                int counter = 0;
                String staffId = rs.getString(++counter);
                String staffSalutation = rs.getString(++counter);
                String staffName = rs.getString(++counter);
                String classes = rs.getString(++counter);
                ArrayList<String> staffClasses = new ArrayList();
                if(null != classes && !"".equals(classes)){
                    staffClasses = new ArrayList<String>(Arrays.asList(classes.split(",")));
                }
                staff.add(new Staff(staffId,staffSalutation,staffName,staffClasses));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return staff;
    }
    
    private boolean isPasswordExpired(){
        //TODO implement checking for password expiry (yearly)
        DateTime currentTime = DateTime.now();
        return (false);
    }
    
    /*public boolean login(String staffId, String candidate){
            System.out.println("StaffDAO login 0");
        try(Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = createLoginPreparedStatement(conn,staffId); 
                ResultSet rs = stmt.executeQuery();){
            System.out.println("StaffDAO login 1: " + candidate);
            if(rs.next()){
                System.out.println("StaffDAO login 2");
                String res = rs.getString(1);
                System.out.println("StaffDAO login 2: " + res + " bool: " + BCrypt.checkpw(candidate, res));
                return BCrypt.checkpw(candidate, res);
            }
            else{
                System.out.println("StaffDAO login else");
            }
        }
        catch (SQLException e){
            System.out.println("StaffDAO login 4: " + e.getMessage());
            e.printStackTrace();
        }
        return false; //if rs.next() != true
    }*/
    
    public boolean login(String staffId, String candidate){
        try{
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT PasswordHash FROM STAFF WHERE Nric LIKE ?");
            stmt.setString(1, staffId); 
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                String res = rs.getString(1);
                return BCrypt.checkpw(candidate, res);
            }
            stmt.close();
            conn.close();
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return false; //if rs.next() != true
    }

    public Staff retrieveStaff(String staffId) {
        for(Staff s: staff){
            if(staffId.equals(s.getNric())){
                return s;
            }
        }
        return null;
    }
    
    public Boolean changePassword(String staffId, String candidate){
        String newHash = BCrypt.hashpw(candidate, BCrypt.gensalt());
        Boolean committedTransaction = false;
        try(Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = createChangePasswordPreparedStatement(conn, staffId, newHash);){
            conn.setAutoCommit(false);
            int rowsUpdated = stmt.executeUpdate();
            if(rowsUpdated != 1){
                System.out.println("StaffDAO: changePassword() returned more than 1 row!\nstaffId == " + staffId + "\ncandidate: " + candidate);
            }
            else{
                conn.commit();
                committedTransaction = true;
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return committedTransaction;
    }
    
    private PreparedStatement createLoginPreparedStatement(Connection conn, String staffId) throws SQLException{
        PreparedStatement stmt = conn.prepareStatement("SELECT PasswordHash FROM STAFF WHERE Nric LIKE ?");
        stmt.setString(1, staffId);
        return stmt;
    }

    private PreparedStatement createChangePasswordPreparedStatement(Connection conn, String staffId, String candidate) throws SQLException{
        PreparedStatement stmt = conn.prepareStatement("UPDATE STAFF SET PasswordHash = ? WHERE Nric LIKE ?");
        stmt.setString(1, candidate);
        stmt.setString(2, staffId);
        return stmt;
    }

    public boolean addStaff(String staffUserName, String staffSalutation, String staffName, String newCandidate) {
        int updatedRows = -1;
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO STAFF (Nric, Salutation, Name, PasswordHash, Last_Updated) VALUES (?,?,?,?,?)");
            stmt.setString(1, staffUserName);
            stmt.setString(2, staffSalutation);
            stmt.setString(3, staffName);
            stmt.setString(4, BCrypt.hashpw(newCandidate, BCrypt.gensalt()));
            DateTimeFormatter dtf = DateTimeFormat.forPattern("Y-M-d");
            stmt.setString(5, DateTime.now().toString(dtf));
            updatedRows = stmt.executeUpdate();
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return (1 == updatedRows);
    }
}
