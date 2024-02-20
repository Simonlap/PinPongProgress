package com.tabletennis.app.payload.request;

import jakarta.validation.constraints.NotNull;

public class EditResultEntryRequest {
    
    @NotNull
    Long id;
    @NotNull
    int pointsPlayer1;
    @NotNull
    int pointsPlayer2;
    
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public int getPointsPlayer1() {
        return pointsPlayer1;
    }
    public void setPointsPlayer1(int pointsPlayer1) {
        this.pointsPlayer1 = pointsPlayer1;
    }
    public int getPointsPlayer2() {
        return pointsPlayer2;
    }
    public void setPointsPlayer2(int pointsPlayer2) {
        this.pointsPlayer2 = pointsPlayer2;
    }
}
