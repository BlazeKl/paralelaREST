/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com0.climaREST.persistance.model;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

/**
 *
 * @author filip
 */

@MappedSuperclass
public class PkEntityBase extends climam {
    
    private static final long serialVersionUID = 1L;
    
    @Transient
    private static final ZoneId SCL = ZoneId.of("America/Santiago");
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "COD_ESTACION", nullable = false)
    private Long estacion_id = null;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "COD_TEMP", nullable = false)
    private Long temp_id = null;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "COD_RUT", nullable = false)
    private Long rut_id = null;
    
    @Column(name = "FECHA_CREADO", nullable = false)
    private ZonedDateTime FECHA_CREADO = ZonedDateTime.now(SCL);
    
    @Column(name = "FECHA_MOD", nullable = false)
    private ZonedDateTime FECHA_MOD = ZonedDateTime.now(SCL);

    public ZonedDateTime getFECHA_CREADO() {
        return FECHA_CREADO;
    }

    public void setFECHA_CREADO(ZonedDateTime FECHA_CREADO) {
        this.FECHA_CREADO = FECHA_CREADO;
    }

    public ZonedDateTime getFECHA_MOD() {
        return FECHA_MOD;
    }

    public void setFECHA_MOD(ZonedDateTime FECHA_MOD) {
        this.FECHA_MOD = FECHA_MOD;
    }

    public Long getEstacion_id() {
        return estacion_id;
    }

    public void setEstacion_id(Long estacion_id) {
        this.estacion_id = estacion_id;
    }

    public Long getTemp_id() {
        return temp_id;
    }

    public void setTemp_id(Long temp_id) {
        this.temp_id = temp_id;
    }

    public Long getRut_id() {
        return rut_id;
    }

    public void setRut_id(Long rut_id) {
        this.rut_id = rut_id;
    }
    
    public ZoneId getTimeZone() {
        return SCL;
    }
}
