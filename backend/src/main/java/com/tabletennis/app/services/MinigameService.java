package com.tabletennis.app.services;

import com.tabletennis.app.models.Result;
import org.modelmapper.ModelMapper;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tabletennis.app.dto.ResultDTO;
import com.tabletennis.app.payload.request.EditResultEntryRequest;
import com.tabletennis.app.repository.ResultRepository;

import java.util.List;
import java.util.Set;

@Service
@Transactional
public class MinigameService {

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    ResultRepository resultRepository;

    public ResultDTO createResultEntry(ResultDTO resultDTO, Long userId) {
        Result result = modelMapper.map(resultDTO, Result.class);
        result.setUserId(userId);
        Result savedResult = resultRepository.save(result);
        return modelMapper.map(savedResult, ResultDTO.class);
    }

    public List<ResultDTO> getResultsForUserIdAndRoundId(Long userId, Long roundId) {
        Set<Result> results = resultRepository.findByUserIdAndRoundId(userId, roundId);
        return results.stream()
                .map(result -> modelMapper.map(result, ResultDTO.class))
                .collect(java.util.stream.Collectors.toList());
    }

    public ResultDTO editResultEntry(@Valid EditResultEntryRequest editResultEntryRequest, Long id) {
        Result result = resultRepository.findById(editResultEntryRequest.getId()).get();
        result.setPointsPlayer1(editResultEntryRequest.getPointsPlayer1());
        result.setPointsPlayer2(editResultEntryRequest.getPointsPlayer2());
        Result savedResult = resultRepository.save(result);
        return modelMapper.map(savedResult, ResultDTO.class);
    }
}
