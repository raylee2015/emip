package cn.lilinghui.index.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class IndexController {

	public static final Logger LOGGER = Logger
			.getLogger(IndexController.class);

	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String toIndex(HttpServletRequest request,
			Model model) {
		return "/login";
	}

	@RequestMapping(value = "/homePage.do", method = RequestMethod.GET)
	public String toHomePage(HttpServletRequest request,
			Model model) {
		return "/homepage";
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return "/index";
	}

	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.getSession().removeAttribute("user");
		return "/login";
	}
}
