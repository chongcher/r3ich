package model;


import java.util.ArrayList;
import java.util.Arrays;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccchia.2014
 */
public class User {
    private String nric;
    private String name;
    private String userClass;
    private int respectLevel;
    private int resilienceLevel;
    private int responsibilityLevel;
    private int integrityLevel;
    private int careLevel;
    private int harmonyLevel;
    private ArrayList<String> groupList;

    public User(String nric, String name, String userClass, String userGroup, int respectLevel, 
            int resilienceLevel, int responsibilityLevel, int integrityLevel, int careLevel, int harmonyLevel) {
        this.nric = nric;
        this.name = name;
        this.userClass = userClass;
        this.respectLevel = respectLevel;
        this.resilienceLevel = resilienceLevel;
        this.responsibilityLevel = responsibilityLevel;
        this.integrityLevel = integrityLevel;
        this.careLevel = careLevel;
        this.harmonyLevel = harmonyLevel;
        groupList = new ArrayList<>(Arrays.asList(userGroup.split(",")));
    }

    public String getNric() {
        return nric;
    }

    public String getName() {
        return name;
    }

    public String getUserClass() {
        return userClass;
    }

    public ArrayList<String> getGroupList() {
        return groupList;
    }
    
}
