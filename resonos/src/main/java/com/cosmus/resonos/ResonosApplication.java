package com.cosmus.resonos;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ResonosApplication {

	public static void main(String[] args) {
		System.out.println("Resonos 의 경로 : " + System.getProperty("user.dir"));
		SpringApplication.run(ResonosApplication.class, args);
	}

}
