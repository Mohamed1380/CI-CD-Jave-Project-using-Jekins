package com.example.springboot.controller;

import java.time.LocalDateTime;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SpringController {

	@GetMapping(value = "/")
	public String getValue() {

		String result = "Hello From Muhammad AbdElhady Full CI/CD for Java Project";
		return result;
	}
}
