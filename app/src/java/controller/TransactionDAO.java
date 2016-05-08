/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Transaction;
import org.joda.time.DateTime;

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
            String requestDelta,String requestReason,DateTime requestTimestamp){
        //TODO add new transaction
        return false;
    }
}
