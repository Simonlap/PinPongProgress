package com.example.demo.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResultDTO {

    @JsonIgnore
    private Long id;

    private Long userId;
    private int minigameId;
    private Long player1_id;
    private Long player2_id;
    private int points_player1;
    private int points_player2;
    private String roundId;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public int getMinigameId() {
        return minigameId;
    }

    public void setMinigameId(int minigameId) {
        this.minigameId = minigameId;
    }

    public Long getPlayer1_id() {
        return player1_id;
    }

    public void setPlayer1_id(Long player1_id) {
        this.player1_id = player1_id;
    }

    public Long getPlayer2_id() {
        return player2_id;
    }

    public void setPlayer2_id(Long player2_id) {
        this.player2_id = player2_id;
    }

    public int getPoints_player1() {
        return points_player1;
    }

    public void setPoints_player1(int points_player1) {
        this.points_player1 = points_player1;
    }

    public int getPoints_player2() {
        return points_player2;
    }

    public void setPoints_player2(int points_player2) {
        this.points_player2 = points_player2;
    }

    public String getRoundId() {
        return roundId;
    }

    public void setRoundId(String roundId) {
        this.roundId = roundId;
    }
}
