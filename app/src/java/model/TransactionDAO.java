/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Transaction;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import utility.ConnectionManager;

/**
 *
 * @author ccchia.2014
 */
public class TransactionDAO {
    ArrayList<Transaction> allTransactions;
    
    private ArrayList<Transaction> readDatabase(){
        ArrayList<Transaction> allTransactions = new ArrayList<>();
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("Select * from TRANSACTIONS");
            ResultSet rs = stmt.executeQuery();
            int counter = 0;
            while(rs.next()){
                String staffID = rs.getString(++counter);
                String userID = rs.getString(++counter);
                int delta = rs.getInt(++counter);
                String reason = rs.getString(++counter);
                String timestamp = rs.getString(++counter);
                allTransactions.add(new Transaction(staffID,userID,delta,reason,timestamp));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return allTransactions;
    }
    
    public boolean newTransaction(String requestStaffID,String requestUserID,
            String requestDelta,String requestReason,DateTime requestTimestamp) throws SQLException{
        boolean success = false;
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO TRANSACTION_DETAILS (`Staff`, `User`, `Delta`, `Reason`, `Transaction_DateTime`) VALUES (?, ?, ?, ?, ?);");
            stmt.setString(1, requestStaffID);
            stmt.setString(2, requestUserID);
            stmt.setInt(3, Integer.parseInt(requestDelta));
            stmt.setString(4, requestReason);
            DateTimeFormatter dtf = DateTimeFormat.forPattern("Y-MM-d HH:mm:ss");
            stmt.setString(5, requestTimestamp.toString(dtf));
            if(stmt.executeUpdate() == 1) success = true;
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return success;
    }
    
    public int getTotalPoints(String userID){
        int totalPoints = 0;
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("SELECT SUM(Delta) FROM (SELECT * FROM TRANSACTION_DETAILS WHERE `User` = ?) as temp");
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                int queryResult = rs.getInt(1);
                if(queryResult > totalPoints) totalPoints = queryResult;
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return totalPoints;
    }
}
