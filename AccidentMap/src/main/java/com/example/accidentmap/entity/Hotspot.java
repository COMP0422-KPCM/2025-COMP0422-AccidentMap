package com.example.accidentmap.entity;
import com.example.accidentmap.converter.JsonbConverter;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Type;
import java.util.Map;

@Entity
@Table(name = "hotspots")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Hotspot {

    @Id
    private String id;

    private double lat;
    private double lng;
    private String region;

    private int accidentCount;
    private int casualtyCount;
    private int deathCount;
    private int seriousInjuryCount;
    private int minorInjuryCount;
    private int reportedInjuryCount;

    @Column(columnDefinition = "jsonb")
    @Convert(converter = JsonbConverter.class)
    private Map<String, Object> severityStats;
}
