package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.models.Result;

import java.util.Set;

@Repository
public interface ResultRepository extends JpaRepository<Result, Long> {
    Set<Result> findByUserIdAndRoundId(Long userId, Long roundId);
}
