package com.tabletennis.app.repository;

import com.tabletennis.app.models.ResultSevenTable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface ResultSevenTableRepository extends JpaRepository<ResultSevenTable, Long> {
    
    @SuppressWarnings("null")
    ResultSevenTable findByUniqueGameIdAndPlayerId(Long uniqueGameId, Long playerId);


    Set<ResultSevenTable> findByUniqueGameId(Long uniqueGameId);

}
