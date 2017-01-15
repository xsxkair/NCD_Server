package com.xsx.ncd.handler;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Controller
public class FileUpLoadHandler {
	
	@RequestMapping("fileUpload")
	public String  fileUpload2(@RequestParam("file") CommonsMultipartFile file) throws IOException {

		String path="./data"+file.getName();
		
		File newFile=new File(path);
		//通过CommonsMultipartFile的方法直接写文件（注意这个时候）
		file.transferTo(newFile);

		return "UpSoft";	
	}
}
