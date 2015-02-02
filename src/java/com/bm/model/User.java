/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bm.model;
import java.io.Serializable;

/**
 *
 * @author spiros
 */
public class User implements Serializable{
     
    private static final long serialVersionUID = 6297385302078200511L;
     
    private String name;
    private String email;
    private int id;
    private String country;
     
    public User(String nm, String em, String country, int i){
        this.name=nm;
        this.id=i;
        this.country=country;
        this.email=em;
    }

    public User(){
        
    }
    
    User(String string, String string0, int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
 
    public void setName(String name) {
        this.name = name;
    }
 
 
    public void setEmail(String email) {
        this.email = email;
    }
 
 
    public void setId(int id) {
        this.id = id;
    }
 
 
    public void setCountry(String country) {
        this.country = country;
    }
 
 
    public String getName() {
        return name;
    }
 
    public String getEmail() {
        return email;
    }
 
    public int getId() {
        return id;
    }
 
    public String getCountry() {
        return country;
    }
     
    @Override
    public String toString(){
        return "Name="+this.name+", Email="+this.email+", Country="+this.country;
    }
}