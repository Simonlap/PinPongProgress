package com.tabletennis.app.models;

import jakarta.persistence.*;

import java.time.LocalDateTime;

import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "elo_ratings")
public class EloRating {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private int elo;

    @NotNull
    private LocalDateTime date;

    @ManyToOne
    @JoinColumn(name = "player_id")
    private Player player;

    public EloRating(Long id, @NotNull int elo, @NotNull LocalDateTime date, Player player) {
        this.id = id;
        this.elo = elo;
        this.date = date;
        this.player = player;
    }

    public EloRating() {
        
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getElo() {
        return elo;
    }

    public void setElo(int elo) {
        this.elo = elo;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public Player getPlayer() {
        return player;
    }

    public void setPlayer(Player player) {
        this.player = player;
    }
}
