package com.tabletennis.app.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tabletennis.app.dto.ResultSevenTableDTO;
import com.tabletennis.app.security.services.UserDetailsImpl;
import com.tabletennis.app.services.SevenTableService;

import jakarta.validation.Valid;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/sevenTable")
public class SevenTableController {
    
    @Autowired 
    SevenTableService sevenTableService;

    @GetMapping("/results/{uniqueGameId}")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<List<ResultSevenTableDTO>> getResultsForUniqueGame(@PathVariable Long uniqueGameId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        List<ResultSevenTableDTO> results = sevenTableService.getResultsForUniqueGame(userDetails.getId(), uniqueGameId);

        return new ResponseEntity<>(results, HttpStatus.OK);
    }

    @PostMapping("/entry")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<ResultSevenTableDTO> createResult(@Valid @RequestBody ResultSevenTableDTO resultSevenTableDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        ResultSevenTableDTO createdResult = sevenTableService.createResultEntry(resultSevenTableDTO, userDetails.getId());

        return new ResponseEntity<>(createdResult, HttpStatus.CREATED);
    }

    @PutMapping("/increaseEntry/{id}")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<ResultSevenTableDTO> increaseResult(@PathVariable Long id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        ResultSevenTableDTO createdResult = sevenTableService.increaseResult(id, userDetails.getId());

        return new ResponseEntity<>(createdResult, HttpStatus.OK);
    }

    @PutMapping("/decreaseEntry/{id}")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<ResultSevenTableDTO> decreaseResult(@PathVariable Long id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        ResultSevenTableDTO createdResult = sevenTableService.decreaseResult(id, userDetails.getId());

        return new ResponseEntity<>(createdResult, HttpStatus.OK);
    }

}
