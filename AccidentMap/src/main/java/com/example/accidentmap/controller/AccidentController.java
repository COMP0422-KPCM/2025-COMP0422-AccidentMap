package com.example.accidentmap.controller;

import java.util.List;
import com.example.accidentmap.entity.Accident;
import com.example.accidentmap.repository.AccidentRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/accidents")
public class AccidentController {
    private final AccidentRepository repo;

    public AccidentController(AccidentRepository repo) {
        this.repo = repo;
    }

    @GetMapping
    public List<Accident> getAll() {
        return repo.findAll();
    }
}
