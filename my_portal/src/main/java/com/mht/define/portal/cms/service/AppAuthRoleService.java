package com.mht.define.portal.cms.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.AppAuthRoleDao;
import com.mht.define.portal.cms.entity.AppAuthRole;

@Service
@Transactional(readOnly = true)
public class AppAuthRoleService extends CrudService<AppAuthRoleDao, AppAuthRole> {

	public List<AppAuthRole> findListByRoleId(String id) {
    	List<AppAuthRole> applist = dao.findListByRoleId(id);
        return applist;
	}

	@Transactional(readOnly = false)
	public void saveForm(List<AppAuthRole> list, String roleId) {
		// 删除原有数据
		this.dao.deleteByRoleId(roleId);
		if (list != null) {
			for (AppAuthRole appRole : list) {
				appRole.preInsert();
				dao.insert(appRole);
			}
		}
	}

}
