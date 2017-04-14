package com.xsx.ncd.handler;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.NcdSoft;
import com.xsx.ncd.service.UpLoadSoftService;

@Controller
public class FileUpLoadHandler {
	
	@Autowired UpLoadSoftService upLoadSoftService;
	
	//读取客户端程序版本
	@ResponseBody
	@RequestMapping("clientSoftInfo")
	public String readClientSoftInfoHandler(){
		
		NcdSoft ncdSoft = upLoadSoftService.readSoftInfo("Client");
		
		if(ncdSoft == null)
			return "error";
		else
			return "success version:"+ncdSoft.getVersion()+"#md5:"+ncdSoft.getMD5();
	}
	//上传客户端程序
	@RequestMapping("clientUpload")
	public String  clientfileUpload(@RequestParam("file") CommonsMultipartFile file, Map<String, Object> map,
			@RequestParam("version") String version){

		try {
			String path="/var/NCD_Data/Client.rar";
			
			String md5 = DigestUtils.md5Hex(file.getInputStream());
			Long fsize = file.getSize();
			File newFile=new File(path);
			//通过CommonsMultipartFile的方法直接写文件（注意这个时候）
			file.transferTo(newFile);
			
			upLoadSoftService.saveOrUpdateSoftVersion("Client", version, md5, null, fsize);
			
			map.put("status", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "error");
		}
		
		return "UpSoft";
	}
	
	//下载客户端程序
	@RequestMapping("clientDownload")
	public void  clientDownload(HttpServletRequest request, 
            HttpServletResponse response) throws IOException{

        BufferedInputStream bis = null; 
        BufferedOutputStream bos = null; 

        //获取下载文件露肩
        String downLoadPath = "/var/NCD_Data/Client.rar"; 
   
        //获取文件的长度
        long fileLength = new File(downLoadPath).length(); 
 
        //设置文件输出类型
        response.setContentType("application/octet-stream"); 
        response.setHeader("Content-disposition", "attachment; filename=Client.rar");
        //设置输出长度
        response.setHeader("Content-Length", String.valueOf(fileLength)); 
        //获取输入流
        bis = new BufferedInputStream(new FileInputStream(downLoadPath)); 
        //输出流
        bos = new BufferedOutputStream(response.getOutputStream()); 
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
	//读取客户端补丁程序版本
	@ResponseBody
	@RequestMapping("cPathSoftInfo")
	public String readCPathSoftInfoHandler(){
		
		NcdSoft ncdSoft = upLoadSoftService.readSoftInfo("CPath");
		
		if(ncdSoft == null)
			return "error";
		else
			return "success version:"+ncdSoft.getVersion()+"#md5:"+ncdSoft.getMD5();
	}
	//上传客户端程序
	@RequestMapping("cPathUpload")
	public String  cPathfileUpload(@RequestParam("file") CommonsMultipartFile file, Map<String, Object> map,
			@RequestParam("version") String version){

		try {
			String path="/var/NCD_Data/CPath.rar";
			
			String md5 = DigestUtils.md5Hex(file.getInputStream());
			Long fsize = file.getSize();
			File newFile=new File(path);
			//通过CommonsMultipartFile的方法直接写文件（注意这个时候）
			file.transferTo(newFile);
			
			upLoadSoftService.saveOrUpdateSoftVersion("CPath", version, md5, null, fsize);
			
			map.put("status", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "error");
		}
		
		return "UpSoft";
	}
	
	//下载客户端程序
	@RequestMapping("cPathDownload")
	public ResponseEntity<byte[]>  cPathDownload() throws IOException{
		String path="/var/NCD_Data/CPath.rar";
		File file=new File(path);  
		 
		HttpHeaders headers = new HttpHeaders();    
		headers.setContentDispositionFormData("attachment", file.getName());   
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
		 
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
				headers, HttpStatus.CREATED);
	}	
	
	
	//读取设备程序版本
	@ResponseBody
	@RequestMapping("deviceSoftInfo")
	public String readDeviceSoftInfoHandler(){
		
		NcdSoft ncdSoft = upLoadSoftService.readSoftInfo("Device");
		
		if(ncdSoft == null)
			return "error";
		else
			return "success version:"+ncdSoft.getVersion()+"#md5:"+ncdSoft.getMD5();
	}
	
	//上传设备程序
	@RequestMapping("deviceCodeUpload")
	public String  deviceCodeUpload(@RequestParam("file") CommonsMultipartFile file, Map<String, Object> map,
			@RequestParam("version") String version){

		try {
			String path="/var/NCD_Data/NCD_YGFXY.bin";
			
			String md5 = DigestUtils.md5Hex(file.getInputStream());
			Long fsize = file.getSize();
			File newFile=new File(path);
			//通过CommonsMultipartFile的方法直接写文件（注意这个时候）
			file.transferTo(newFile);
			
			upLoadSoftService.saveOrUpdateSoftVersion("Device", version, md5, null, fsize);
			
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
		String path="/var/NCD_Data/NCD_YGFXY.bin";
		File file=new File(path);  
		 
		HttpHeaders headers = new HttpHeaders();    
		headers.setContentDispositionFormData("attachment", file.getName());   
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
		 
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
				headers, HttpStatus.CREATED);
	}	
}
