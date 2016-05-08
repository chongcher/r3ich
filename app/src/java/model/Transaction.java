/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import org.joda.time.DateTime;

/**
 *
 * @author ccchia.2014
 */
public class Transaction {
    private String staffID;
    private String userID;
    private int delta;
    private String reason;
    private DateTime timestamp;
    
    public Transaction(String staffID, String userID, int delta, String reason, String timestamp){
        this.staffID = staffID;
        this.userID = userID;
        this.delta = delta;
        this.reason = reason;
        this.timestamp = DateTime.parse(timestamp);
    }
}
