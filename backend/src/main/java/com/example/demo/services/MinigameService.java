package com.example.demo.services;

import org.modelmapper.ModelMapper;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.ResultDTO;
import com.example.demo.models.Result;
import com.example.demo.repository.ResultRepository;

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

    public List<ResultDTO> getResultsForUserIdAndRoundId(Long userId, int roundId) {
        Set<Result> results = resultRepository.findByUserIdAndRoundId(userId, roundId);
        return results.stream()
                .map(result -> modelMapper.map(result, ResultDTO.class))
                .collect(java.util.stream.Collectors.toList());
    }
}
