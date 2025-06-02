package com.example.accidentmap.repository;

import java.util.List;
import com.example.accidentmap.entity.Accident;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccidentRepository extends JpaRepository<Accident, Long> {
    List findAll();
}
