package com.tabletennis.app.services;

import com.tabletennis.app.models.Player;
import com.tabletennis.app.models.UniqueGame;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tabletennis.app.dto.UniqueGameDTO;
import com.tabletennis.app.payload.request.UniqueGameIdRequest;
import com.tabletennis.app.repository.PlayerRepository;
import com.tabletennis.app.repository.UniqueGamesRepository;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class UniqueGamesService {

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    UniqueGamesRepository uniqueGamesRepository;

    @Autowired
    private PlayerRepository playerRepository;

    public UniqueGameDTO createEntry(UniqueGameDTO uniqueGameDTO, Long userId) {
        UniqueGame game = new UniqueGame(); 
        modelMapper.map(uniqueGameDTO, game); 
        game.setUserId(userId);
    
        if (uniqueGameDTO.getPlayers() != null && !uniqueGameDTO.getPlayers().isEmpty()) {
            List<Player> playerList = playerRepository.findAllById(uniqueGameDTO.getPlayers());
            Set<Player> players = new HashSet<>(playerList); 
            game.setPlayers(players);
        }
    
        UniqueGame savedGame = uniqueGamesRepository.save(game);

        UniqueGameDTO resultDTO = modelMapper.map(savedGame, UniqueGameDTO.class);
        return resultDTO;
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