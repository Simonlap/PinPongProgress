package com.tabletennis.app.dto;

import java.time.LocalDateTime;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UniqueGameDTO {
    
    private Long id;
    private int highestRound;
    private boolean isFinished;
    private Long userId;
    private LocalDateTime startTime; 
    private Set<Long> players;
    private int minigameId;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public int getHighestRound() {
        return highestRound;
    }

    public void setHighestRound(int highestRound) {
        this.highestRound = highestRound;
    }

    public boolean isFinished() {
        return isFinished;
    }

    public void setFinished(boolean isFinished) {
        this.isFinished = isFinished;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public Set<Long> getPlayers() {
        return players;
    }

    public void setPlayers(Set<Long> players) {
        this.players = players;
    }

    public int getMinigameId() {
        return minigameId;
    }

    public void setMinigameId(int minigameId) {
        this.minigameId = minigameId;
    }
}