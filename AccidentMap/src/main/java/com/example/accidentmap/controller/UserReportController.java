package com.example.accidentmap.controller;

import com.example.accidentmap.entity.UserReport;
import com.example.accidentmap.service.UserReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/user-reports")
@RequiredArgsConstructor
public class UserReportController {

    private final UserReportService service;

    @GetMapping
    public List<UserReport> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public UserReport getById(@PathVariable Long id) {
        return service.getById(id);
    }

    @PostMapping
    public UserReport create(@RequestBody UserReport report) {
        return service.save(report);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
