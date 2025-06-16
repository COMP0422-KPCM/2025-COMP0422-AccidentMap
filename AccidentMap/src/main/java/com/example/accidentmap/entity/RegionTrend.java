package com.example.accidentmap.entity;
import com.example.accidentmap.converter.JsonbConverter;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.util.Map;

@Entity
@Table(name = "region_trend")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RegionTrend {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String region;

    private LocalDate date;

    private Integer total;

    @Column(columnDefinition = "jsonb")
    @Convert(converter = JsonbConverter.class)
    private Map<String, Object> severity;
}