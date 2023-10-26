package com.example.demo.services;

import com.example.demo.dto.PlayerDTO;
import com.example.demo.models.Player;
import com.example.demo.repository.PlayerRepository;
import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional
public class UserdataService {

    @Autowired
    PlayerRepository playerRepository;

    @Autowired
    ModelMapper modelMapper;

    public List<PlayerDTO> getPlayersForUserId(Long userId) {
        Set<Player> players = playerRepository.findByUserId(userId);

        return players.stream()
                .map(player -> modelMapper.map(player, PlayerDTO.class))
                .collect(Collectors.toList());
    }

    public PlayerDTO createPlayer(PlayerDTO playerDTO, Long userId) {
        Player player = modelMapper.map(playerDTO, Player.class);
        player.setUserId(userId);
        Player savedPlayer = playerRepository.save(player);
        return modelMapper.map(savedPlayer, PlayerDTO.class);
    }
}
