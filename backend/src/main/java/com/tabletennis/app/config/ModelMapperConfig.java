package com.tabletennis.app.config;

import com.tabletennis.app.dto.UniqueGameDTO;
import com.tabletennis.app.models.Player;
import com.tabletennis.app.models.UniqueGame;
import org.modelmapper.ModelMapper;
import org.modelmapper.PropertyMap;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.util.stream.Collectors;

import java.util.Set;

@Configuration
public class ModelMapperConfig {
    @Bean
    public ModelMapper modelMapper() {
        ModelMapper modelMapper = new ModelMapper();

        modelMapper.addMappings(new PropertyMap<UniqueGame, UniqueGameDTO>() {
            @Override
            protected void configure() {
                using(context -> ((Set<Player>) context.getSource()).stream()
                        .map(Player::getId)
                        .collect(Collectors.toSet()))
                        .map(source.getPlayers(), destination.getPlayers());
            }
        });

        return modelMapper;
    }

}
