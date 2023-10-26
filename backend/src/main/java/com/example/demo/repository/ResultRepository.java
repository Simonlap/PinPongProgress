package com.example.demo.repository;

import com.example.demo.dto.ResultDTO;
import com.example.demo.models.Result;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface ResultRepository extends JpaRepository<Result, Long> {

    Set<Result> findByUserIdAndRoundId(Long userId, String roundId);
}
