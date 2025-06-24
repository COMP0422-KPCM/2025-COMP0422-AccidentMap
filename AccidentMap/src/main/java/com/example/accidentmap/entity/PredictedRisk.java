package com.example.accidentmap.entity;
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

    private String weather;

    @Column(columnDefinition = "jsonb")
    @Convert(converter = JsonbConverter.class)
    private Map<String, Object> route;

    private String riskLevel;

    private String message;
}
