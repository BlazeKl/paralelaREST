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
@Table(name = "ESTACIONES_CLIMATOLOGICAS")
public class estacion extends PkEntityBase {
    
    private static final long serialVersionUID = 1L;
    
    @Column(name = "NOMBRE", nullable = false)
    private String nombre = null;
     
    @Column(name = "LATITUD", nullable = false)
    private String latitud = null;
    
    @Column(name = "LONGITUD", nullable = false)
    private String longitud = null;
    
    @Column(name = "ALTURA_MAR", nullable = false)
    private float altura = 0;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getLatitud() {
        return latitud;
    }

    public void setLatitud(String latitud) {
        this.latitud = latitud;
    }

    public String getLongitud() {
        return longitud;
    }

    public void setLongitud(String longitud) {
        this.longitud = longitud;
    }

    public float getAltura() {
        return altura;
    }

    public void setAltura(float altura) {
        this.altura = altura;
    }
    
    
}
