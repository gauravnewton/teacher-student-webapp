package com.techreloded.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * The Class HomeController.
 */
@Controller
@RequestMapping(value = "/")
public class HomeController {
	
	/**
	 * Index.
	 *
	 * @param request the request
	 * @return the model and view
	 * @throws IOException Signals that an I/O exception has occurred.
	 */
	@GetMapping(value = "")
	public ModelAndView index(HttpServletRequest request) throws IOException {
		ModelAndView modelAndView = new ModelAndView("index");
		request.setAttribute("pageTitle", "Home Page");
		return modelAndView;
	}
	
	/**
	 * Home.
	 *
	 * @return the string
	 */
	@GetMapping(value = "/index")
	public String home() {
		return "redirect: /";
	}
}

