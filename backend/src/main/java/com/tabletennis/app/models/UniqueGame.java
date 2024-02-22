package com.tabletennis.app.models;

import java.time.LocalDateTime;
import java.util.Set;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "uniqueGames")
public class UniqueGame {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private int highestRound;

    @NotNull
    private boolean isFinished;

    @NotNull
    private Long userId;

    @NotNull
    private LocalDateTime startTime;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @JoinTable(
        name = "uniqueGame_players", 
        joinColumns = @JoinColumn(name = "uniqueGame_id"), 
        inverseJoinColumns = @JoinColumn(name = "player_id")
    )
    private Set<Player> players;

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

    public Long isUserId() {return userId;}
    public void setUserId(Long userId) {this.userId = userId;}

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public Set<Player> getPlayers() {
        return players;
    }

    public void setPlayers(Set<Player> players) {
        this.players = players;
    }
}
