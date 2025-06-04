package com.example.accidentmap.entity;
import com.example.accidentmap.converter.JsonbConverter;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "admin_settings")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminSetting {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer alertRadius;

    private Double riskThreshold;
}
