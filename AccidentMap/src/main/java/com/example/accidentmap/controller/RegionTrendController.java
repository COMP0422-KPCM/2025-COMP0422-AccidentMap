package com.example.accidentmap.controller;

import com.example.accidentmap.entity.RegionTrend;
import com.example.accidentmap.service.RegionTrendService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/region-trends")
@RequiredArgsConstructor
public class RegionTrendController {

    private final RegionTrendService service;

    @GetMapping
    public List<RegionTrend> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public RegionTrend getById(@PathVariable Long id) {
        return service.getById(id);
    }

    @PostMapping
    public RegionTrend create(@RequestBody RegionTrend trend) {
        return service.save(trend);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
