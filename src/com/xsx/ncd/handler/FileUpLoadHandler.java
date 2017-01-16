package com.xsx.ncd.handler;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Controller
public class FileUpLoadHandler {
	
	@RequestMapping("fileUpload")
	public String  fileUpload2(@RequestParam("file") CommonsMultipartFile file, Map<String, Object> map){

		try {
			String path="/var/NCD_Data/NCD_YGFXY.rar";
			
			File newFile=new File(path);
			//通过CommonsMultipartFile的方法直接写文件（注意这个时候）
			file.transferTo(newFile);
			
			map.put("status", "成功");
			
		} catch (Exception e) {
			// TODO: handle exception
			map.put("status", "失败");
		}
		

		return "UpSoft";
	}
	
	@RequestMapping("fileDown")
	public ResponseEntity<byte[]>  fileDown() throws IOException{
		String path="/var/NCD_Data/NCD_YGFXY.rar";
		File file=new File(path);  
		 
		HttpHeaders headers = new HttpHeaders();    
		headers.setContentDispositionFormData("attachment", file.getName());   
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
		 
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
				headers, HttpStatus.CREATED);
	}
}
