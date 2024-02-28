package com.tabletennis.app.repository;

import com.tabletennis.app.models.EloRating;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EloRatingRepository extends JpaRepository<EloRating, Long> {

    List<EloRating> findByPlayerId(Long playerId);

    Optional<EloRating> findFirstByPlayerIdAndDateBetweenOrderByDateAsc(Long playerId, LocalDateTime startDate, LocalDateTime endDate);

    Optional<EloRating> findFirstByPlayerIdAndDateBetweenOrderByDateDesc(Long playerId, LocalDateTime startDate, LocalDateTime endDate);
}
