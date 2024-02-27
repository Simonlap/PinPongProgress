package com.tabletennis.app.services;

import java.util.List;
import java.util.Set;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tabletennis.app.dto.ResultSevenTableDTO;
import com.tabletennis.app.models.ResultSevenTable;
import com.tabletennis.app.repository.ResultSevenTableRepository;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

@Service
@Transactional
public class SevenTableService {

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    ResultSevenTableRepository resultRepository;

    public List<ResultSevenTableDTO> getResultsForUniqueGame(Long userId, Long uniqueGameId) {
        Set<ResultSevenTable> results = resultRepository.findByUserIdAndUniqueGameId(userId, uniqueGameId);
        return results.stream()
                .map(result -> modelMapper.map(result, ResultSevenTableDTO.class))
                .collect(java.util.stream.Collectors.toList());
    }

    public ResultSevenTableDTO createResultEntry(@Valid ResultSevenTableDTO resultSevenTableDTO, Long userId) {
        ResultSevenTable result = modelMapper.map(resultSevenTableDTO, ResultSevenTable.class);
        result.setUserId(userId);
        ResultSevenTable savedResult = resultRepository.save(result);
        return modelMapper.map(savedResult, ResultSevenTableDTO.class);
    }

    public ResultSevenTableDTO increaseResult(Long id, Long userId) {
        ResultSevenTable result = resultRepository.findByIdAndUserId(id, userId);
        if (result != null) {
            result.setPointsPlayer(result.getPointsPlayer() + 1);
            ResultSevenTable updatedResult = resultRepository.save(result);
            return modelMapper.map(updatedResult, ResultSevenTableDTO.class);
        }
        return null;
    }

    public ResultSevenTableDTO decreaseResult(Long id, Long userId) {
        ResultSevenTable result = resultRepository.findByIdAndUserId(id, userId);
        if (result != null) {
            // Ensure that pointsPlayer doesn't go below 0
            int newPoints = Math.max(0, result.getPointsPlayer() - 1);
            result.setPointsPlayer(newPoints);
            ResultSevenTable updatedResult = resultRepository.save(result);
            return modelMapper.map(updatedResult, ResultSevenTableDTO.class);
        }
        return null;
    }
}
