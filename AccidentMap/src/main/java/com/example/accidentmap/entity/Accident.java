package com.example.accidentmap.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import org.springframework.data.annotation.Id;

@Entity
public class Accident {
    @Id
    @GeneratedValue
    private Long id;

    private String location;
    private String description;
}
