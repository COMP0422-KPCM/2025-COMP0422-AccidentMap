package com.example.accidentmap.service;

import com.example.accidentmap.entity.PredictedRisk;
import com.example.accidentmap.repository.PredictedRiskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PredictedRiskService {

    private final PredictedRiskRepository repository;

    public List<PredictedRisk> getAll() {
        return repository.findAll();
    }

    public PredictedRisk getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public PredictedRisk save(PredictedRisk risk) {
        return repository.save(risk);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}