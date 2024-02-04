package com.example.demo.services;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.PlayerDTO;
import com.example.demo.dto.UniqueGameDTO;
import com.example.demo.models.Player;
import com.example.demo.models.UniqueGame;
import com.example.demo.payload.request.UniqueGameIdRequest;
import com.example.demo.repository.UniqueGamesRepository;

import java.util.List;
import java.util.Set;

@Service
@Transactional
public class UniqueGamesService {

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    UniqueGamesRepository uniqueGamesRepository;

    public UniqueGameDTO createEntry(UniqueGameDTO uniqueGameDTO, Long userId) {
        UniqueGame game = modelMapper.map(uniqueGameDTO, UniqueGame.class);
        game.setUserId(userId);
        UniqueGame savedGame = uniqueGamesRepository.save(game);
        return modelMapper.map(savedGame, UniqueGameDTO.class);
    }

    public List<UniqueGameDTO> getRunningGames(Long userId) {
        Set<UniqueGame> results = uniqueGamesRepository.findByUserIdAndIsFinished(userId,false);
        return results.stream()
                .map(result -> modelMapper.map(result, UniqueGameDTO.class))
                .collect(java.util.stream.Collectors.toList());
    }

    public UniqueGameDTO increaseRound(@Valid UniqueGameIdRequest updateRoundIdRequest, Long userId) {
        UniqueGame uniqueGame = uniqueGamesRepository.findById(updateRoundIdRequest.getUniqueGameId()).get();
        uniqueGame.setHighestRound(uniqueGame.getHighestRound() + 1);
        UniqueGame savedGame = uniqueGamesRepository.save(uniqueGame);
        return modelMapper.map(savedGame, UniqueGameDTO.class);
    }

    public UniqueGameDTO exitRound(@Valid UniqueGameIdRequest updateRoundIdRequest, Long userId) {
        UniqueGame uniqueGame = uniqueGamesRepository.findById(updateRoundIdRequest.getUniqueGameId()).get();
        uniqueGame.setFinished(true);
        UniqueGame savedGame = uniqueGamesRepository.save(uniqueGame);
        return modelMapper.map(savedGame, UniqueGameDTO.class);
    }
}