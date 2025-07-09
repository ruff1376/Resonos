package com.cosmus.resonos;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SecurityApplication {

	public static void main(String[] args) {
		System.out.println("Security 의 경로 : " + System.getProperty("user.dir"));
		SpringApplication.run(SecurityApplication.class, args);
	}

}
