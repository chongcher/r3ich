package model;


import java.util.ArrayList;

/**
 *
 * @author chiachongcher
 */
public class Staff {
    private final String nric;
    private final String salutation;
    private final String name;
    private final ArrayList<String> classes;
    
    public Staff(String nric, String salutation, String name,ArrayList<String> classes){
        this.nric = nric;
        this.salutation = salutation;
        this.name = name;
        this.classes = classes;
    }
    
    public String getNric(){
        return nric;
    }
    
    public String getSalutation(){
        return salutation;
    }
    
    public String getName(){
        return name;
    }
    
    public ArrayList<String> getClasses(){
        return classes;
    }
    
    
    
}