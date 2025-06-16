package com.example.accidentmap.service;

import com.example.accidentmap.entity.RegionTrend;
import com.example.accidentmap.repository.RegionTrendRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RegionTrendService {

    private final RegionTrendRepository repository;

    public List<RegionTrend> getAll() {
        return repository.findAll();
    }

    public RegionTrend getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public RegionTrend save(RegionTrend trend) {
        return repository.save(trend);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}