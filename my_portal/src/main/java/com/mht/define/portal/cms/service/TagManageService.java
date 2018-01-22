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
import com.mht.define.portal.cms.dao.TagManageDao;
import com.mht.define.portal.cms.entity.TagManage;

@Service
@Transactional(readOnly = true)
public class TagManageService extends CrudService<TagManageDao, TagManage> {

	@Transactional(readOnly = false)
	public void save(HttpServletRequest request, MultipartFile file, TagManage tag) throws IOException {
		String fileName = file.getOriginalFilename();
		boolean message = file != null && file.getInputStream() != null 
				&& StringUtils.isNotBlank(fileName);
		if (message) {
			//修改文件名
			String uuid = UUID.randomUUID().toString();
			fileName = uuid + fileName.substring(fileName.lastIndexOf("."), fileName.length());
			String webPath = request.getSession().getServletContext().getRealPath("/");
			String displayUrl = webPath +"/upload"+ Global.SYSTEM_DISPLAY_URL;
			// 转存文件
			File document = new File(displayUrl);
			if(!document.exists()){
				FileUtils.createDirectory(displayUrl);
			}
			file.transferTo(new File(displayUrl + fileName));
			String logoUrl = request.getContextPath()+"/upload"+ Global.SYSTEM_DISPLAY_URL + fileName;
			tag.setLogoUrl(logoUrl);
		}
		logger.info("===================="+tag.getEdition());
		super.save(tag);
		
	}
}
