package com.mht.define.portal.cms.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.AppAuthUserDao;
import com.mht.define.portal.cms.entity.AppAuthUser;

@Service
@Transactional(readOnly = true)
public class AppAuthUserService extends CrudService<AppAuthUserDao, AppAuthUser> {

	public List<AppAuthUser> findListByUserId(String id) {
		List<AppAuthUser> applist = dao.findListByUserId(id);
        return applist;
	}

	@Transactional(readOnly = false)
	public void saveAuths(List<AppAuthUser> list, String userId) {
		 this.dao.deleteByUserId(userId);
	        if (list != null) {
	            for (AppAuthUser appUser : list) {
	            	appUser.preInsert();
	                this.dao.insert(appUser);
	            }
	        }
		
	}

}
