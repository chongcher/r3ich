package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Staff;
import java.util.ArrayList;
import java.util.Arrays;
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
        ArrayList<Staff> staff = new ArrayList<>();
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("SELECT Nric,Salutation,Name,Classes FROM STAFF");
            ResultSet rs = stmt.executeQuery();
            int counter = 0;
            if(rs.next()){
                String staffId = rs.getString(++counter);
                String staffSalutation = rs.getString(++counter);
                String staffName = rs.getString(++counter);
                ArrayList<String> staffClasses = new ArrayList(Arrays.asList(rs.getString(++counter).split(",")));
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
    
    public boolean login(String staffId, String candidate){
        try(Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = createLoginPreparedStatement(conn,staffId); 
                ResultSet rs = stmt.executeQuery();){
            if(rs.next()){
                return BCrypt.checkpw(candidate, rs.getString(1));
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
    
    private PreparedStatement createLoginPreparedStatement(Connection conn, String staffId) throws SQLException{
        PreparedStatement stmt = conn.prepareStatement("SELECT PasswordHash FROM STAFF WHERE Nric LIKE ?");
        stmt.setString(1, staffId);
        return stmt;
    }
}
