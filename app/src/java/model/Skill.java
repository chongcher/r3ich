/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author ccchia.2014
 */
public class Skill {
    private final String type;
    private final int level;
    private final String description;
    
    public Skill(String type, int level, String description){
        this.type = type;
        this.level = level;
        this.description = description;
    }
    
    public String getType(){
        return type;
    }
    public int getLevel(){
        return level;
    }
    public String getDescription(){
        return description;
    }
}
