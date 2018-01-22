package com.mht.define.portal.cms.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.FastArrayList;
import org.codehaus.groovy.util.FastArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.mht.common.config.Global;
import com.mht.common.exception.BusinessException;
import com.mht.common.service.CrudService;
import com.mht.common.utils.FileUtils;
import com.mht.common.utils.IdGen;
import com.mht.common.utils.StringUtils;
import com.mht.define.portal.cms.dao.DisplaySettingDao;
import com.mht.define.portal.cms.entity.DisplaySetting;
import com.mht.modules.sys.utils.UserUtils;
/**
 * 显示设置service
 * @author 王杰
 *
 */
@Service
@Transactional(readOnly = true)
public class DisplaySettingService extends CrudService<DisplaySettingDao, DisplaySetting> {

	@Autowired
	private DisplaySettingDao dao;
	
	@Transactional(readOnly = false)
	public DisplaySetting savePic( HttpServletRequest request,DisplaySetting displaySetting, MultipartFile file) throws IOException {
		//文件上传
		boolean message = file != null && file.getInputStream() != null 
				&& StringUtils.isNotBlank(file.getOriginalFilename());
		if (message) {
			String userName = displaySetting.getLogo();
			String fileName = file.getOriginalFilename();
			boolean isnew = StringUtils.isNotBlank(fileName) && !fileName.equals(userName);
			if (isnew) {
				//修改文件名
				String uuid = IdGen.uuid();
				fileName = uuid + fileName.substring(fileName.lastIndexOf("."), fileName.length());
				//获取全路径
				String path = Global.USERFILES_BASE_URL + UserUtils.getPrincipal() + Global.SYSTEM_DISPLAY_URL;
				// 转存文件
	            FileUtils.createDirectory(Global.getUserfilesBaseDir() + path);
	            file.transferTo(new File(Global.getUserfilesBaseDir() + path + fileName));
	            String picName= request.getContextPath() + path + fileName;
				displaySetting.setLogo(picName);
			}
		}
		if (displaySetting.getIsNewRecord()){
			displaySetting.preInsert();
			displaySetting.setId(IdGen.uuid());
			dao.insert(displaySetting);
			return dao.get(IdGen.uuid());
		}else{
			displaySetting.preUpdate();
			dao.update(displaySetting);
			return dao.get(displaySetting.getId());
		}
	}
	
	@Transactional(readOnly = false)
	public void saveTheme(DisplaySetting displaySetting) {
		if (displaySetting.getIsNewRecord()){
			displaySetting.preInsert();
			displaySetting.setId(IdGen.uuid());
			dao.insert(displaySetting);
		}else{
			DisplaySetting display = dao.get(displaySetting.getId());
			if(StringUtils.isNotBlank(display.getTheme())){
				StringBuffer theme = new StringBuffer(display.getTheme());
				if(StringUtils.isNotBlank(displaySetting.getTheme())){
					String[] themes = StringUtils.split(display.getTheme(), ",");
					for (String oldTheme : themes) {
						if(oldTheme.equals(displaySetting.getTheme())){
							throw new BusinessException("主题已经存在，不能重复添加。"); 
						}
					}
					theme.append(","+displaySetting.getTheme());
				}
				displaySetting.setTheme(theme.toString());
			}
			displaySetting.preUpdate();
			dao.update(displaySetting);
		}
	}
	
	@Transactional(readOnly = false)
	public void delTheme(DisplaySetting displaySetting) {
		DisplaySetting display = dao.get(displaySetting.getId());
		List<String> allTheme = new ArrayList<String>();
		String[] themes = StringUtils.split(display.getTheme(), ",");
		for (String theme : themes) {
			allTheme.add(theme);
		}
		for(Iterator<String> it = allTheme.iterator(); it.hasNext();) {
			String next = it.next();
			if(next.equals(displaySetting.getTheme())){
				it.remove();
			}
		}
		String newTheme = StringUtils.join(allTheme, ",");
		displaySetting.setTheme(newTheme);
		displaySetting.preUpdate();
		dao.update(displaySetting);
	}
	@Transactional(readOnly = false)
	public void delPic(DisplaySetting displaySetting) {
		DisplaySetting display = dao.get(displaySetting.getId());
		display.setLogo(null);
		dao.update(display);
	}

	@Transactional(readOnly = false)
	public DisplaySetting saveFreq(DisplaySetting display) {
		if (display.getIsNewRecord()){
			display.preInsert();
			display.setId(IdGen.uuid());
			dao.insert(display);
			return dao.get(IdGen.uuid());
		}else{
			DisplaySetting freq = dao.get(display.getId());
			freq.setFrequency(display.getFrequency());
			freq.preUpdate();
			dao.update(freq);
			return dao.get(freq.getId());
		}
	}

	@Transactional(readOnly = false)
	public void savePics(HttpServletRequest request, DisplaySetting displaySetting, MultipartFile[] files) throws IOException {
		//文件上传
		System.out.println(files.length);
		if (files.length > 0) {
			StringBuilder fileNames = new StringBuilder();
			for (MultipartFile file : files) {
				String fileName = file.getOriginalFilename();
				boolean isnew = StringUtils.isNotBlank(fileName);
				if (isnew) {
					//修改文件名
					String uuid = IdGen.uuid();
					fileName = uuid + fileName.substring(fileName.lastIndexOf("."), fileName.length());
					//获取全路径
					String path = Global.USERFILES_BASE_URL + UserUtils.getPrincipal() + Global.SYSTEM_DISPLAY_URL;
					// 转存文件
		            FileUtils.createDirectory(Global.getUserfilesBaseDir() + path);
		            file.transferTo(new File(Global.getUserfilesBaseDir() + path + file.getOriginalFilename()));
		            String picName= request.getContextPath() + path + file.getOriginalFilename();
					if(fileNames.length() == 0){
						fileNames.append(picName);
					} else {
						fileNames.append("," + picName);
					}
				}
			}
			displaySetting.setCarousel(fileNames.toString());
		}
		if (displaySetting.getIsNewRecord()){
			displaySetting.preInsert();
			displaySetting.setId(IdGen.uuid());
			dao.insert(displaySetting);
		}else{
			displaySetting.preUpdate();
			dao.update(displaySetting);
		}
	}

}
