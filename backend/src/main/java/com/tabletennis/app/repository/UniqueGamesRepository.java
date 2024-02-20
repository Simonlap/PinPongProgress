package com.tabletennis.app.repository;

import com.tabletennis.app.models.UniqueGame;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface UniqueGamesRepository extends JpaRepository<UniqueGame, Long> {

    Set<UniqueGame> findByUserIdAndIsFinished(Long userId, boolean isFinished);

    UniqueGame findByIdAndUserId(Long uniqueGameId, Long userId);
}
