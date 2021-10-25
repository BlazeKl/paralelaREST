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
@Table(name = "TEMPERATURAS")
public class temperatura extends PkEntityBase {
    
    private static final long serialVersionUID = 1L;
    
    @Column(name = "COD_ESTACION", nullable = false)
    private int cod_estacion = 0;
    
    @Column(name = "PRECIPITACION")
    private float precipitacion = 0;
    
    @Column(name = "TEMP_MAX")
    private float max = 0;
    
    @Column(name = "TEMP_MIN")
    private float min = 0;

    public int getCod_estacion() {
        return cod_estacion;
    }

    public void setCod_estacion(int cod_estacion) {
        this.cod_estacion = cod_estacion;
    }

    public float getPrecipitacion() {
        return precipitacion;
    }

    public void setPrecipitacion(float precipitacion) {
        this.precipitacion = precipitacion;
    }

    public float getMax() {
        return max;
    }

    public void setMax(float max) {
        this.max = max;
    }

    public float getMin() {
        return min;
    }

    public void setMin(float min) {
        this.min = min;
    }
    
    
    
}
