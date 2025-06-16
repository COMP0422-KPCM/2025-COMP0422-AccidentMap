package com.example.accidentmap.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "user_reports")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserReport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private double lat;
    private double lng;

    private LocalDateTime datetime;

    @Column(columnDefinition = "TEXT")
    private String description;

    private String imageUrl;

    @Builder.Default
    @Column(nullable = false)
    private String status = "PENDING";
}