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
import java.util.Arrays;
import java.util.HashMap;
import utility.ConnectionManager;

/**
 *
 * @author ccchia.2014
 */
public class SkillDAO {
    HashMap<String, ArrayList<Skill>> skillTree;
    
    public SkillDAO(){
        skillTree = readDatabase();
    }
    
    private HashMap<String, ArrayList<Skill>> readDatabase(){
        HashMap<String, ArrayList<Skill>> skillTree = new HashMap<String, ArrayList<Skill>>();
        try(Connection conn = ConnectionManager.getConnection();){
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM SKILLS ORDER BY Skill_Class_Level ASC");
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                String description = rs.getString(1);
                String type = rs.getString(2);
                int level = rs.getInt(3);
                if(!skillTree.containsKey(type)){
                    ArrayList<Skill> temp = new ArrayList<Skill>();
                    temp.add(new Skill(type, level, description));
                    skillTree.put(type, temp);
                }
                else{
                    ArrayList<Skill> temp = skillTree.get(type);
                    temp.add(new Skill(type, level, description));
                    skillTree.put(type, temp);
                }
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return skillTree;
    }
    
    public ArrayList<Skill> getSkillByType(String type){
        return skillTree.get(type);
    }
    
    public ArrayList<String> getSkillTypes(){
        ArrayList<String> skillTypes = new ArrayList<String>();
        skillTypes.add("Respect");
        skillTypes.add("Resilience");
        skillTypes.add("Responsibility");
        skillTypes.add("Integrity");
        skillTypes.add("Care");
        skillTypes.add("Harmony");
        return skillTypes;
    }
}
