package com.example.demo.repository;

import com.example.demo.models.Player;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface PlayerRepository extends JpaRepository<Player, Long> {
    Set<Player> findByUserId(Long userId);
}
