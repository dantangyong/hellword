package com.mht.define.portal.cms.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.mht.common.config.Global;
import com.mht.common.persistence.Page;
import com.mht.common.service.CrudService;
import com.mht.common.utils.FileUtils;
import com.mht.common.utils.IdGen;
import com.mht.define.portal.cms.dao.CmsBannerDao;
import com.mht.define.portal.cms.entity.CmsBanner;

/**
 * bannerService
 * @author 王杰
 * @version 2017-07-05
 */
@Service
@Transactional(readOnly = true)
public class CmsBannerService extends CrudService<CmsBannerDao, CmsBanner>{

	@Transactional(readOnly = false)
	public void disable(CmsBanner banner) {
		if(Global.ENABLE.equals(banner.getDisable())){
			banner.setDisable(Global.DISABLE);
		} else {
			banner.setDisable(Global.ENABLE);
		}
		dao.update(banner);
	}

	public CmsBanner get(String id) {
		return super.get(id);
	}
	
	public List<CmsBanner> findList(CmsBanner cmsBanner) {
		return super.findList(cmsBanner);
	}
	
	public Page<CmsBanner> findPage(Page<CmsBanner> page, CmsBanner CmsBanner) {
		return super.findPage(page, CmsBanner);
	}
	
	@Transactional(readOnly = false)
	public void save(CmsBanner CmsBanner) {
		super.save(CmsBanner);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmsBanner CmsBanner) {
		super.delete(CmsBanner);
	}
	
	@Transactional(readOnly = false)
	public void bannerSave(HttpServletRequest request, MultipartFile file, CmsBanner cmsBanner) throws IOException {
		String fileName = file.getOriginalFilename();
		boolean message = file != null && file.getInputStream() != null 
				&& StringUtils.isNotBlank(fileName);
		if (message) {
			 String uuid = IdGen.uuid();
	            fileName =uuid + fileName.substring(fileName.lastIndexOf("."), fileName.length());
	            String webPath = request.getSession().getServletContext().getRealPath("/");
	            // 转存文件
	            File document = new File(webPath + Global.VIDEO_BANNER_URL);
	            if(!document.exists()){
	                FileUtils.createDirectory(webPath + Global.VIDEO_BANNER_URL);
	            }
	            file.transferTo(new File(webPath + Global.VIDEO_BANNER_URL + fileName));
	            String iconUrl = request.getContextPath()+ Global.VIDEO_BANNER_URL + fileName;
	            cmsBanner.setImageUrl(iconUrl);
		}
		super.save(cmsBanner);
	}

	public List<CmsBanner> getShowBanners( CmsBanner banner) {
		return dao.getShowBanners(banner);
	}

	@Transactional(readOnly=false)
	public void sort(String sourceId, String destinationId) {
		CmsBanner source = dao.get(sourceId);
		CmsBanner destination = dao.get(destinationId);
		int temp = source.getSort();
		source.setSort(destination.getSort());
		destination.setSort(temp);
		dao.update(destination);
		dao.update(source);
	}

	public int getEnableCount() {
		return dao.getEnableCount();
	}

}
