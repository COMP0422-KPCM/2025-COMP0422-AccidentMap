package com.example.accidentmap.controller;

import com.example.accidentmap.entity.AdminSetting;
import com.example.accidentmap.service.AdminSettingService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin-settings")
@RequiredArgsConstructor
public class AdminSettingController {

    private final AdminSettingService service;

    @GetMapping
    public List<AdminSetting> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public AdminSetting getById(@PathVariable Long id) {
        return service.getById(id);
    }

    @PostMapping
    public AdminSetting create(@RequestBody AdminSetting setting) {
        return service.save(setting);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}