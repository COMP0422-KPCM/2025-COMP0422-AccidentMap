package com.example.accidentmap.service;

import com.example.accidentmap.entity.UserReport;
import com.example.accidentmap.repository.UserReportRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserReportService {

    private final UserReportRepository repository;

    public List<UserReport> getAll() {
        return repository.findAll();
    }

    public UserReport getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public UserReport save(UserReport report) {
        return repository.save(report);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
