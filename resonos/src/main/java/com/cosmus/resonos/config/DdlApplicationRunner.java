package com.cosmus.resonos.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import com.cosmus.resonos.mapper.CommonMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class DdlApplicationRunner implements ApplicationRunner {

    @Autowired CommonMapper commonMapper;
    @Value("${ddl.init}") Boolean init;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        try {
            // Mapper 인터페이스를 통해 DDL 실행
            if( init ) {
                log.info("######################### [ DDL ] #########################");      
                log.info("### : DDL 초기화");
                commonMapper.createTable();
            }

        } catch (Exception e) {
            System.err.println("Error occurred while executing DDL via MyBatis: " + e.getMessage());
        }
    }
}
