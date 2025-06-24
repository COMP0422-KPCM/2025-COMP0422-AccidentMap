package com.example.accidentmap.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "predicted_risks")
@Getter
@Setter
import com.example.accidentmap.converter.JsonbConverter;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.Map;

@Entity
@Table(name = "predicted_risks")
@Getter @Setter
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

    private String weather;

    @Column(columnDefinition = "jsonb")
    @Convert(converter = JsonbConverter.class)
    private Map<String, Object> route;

    private String riskLevel;

    private String message;
}
