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
import com.xsx.ncd.repository.NcdSoftRepository;
import com.xsx.ncd.service.UpLoadSoftService;

@Controller
public class FileUpLoadHandler {
	
	private static final String fileStartString = "i am zhangxiong^*^!";
	
	@Autowired UpLoadSoftService upLoadSoftService;
	@Autowired NcdSoftRepository ncdSoftRepository;
	
	//读取客户端程序版本
	@ResponseBody
	@RequestMapping("QuerySoftInfo")
	public NcdSoft QuerySoftInfoHandler(String softName){
		
		NcdSoft ncdSoft = ncdSoftRepository.findNcdSoftByName(softName);
        if(ncdSoft == null){
        	if("Client".equals(softName) || "CPath".equals(softName)){
        		return null;
        	}
        	else{
        		//查找通用设备程序
        		ncdSoft = ncdSoftRepository.findNcdSoftByName("Device");
        	}
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
			//通过CommonsMultipartFile的方法直接写文件（注意这个时候）
			file.transferTo(newFile);
			
			upLoadSoftService.saveOrUpdateSoftVersion(ncdSoft);
			
			map.put("status", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "error");
		}
		
		return "UpSoft";
	}
	
	@RequestMapping("DownloadSoftFile")
	public void  DownloadSoftFileHandler(HttpServletRequest request, 
            HttpServletResponse response, String softName) throws IOException{

        BufferedInputStream bis = null; 
        BufferedOutputStream bos = null; 

        if(softName == null)
        	return;
        
        NcdSoft ncdSoft = ncdSoftRepository.findNcdSoftByName(softName);
        if(ncdSoft == null){
        	if("Client".equals(softName) || "CPath".equals(softName)){
        		return;
        	}
        	else{
        		//查找通用设备程序
        		ncdSoft = ncdSoftRepository.findNcdSoftByName("Device");
        	}
        }
        
        if(ncdSoft == null)
        	return;
   
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

}
