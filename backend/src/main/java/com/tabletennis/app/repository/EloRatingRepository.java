package com.tabletennis.app.repository;

import com.tabletennis.app.models.EloRating;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EloRatingRepository extends JpaRepository<EloRating, Long> {

    List<EloRating> findByPlayerId(Long playerId);
    
}
