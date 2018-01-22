package com.mht.define.portal.cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.common.utils.IdGen;
import com.mht.define.portal.cms.dao.NavigationDao;
import com.mht.define.portal.cms.entity.DisplaySetting;
import com.mht.define.portal.cms.entity.Navigation;

/**
 * 导航service
 * @author 王杰
 *
 */
@Service
@Transactional(readOnly=true)
public class NavigationService extends CrudService<NavigationDao, Navigation> {
	
	@Autowired
	private NavigationDao dao;
	
	@Transactional(readOnly=false)
	public List<Navigation> findByDisplay(DisplaySetting displaySetting) {
		List<Navigation> allNavis = dao.findByDisplay(displaySetting.getId());
		for (Navigation navigation : allNavis) {
			List<Navigation> children = dao.findChildren(navigation.getId());
			for (Navigation child : children) {
				List<Navigation> allKids = dao.findChildren(child.getId());
				child.setChildren(allKids);
			}
			navigation.setChildren(children);
		}
		return allNavis;
	}

	public List<Navigation> findChildren(String id) {
		return dao.findChildren(id);
	}

	@Transactional(readOnly=false)
	public void saveAll(Navigation navigation) {
		if (navigation.getIsNewRecord()){
			navigation.preInsert();
			dao.insert(navigation);
			List<Navigation> children = navigation.getChildren();
			if (children.size() > 0){
				for (Navigation child : children) {
					child.preInsert();
					child.setParentId(navigation.getId());
					dao.insert(child);
					List<Navigation> kids = child.getChildren();
					if(kids.size() > 0){
						for (Navigation kid : kids) {
							kid.preInsert();
							kid.setParentId(child.getId());
							dao.insert(kid);
						}
					}
				}
			}
		} else {
			navigation.preUpdate();
			dao.update(navigation);
			List<Navigation> children = navigation.getChildren();
			for (Navigation child : children) {
				if(child.getIsNewRecord()){
					child.preInsert();
					child.setParentId(navigation.getId());
					dao.insert(child);
					List<Navigation> kids = child.getChildren();
					for (Navigation kid : kids) {
						kid.preInsert();
						kid.setParentId(child.getId());
						dao.insert(kid);
					}
				} else {
					child.preUpdate();
					dao.update(child);
				}
				List<Navigation> kids = child.getChildren();
				for (Navigation kid : kids) {
					if(kid.getIsNewRecord()){
						kid.preInsert();
						kid.setParentId(child.getId());
						dao.insert(kid);
					} else {
						kid.preUpdate();
						dao.update(kid);
					}
				}
			}
		}
	}

}
