package com.example.accidentmap.repository;

import com.example.accidentmap.entity.UserReport;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserReportRepository extends JpaRepository<UserReport, Long> {
}