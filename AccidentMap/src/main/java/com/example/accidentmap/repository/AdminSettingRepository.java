package com.example.accidentmap.repository;

import com.example.accidentmap.entity.AdminSetting;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminSettingRepository extends JpaRepository<AdminSetting, Long> {
}