package com.example.accidentmap.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@Builder
public class AccidentResponse {
    private UUID id;
    private LocalDateTime date;
    private double latitude;
    private double longitude;
    private int severity;
    private String temperature;
    private String visibility;
    private String precipitation;
    private String weatherCondition;
    private String civilTwilight;
}
