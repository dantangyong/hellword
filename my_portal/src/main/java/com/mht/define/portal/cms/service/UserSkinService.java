/**
 * Copyright &copy; 2015-2020 <a href="http://www.mht.org/">mht</a> All rights reserved.
 */
package com.mht.define.portal.cms.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.mht.common.config.Global;
import com.mht.common.service.CrudService;
import com.mht.common.utils.FileUtils;
import com.mht.define.portal.cms.dao.UserSkinDao;
import com.mht.define.portal.cms.entity.UserSkin;

/**
 * 用户皮肤Service
 * @author 王杰
 * @version 2017-08-01
 */
@Service
@Transactional(readOnly = true)
public class UserSkinService extends CrudService<UserSkinDao, UserSkin> {

	public UserSkin get(String id) {
		return super.get(id);
	}
	
	@Transactional(readOnly = false)
	public void save(UserSkin roleSkin) {
		super.save(roleSkin);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserSkin roleSkin) {
		super.delete(roleSkin);
	}

	@Transactional(readOnly = false)
	public void skinUpload(HttpServletRequest request, MultipartFile file, UserSkin skin) throws IllegalStateException, IOException {
		String fileName = file.getOriginalFilename();
		boolean message = file != null && file.getInputStream() != null 
				&& StringUtils.isNotBlank(fileName);
		if (message) {
				//修改文件名
				String uuid = UUID.randomUUID().toString();
				fileName = uuid + fileName.substring(fileName.lastIndexOf("."), fileName.length());
				String webPath = request.getSession().getServletContext().getRealPath("/")+ "static";
				// 转存文件
				File document = new File(webPath + Global.PORTAL_SKIN_URL);
				if(!document.exists()){
					FileUtils.createDirectory(webPath + Global.PORTAL_SKIN_URL);
				}
				file.transferTo(new File(webPath + Global.PORTAL_SKIN_URL + fileName));
				String iconUrl = request.getContextPath()+ "/static"+ Global.PORTAL_SKIN_URL + fileName;
				skin.setIsUpload(true);
				skin.setImageUrl(iconUrl);
		}
		super.save(skin);
		
	}
	
	
	
	
}