package com.mht.define.portal.cms.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.config.Global;
import com.mht.common.persistence.Page;
import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.NewNoticeDao;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.NewNotice;
import com.mht.define.portal.cms.entity.PageBean;

@Transactional(readOnly = true)
@Service
public class NewNoticeService extends CrudService<NewNoticeDao, NewNotice> {

	@Autowired
	private NewNoticeDao newNoticeDao;
	
	public NewNotice get(String id) {
		NewNotice entity = dao.get(id);
		return entity;
	}
	
	
	public Page<NewNotice> find(Page<NewNotice> page, NewNotice newNotice) {
		newNotice.setPage(page);
		page.setList(dao.findList(newNotice));
		return page;
	}
	
	
	@Transactional(readOnly = false)
	public void save(NewNotice oaNotify) {
		super.save(oaNotify);
	}
	

	public NewNotice selectClickNotice(String name) {
		return newNoticeDao.selectClickNotice(name);
	}

	
	public List<NewNotice> selectByNotify(PageBean pb) {
		Number count = newNoticeDao.selectcount();
		pb.setTotalRecods(count.intValue());
		pb.setStart((pb.getPageCode()-1)*10);
		return newNoticeDao.selectByNotify(pb);
	}

	
	public List<NewNotice> selectByNotifyKeys(PageBean pb) {
		Number count = newNoticeDao.selectcountByKeys(pb);
		pb.setTotalRecods(count.intValue());
		pb.setStart((pb.getPageCode()-1)*10);
		return newNoticeDao.selectByNotify(pb);
	}

	@Transactional(readOnly = false)
	public String disable(String id) {
		NewNotice notice = get(id);
		String info = "";
		if(Global.ENABLE.equals(notice.getStatus())){
			notice.setStatus(Global.DISABLE);
			info = "公告禁用成功";
		} else {
			notice.setStatus(Global.ENABLE);
			info = "公告启用成功";
		}
		save(notice);
		return info;
	}
	
	public String selectNotice(String string) {
		// TODO Auto-generated method stub
		return newNoticeDao.selectNotice(string);
	}  
	
	@Transactional(readOnly = false)
	public void deleteByLogic(NewNotice newNotice) {
		 newNoticeDao.deleteByLogic(newNotice);
	} 

}
