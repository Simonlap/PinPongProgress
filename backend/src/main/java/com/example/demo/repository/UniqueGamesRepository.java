package com.example.demo.repository;

import com.example.demo.dto.UniqueGameDTO;
import com.example.demo.models.UniqueGame;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface UniqueGamesRepository extends JpaRepository<UniqueGame, Long> {

    Set<UniqueGame> findByUserIdAndIsFinished(Long userId, boolean isFinished);

    UniqueGame findByIdAndUserId(Long uniqueGameId, Long userId);
}
