package com.xsx.ncd.handler;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.NcdSoft;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.repository.NcdSoftRepository;
import com.xsx.ncd.service.UpLoadSoftService;

@Controller
public class FileUpLoadHandler {
	
	private static final String fileStartString = "i am zhangxiong^*^!";
	
	@Autowired UpLoadSoftService upLoadSoftService;
	@Autowired NcdSoftRepository ncdSoftRepository;
	@Autowired DeviceRepository deviceRepository;
	
	//读取客户端程序版本
	@ResponseBody
	@RequestMapping("QuerySoftInfo")
	public NcdSoft QuerySoftInfoHandler(String softName, String lang){
		
		NcdSoft ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(softName, lang);
		if(ncdSoft == null)
			{
				ncdSoft = new NcdSoft();
				ncdSoft.setDsc(null);
				ncdSoft.setFsize(null);
				ncdSoft.setMD5(null);
				ncdSoft.setVersion(null);
			}

		return ncdSoft;
	}
	//上传客户端程序
	@RequestMapping("UploadSoftFile")
	public String  UploadSoftFileHandler(@RequestParam("file") CommonsMultipartFile file, Map<String, Object> map,
			NcdSoft ncdSoft){

		try {
			StringBuffer stringBuffer = new StringBuffer("/var/NCD_Data/");
			stringBuffer.append(ncdSoft.getName());
			ncdSoft.setFilepath(stringBuffer.toString());

			ncdSoft.setMD5(DigestUtils.md5Hex(file.getInputStream()));
			
			ncdSoft.setFsize(file.getSize());
			
			File newFile=new File(ncdSoft.getFilepath());
			if(!newFile.exists())
				newFile.createNewFile();
			
			file.transferTo(newFile);
			
			upLoadSoftService.saveOrUpdateSoftVersion(ncdSoft);
			
			map.put("status", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "error");
		}
		
		return "DeviceSoftUp";
	}
	
	@RequestMapping("DownloadSoftFile")
	public void  DownloadSoftFileHandler(HttpServletRequest request, 
            HttpServletResponse response, String softName, String lang) throws IOException{

        BufferedInputStream bis = null; 
        BufferedOutputStream bos = null; 
        NcdSoft ncdSoft = null;

        if(softName == null)
			return;
		
        if(lang == null)
			ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(softName, "CH");
		else
			ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(softName, lang);
		
		if(ncdSoft == null)
		{
			Device device = deviceRepository.findDeviceByDid(softName);
			if(device == null)
				return;
			else
			{
				if(lang == null)
					ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(device.getType(), "CH");
				else
					ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(device.getType(), lang);

				if(ncdSoft == null)
					return;
			}
		}
   
        //获取文件的长度
        File file = new File(ncdSoft.getFilepath());
        long fileLength = file.length();
        fileLength += fileStartString.length();
 
        //设置文件输出类型
        response.setContentType("application/octet-stream"); 
        response.setHeader("Content-disposition", "attachment; filename="+file.getName());
        //设置输出长度
        response.setHeader("Content-Length", String.valueOf(fileLength)); 
        //获取输入流
        bis = new BufferedInputStream(new FileInputStream(file)); 
        //输出流
        bos = new BufferedOutputStream(response.getOutputStream());
        
        //先发送一个文件起始字符串i am zhangxiong^*^!
        bos.write(fileStartString.getBytes(), 0, fileStartString.length());
        
        byte[] buff = new byte[2048]; 
        int bytesRead; 
        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) { 
            bos.write(buff, 0, bytesRead); 
        } 
        //关闭流
        bis.close(); 
        bos.close(); 
	}
/*	@RequestMapping("clientDownload")
	public ResponseEntity<byte[]>  clientDownload() throws IOException{
		String path="D:/Program Files/Client.rar";//"/var/NCD_Data/Client.rar";
		File file=new File(path);  
		 
		HttpHeaders headers = new HttpHeaders();    
		headers.setContentDispositionFormData("attachment", file.getName());   
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
		 
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
				headers, HttpStatus.CREATED);
	}
*/	
	
	//读取所有已存在固件名字
	@ResponseBody
	@RequestMapping("QueryAllSoftName")
	public Map<String, List<String>> QueryAllSoftNameHandler(){	
		List<NcdSoft> list = ncdSoftRepository.findAll();
		Map<String, List<String>> map = new HashMap<>();
		Set<String> nameSet = new HashSet<>();
		Set<String> langSet = new HashSet<>();
		
		for (NcdSoft ncdSoft : list) {
			nameSet.add(ncdSoft.getName());
			langSet.add(ncdSoft.getLang());
		}
		
		List<String> nameList = new ArrayList<>();
		map.put("names", nameList);
		Iterator<String> nameIterable = nameSet.iterator();
		while (nameIterable.hasNext()) {
			nameList.add(nameIterable.next());
		}
		
		List<String> langList = new ArrayList<>();
		map.put("langs", langList);
		Iterator<String> langIterable = langSet.iterator();
		while (langIterable.hasNext()) {
			langList.add(langIterable.next());
		}

		return map;
	}

	//读取设备程序版本
		@ResponseBody
		@RequestMapping("deviceSoftInfo")
		public String readDeviceSoftInfoHandler(String softName){
			StringBuffer result = new StringBuffer("error");
			
			if(softName == null)
				return result.toString();
			
			NcdSoft ncdSoft = ncdSoftRepository.findNcdSoftByName(softName);
			
			if(ncdSoft == null)
			{
				Device device = deviceRepository.findDeviceByDid(softName);
				if(device == null)
					return result.toString();
				else 
				{
					ncdSoft = ncdSoftRepository.findNcdSoftByName(device.getType());
					if(ncdSoft == null)
						return result.toString();
				}
			}
			
			result.setLength(0);
			result.append("success version:");
			result.append(ncdSoft.getVersion());
			result.append("#md5:");
			result.append(ncdSoft.getMD5());
			return result.toString();
		}
		
		@ResponseBody
		@RequestMapping("deviceReadSoftByNameAndLang")
		public String deviceReadSoftByNameAndLangHandler(String softName, String lang){
			StringBuffer result = new StringBuffer("error");
			NcdSoft ncdSoft = null;
			
			if(softName == null)
				return result.toString();
			
			if(lang == null)
				ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(softName, "CH");
			else
				ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(softName, lang);
			
			if(ncdSoft == null)
			{
				Device device = deviceRepository.findDeviceByDid(softName);
				if(device == null)
					return result.toString();
				else
				{
					if(lang == null)
						ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(device.getType(), "CH");
					else
						ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(device.getType(), lang);

					if(ncdSoft == null)
						return result.toString();
				}
			}
			
			result.setLength(0);
			result.append("success version:");
			result.append(ncdSoft.getVersion());
			result.append("#md5:");
			result.append(ncdSoft.getMD5());
			return result.toString();
		}
		
		//上传设备程序
		@RequestMapping("deviceCodeUpload")
		public String  deviceCodeUpload(@RequestParam("file") CommonsMultipartFile file, Map<String, Object> map,
				@RequestParam("version") String version){

			try {
				NcdSoft ncdSoft = new NcdSoft(); 
				String path="/var/NCD_Data/Device";
				
				String md5 = DigestUtils.md5Hex(file.getInputStream());
				Long fsize = file.getSize();
				File newFile=new File(path);
				//通过CommonsMultipartFile的方法直接写文件（注意这个时候）
				file.transferTo(newFile);
				
				ncdSoft.setFilepath(path);

				ncdSoft.setMD5(md5);
				
				ncdSoft.setFsize(fsize);
				
				upLoadSoftService.saveOrUpdateSoftVersion(ncdSoft);
				
				map.put("status", "success");
				
			} catch (Exception e) {
				// TODO: handle exception
				map.put("status", "error");
			}
			
			return "UpSoft";
		}
		
		//下载设备程序
		@RequestMapping("deviceCodeDownload")
		public ResponseEntity<byte[]>  deviceCodeDownload() throws IOException{
			String path="/var/NCD_Data/Device";
			File file=new File(path);  
			 
			HttpHeaders headers = new HttpHeaders();
			headers.setContentDispositionFormData("attachment", "NCD_YGFXY.bin");   
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			
			return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
					headers, HttpStatus.CREATED);
		} 
}
