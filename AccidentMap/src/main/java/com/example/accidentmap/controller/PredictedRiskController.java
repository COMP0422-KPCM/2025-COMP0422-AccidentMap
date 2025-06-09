package com.example.accidentmap.controller;
import com.example.accidentmap.dto.AccidentResponse;

import com.example.accidentmap.dto.PredictedRiskFilterRequest;
import com.example.accidentmap.entity.PredictedRisk;
import com.example.accidentmap.service.PredictedRiskService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/predicted-risks")
@RequiredArgsConstructor
public class PredictedRiskController {

    private final PredictedRiskService service;

    @GetMapping
    public List<PredictedRisk> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public PredictedRisk getById(@PathVariable Long id) {
        return service.getById(id);
    }

    @PostMapping
    public PredictedRisk create(@RequestBody PredictedRisk risk) {
        return service.save(risk);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }

    // ✅ 여기에 필터용 POST API 추가
    @PostMapping("/filter")
    public List<AccidentResponse> filterRisks(@RequestBody PredictedRiskFilterRequest request) {
        return service.filterRisks(request);
    }
}
