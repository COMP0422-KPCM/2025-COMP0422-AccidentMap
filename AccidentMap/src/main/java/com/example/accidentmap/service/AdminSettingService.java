package com.example.accidentmap.service;

import com.example.accidentmap.entity.AdminSetting;
import com.example.accidentmap.repository.AdminSettingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminSettingService {

    private final AdminSettingRepository repository;

    public List<AdminSetting> getAll() {
        return repository.findAll();
    }

    public AdminSetting getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public AdminSetting save(AdminSetting setting) {
        return repository.save(setting);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}