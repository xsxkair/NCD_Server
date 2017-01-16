package com.xsx.ncd.handler;

import java.io.File;
import java.io.IOException;
import java.util.Map;

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
			String path="/var/NCD_Data/"+file.getOriginalFilename();
			
			File newFile=new File(path);
			//ͨ��CommonsMultipartFile�ķ���ֱ��д�ļ���ע�����ʱ��
			file.transferTo(newFile);
			
			map.put("status", "�ɹ�");
			
		} catch (Exception e) {
			// TODO: handle exception
			map.put("status", "ʧ��");
		}
		

		return "UpSoft";
	}
}
