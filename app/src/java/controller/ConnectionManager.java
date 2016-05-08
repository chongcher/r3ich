/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.sql.*;


/**
 *
 * @author ccchia.2014
 */
public class ConnectionManager {
    private static final String DRIVER_NAME = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost/r3ise";
    
    static{
        try{
            Class.forName(DRIVER_NAME).newInstance();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException{
        return DriverManager.getConnection(URL,"root","");
    }
}
