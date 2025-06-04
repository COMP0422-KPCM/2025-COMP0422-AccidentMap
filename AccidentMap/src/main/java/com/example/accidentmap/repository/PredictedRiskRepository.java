package com.example.accidentmap.repository;

import com.example.accidentmap.entity.PredictedRisk;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PredictedRiskRepository extends JpaRepository<PredictedRisk, Long> {
}
