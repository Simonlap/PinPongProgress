package com.tabletennis.app.models;
import java.time.LocalDateTime;
import java.util.stream.Stream;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "resultsSevenTable")
public class ResultSevenTable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private Long playerId;
    @NotNull
    private int pointsPlayer;
    @NotNull
    private int uniqueGameId;
    @NotNull
    private LocalDateTime editTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPlayerId() {
        return playerId;
    }

    public void setPlayerId(Long player1Id) {
        this.playerId = player1Id;
    }

    public int getPointsPlayer() {
        return pointsPlayer;
    }

    public void setPointsPlayer(int pointsPlayer1) {
        this.pointsPlayer = pointsPlayer1;
    }

    public int getUniqueGameId() {
        return uniqueGameId;
    }

    public void setUniqueGameId(int uniqueGameId) {
        this.uniqueGameId = uniqueGameId;
    }

    public LocalDateTime getEditTime() {
        return editTime;
    }

    public void setEditTime(LocalDateTime editTime) {
        this.editTime = editTime;
    }
}
