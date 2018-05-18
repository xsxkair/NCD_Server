package com.xsx.ncd.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.xsx.ncd.entity.NcdSoft;

public interface NcdSoftRepository extends JpaRepository<NcdSoft, Integer>{
	
	public NcdSoft findNcdSoftByName(String softname);
	
	public NcdSoft findNcdSoftByNameAndLang(String softname, String lang);
	
	@Query("select name from NcdSoft")
	public List<String> queryAllSoftName();
	
	@Query("select name, version from NcdSoft")
	public List<Object[]> queryAllSoftNameAndVersion();
}
