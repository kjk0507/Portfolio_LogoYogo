package com.Eclipse.LoGoYoGo.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.ibatis.io.ResolverUtil.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.Eclipse.LoGoYoGo.domain.baseDTO;
import com.Eclipse.LoGoYoGo.mapper.LoginMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private LoginMapper mapper;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main() {
		
        return "mainPage";
    }
	
	@RequestMapping(value = "test.do", method = RequestMethod.POST)
	public ModelAndView getLoginInfo(baseDTO explainVo) {
		ModelAndView mv = new ModelAndView();
		String id = "test";
		baseDTO test = new baseDTO();
		
		test.setId(id);
		
		test = mapper.testBaseDTO(test);
		
		System.out.println("########## id : " + test.getId());
		System.out.println("########## pw : " + test.getPw());
		
		return mv;
	}
	
}
