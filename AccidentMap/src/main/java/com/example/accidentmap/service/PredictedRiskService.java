package com.example.accidentmap.service;

import com.example.accidentmap.dto.AccidentResponse;
import com.example.accidentmap.dto.PredictedRiskFilterRequest;
import com.example.accidentmap.entity.PredictedRisk;
import com.example.accidentmap.repository.PredictedRiskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PredictedRiskService {

    private final PredictedRiskRepository repository;

    public List<AccidentResponse> filterRisks(PredictedRiskFilterRequest request) {
        List<PredictedRisk> all = repository.findAll();

        return all.stream()
                .filter(r -> {
                    if (r.getDatetime().isBefore(request.getStartDate()) ||
                            r.getDatetime().isAfter(request.getEndDate())) return false;

                    if (r.getLatitude() == null || r.getLongitude() == null) return false;
                    double dist = haversine(
                            r.getLatitude(), r.getLongitude(),
                            request.getLocation().getLat(), request.getLocation().getLng()
                    );
                    if (dist > request.getRadius()) return false;

                    int level = r.getSeverity() != null ? r.getSeverity() : mapRiskLevelToInt(r.getRiskLevel());
                    return request.getSeverityLevels().contains(level);
                })
                .map(this::toAccidentResponse)
                .collect(Collectors.toList());
    }

    // ✅ 필드명을 기준으로 소문자 builder 메서드 사용
    private AccidentResponse toAccidentResponse(PredictedRisk r) {
        return AccidentResponse.builder()
                .id(UUID.randomUUID())
                .date(r.getDatetime())
                .latitude(r.getLatitude())
                .longitude(r.getLongitude())
                .severity(r.getSeverity() != null ? r.getSeverity() : mapRiskLevelToInt(r.getRiskLevel()))
                .temperature(r.getTemperature() != null ? r.getTemperature() : "22.0")
                .visibility(r.getVisibility() != null ? r.getVisibility() : "10km")
                .precipitation(r.getPrecipitation() != null ? r.getPrecipitation() : "0mm")
                .weatherCondition(r.getWeather())
                .civilTwilight(r.getCivilTwilight() != null ? r.getCivilTwilight() : "Day")
                .build();
    }

    // ✅ 거리 계산 공식 (Haversine)
    private double haversine(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371000; // 반지름 (미터)
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                        Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;
    }

    // ✅ 위험 수준 문자열을 정수로 매핑
    private int mapRiskLevelToInt(String riskLevel) {
        return switch (riskLevel.toLowerCase()) {
            case "낮음" -> 1;
            case "중간" -> 2;
            case "높음" -> 3;
            case "매우 높음" -> 4;
            default -> 0;
        };
    }

    // ✅ 기본 CRUD 메서드들
    public List<PredictedRisk> getAll() {
        return repository.findAll();
    }

    public PredictedRisk getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public PredictedRisk save(PredictedRisk risk) {
        return repository.save(risk);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
