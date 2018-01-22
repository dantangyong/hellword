package com.mht.define.portal.cms.service;

import java.util.List;

import com.mht.define.portal.cms.entity.SysUser;
import com.mht.define.portal.cms.entity.UserContent;
import com.mht.define.portal.cms.entity.UserContentDate;
import com.mht.modules.sys.entity.User;

public interface NewUserCenterService {

	SysUser selectByPrimaryKey(String id);

	List<UserContent> selectContentByPrimeryKey(String id);

	void InsertContent(UserContent content);

	void DeleteByPrimeryKey(String id);
	
	List<UserContentDate> changeDate(List<UserContent> list);

}
