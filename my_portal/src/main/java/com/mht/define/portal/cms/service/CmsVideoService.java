/**
 * Copyright &copy; 2015-2020 <a href="http://www.mht.org/">mht</a> All rights reserved.
 */
package com.mht.define.portal.cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.config.Global;
import com.mht.common.persistence.Page;
import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsVideoDao;
import com.mht.define.portal.cms.entity.CmsVideo;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.utils.ConstantConfig;
import com.mht.modules.sys.entity.User;

/**
 * 视频Service
 * @author 王杰
 * @version 2017-07-25
 */
@Service
@Transactional(readOnly = true)
public class CmsVideoService extends CrudService<CmsVideoDao, CmsVideo> {
	
	@Autowired
	private CmsVideoDao videoDao;

	public CmsVideo get(String id) {
		return super.get(id);
	}
	
	public List<CmsVideo> findList(CmsVideo cmsVideo) {
		return super.findList(cmsVideo);
	}
	
	public Page<CmsVideo> findPage(Page<CmsVideo> page, CmsVideo cmsVideo) {
		return super.findPage(page, cmsVideo);
	}
	
	@Transactional(readOnly = false)
	public void save(CmsVideo cmsVideo) {
		super.save(cmsVideo);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmsVideo cmsVideo) {
		super.delete(cmsVideo);
	}

	@Transactional(readOnly = false)
	public String disable(String id) {
		CmsVideo video = get(id);
		String info ="";
		if(Global.ENABLE.equals(video.getDisable())){
			video.setDisable(Global.DISABLE);
			info = "视频启用成功";
		} else {
			video.setDisable(Global.ENABLE);
			info = "视频禁用成功";
		}
		save(video);
		return info;
	}

	public List<CmsVideo> findAllList() {
		return videoDao.findAllList(new CmsVideo());
	}

	public List<CmsVideo> selectList(CmsVideo video, PageBean<CmsVideo> pb) {
		video.setCreateBy(new User());
		Number count = videoDao.selectcount();
		pb.setTotalRecods(count.intValue());
		pb.setStart((pb.getPageCode()-1)*pb.getPageSize());
		video.setDisable(Global.ENABLE);
		return videoDao.selectList(video,pb);
	}
	
	@Transactional(readOnly = false)
	public void disableVideo(CmsVideoType videoType) {
		videoDao.disableVideo(videoType);
		
	}
    
	@Transactional(readOnly = false)
	public String recommend(String id) {
		String info = "";
		CmsVideo video = get(id);
		if(ConstantConfig.RECOMMEND.equals(video.getVideoPriority())){
			video.setVideoPriority(ConstantConfig.DISRECOMMEND);
			info = "视频取消推荐成功";
		} else {
			video.setVideoPriority(ConstantConfig.RECOMMEND);
			info = "视频推荐成功";
		}
		save(video);
		return info;
	}
    
	@Transactional(readOnly = false)
	public void updateHitsAddOne(String id) {
		dao.updateHitsAddOne(id);
		
	}
    
	@Transactional(readOnly = false)
	public void sort(String sourceId, String destinationId) {
		CmsVideo videoSource = dao.get(sourceId);
		CmsVideo videoDestination = dao.get(destinationId);
		int temp = videoSource.getSort();
		videoSource.setSort(videoDestination.getSort());
		videoDestination.setSort(temp);
		dao.update(videoDestination);
		dao.update(videoSource);
		
	}
	
}
















