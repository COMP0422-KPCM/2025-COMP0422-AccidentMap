package com.example.accidentmap.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "predicted_risks")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PredictedRisk {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime datetime;
    private Double latitude;
    private Double longitude;
    private String weather;
    private String riskLevel;
    private Integer severity;

    private String temperature;
    private String visibility;
    private String precipitation;
    private String civilTwilight;
}
