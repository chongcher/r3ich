package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Staff;
import java.util.ArrayList;
import org.joda.time.DateTime;
import org.mindrot.jbcrypt.BCrypt;
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
        //TODO read database
        return staff;
    }
    
    private boolean isPasswordExpired(){
        //TODO implement checking for password expiry (yearly)
        DateTime currentTime = DateTime.now();
        return (false);
    }
    
    public boolean login(String staffId, String candidate){
        String hash;
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("SELECT PasswordHash FROM STAFF WHERE Nric LIKE ?");
            stmt.setString(1, staffId);
            System.out.println("staffDAO stmt: " + stmt);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                String passwordHash = rs.getString(1);
                return BCrypt.checkpw(candidate, passwordHash);
            }
            else{
                System.out.print("No results found");
            }
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
}
