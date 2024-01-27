package com.example.demo.services;

import com.example.demo.dto.UniqueGameDTO;
import com.example.demo.models.UniqueGame;
import com.example.demo.repository.UniqueGamesRepository;
import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
