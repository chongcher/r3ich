package model;


import org.joda.time.DateTime;

/**
 *
 * @author chiachongcher
 */
public class Staff {
    private final String nric;
    private final String salutation;
    private final String name;
    
    public Staff(String nric, String salutation, String name){
        this.nric = nric;
        this.salutation = salutation;
        this.name = name;
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
    
}