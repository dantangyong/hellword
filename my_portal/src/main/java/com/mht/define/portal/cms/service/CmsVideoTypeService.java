package com.mht.define.portal.cms.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.config.Global;
import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsVideoTypeDao;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.CmsVideo;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.modules.sys.entity.User;

@Service
@Transactional(readOnly=true)
public class CmsVideoTypeService extends CrudService<CmsVideoTypeDao, CmsVideoType>{

	@Transactional(readOnly=false)
	public CmsVideoType disable(String id) {
		CmsVideoType videoType = get(id);
		if(Global.ENABLE.equals(videoType.getDisable())){
			videoType.setDisable(Global.DISABLE);
		} else {
			videoType.setDisable(Global.ENABLE);
		}
		save(videoType);
		return get(videoType.getId());
	}

	public Integer getMaxSort() {
		return dao.getMaxSort();
	}

	public List<User> findAuthors(CmsVideo cmsVideo) {
		return dao.findAuthors();
	}

	public CmsVideoType selectByName(CmsVideoType videoType) {
		return dao.selectVideoType(videoType);
	}

	public CmsVideoType getByName(String typeName) {
		return dao.getByName(typeName);
	}
	
	@Transactional(readOnly=false)
	public void sort(String sourceId, String destinationId) {
		CmsVideoType cmsVideoTypeSource = dao.get(sourceId);
		CmsVideoType cmsVideoTypeDestination = dao.get(destinationId);
		int temp = cmsVideoTypeSource.getSort();
		cmsVideoTypeSource.setSort(cmsVideoTypeDestination.getSort());
		cmsVideoTypeDestination.setSort(temp);
		dao.update(cmsVideoTypeDestination);
		dao.update(cmsVideoTypeSource);
		
	}

}
