package com.Eclipse.LoGoYoGo.controller;

import java.io.File;
import java.text.DateFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.io.ResolverUtil.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(value = "test.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getLoginInfo(baseDTO explainVo) {		
		ModelAndView mv = new ModelAndView("jsonView");
		String id = "test";
		baseDTO test = new baseDTO();
		
		test.setId(id);
		
		test = mapper.testBaseDTO(test);
		
		System.out.println("########## id : " + test.getId());
		System.out.println("########## pw : " + test.getPw());
		
		Map<String, Object> res = new HashMap<>();
		res.put("result", "success");
		res.put("id", test.getId());
		res.put("pw", test.getPw());
		
		mv.addObject("id", test.getId());
		
		return res;
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(Model model) {
		model.addAttribute("contentPage", "/WEB-INF/views/components/mainPage.jsp");
        return "layout";
    }
	
	// components 페이지 호출	
	@RequestMapping("/mainPage.do")
	public String home(Model model) {
	    return "components/mainPage";
	}

	@RequestMapping("/section1.do")
	public String section1() {
	    return "components/section1";
	}

	@RequestMapping("/section2.do")
	public String section2() {
	    return "components/section2";
	}

	@RequestMapping("/editor.do")
	public String editor() {
	    return "components/editor";
	}
	
	@RequestMapping("/getDiagramSvgs")
	@ResponseBody
	public List<String> getDiagramSvgs(HttpServletRequest request) {

	    String realPath = request.getServletContext()
	            .getRealPath("/resources/images/diagram");

	    File dir = new File(realPath);

	    File[] files = dir.listFiles();
	    if (files == null) {
	        return Collections.emptyList();
	    }

	    return Arrays.stream(files)
	    	    .filter(f -> f.isFile() && f.getName().endsWith(".svg"))
	    	    .sorted(Comparator.comparingInt(f -> {
	    	        return Integer.parseInt(f.getName().replace(".svg", ""));
	    	    }))
	    	    .map(f -> request.getContextPath()
	    	        + "/resources/images/diagram/"
	    	        + f.getName()
	    	    )
	    	    .collect(Collectors.toList());
	}
	
}
