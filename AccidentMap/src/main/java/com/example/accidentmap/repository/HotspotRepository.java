package com.example.accidentmap.repository;

import com.example.accidentmap.entity.Hotspot;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HotspotRepository extends JpaRepository<Hotspot, String> {
}