package com.xsx.ncd.handler;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeHandler {

	@RequestMapping("UpSoft")
	public String UpSoftHandler(){
		
		return "UpSoft";
	}
}
