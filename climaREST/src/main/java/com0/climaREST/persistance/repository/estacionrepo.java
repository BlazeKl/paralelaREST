/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com0.climaREST.persistance.repository;

import com0.climaREST.persistance.model.estacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author pipe
 */
@Repository
public interface estacionrepo extends JpaRepository<estacion, Long>{
    
}
