
import java.util.ArrayList;
import org.joda.time.DateTime;

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
    
    private boolean login(String username, String password){
        //TODO implement password checking
        return false;
    }
}
