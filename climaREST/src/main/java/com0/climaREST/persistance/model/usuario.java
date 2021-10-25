/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com0.climaREST.persistance.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 *
 * @author filip
 */
@Entity
@Table(name = "USUARIOS")
public class usuario extends PkEntityBase {
    
    private static final long serialVersionUID = 2L;
    
    @Column(name = "TOKEN", nullable = false, unique = true)
    private String token = null;
    
    @Column(name = "PASS", nullable = false)
    private String password = null;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
}
