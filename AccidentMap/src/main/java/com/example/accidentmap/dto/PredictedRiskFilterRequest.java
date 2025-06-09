package com.example.accidentmap.dto;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class PredictedRiskFilterRequest {
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Location location;
    private int radius; // meters
    private List<Integer> severityLevels;

    @Data
    public static class Location {
        private double lat;
        private double lng;
    }
}