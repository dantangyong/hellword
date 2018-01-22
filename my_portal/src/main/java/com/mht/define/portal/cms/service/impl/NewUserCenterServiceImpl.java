package com.mht.define.portal.cms.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mht.define.portal.cms.dao.SysUserDao;
import com.mht.define.portal.cms.dao.UserContentDao;
import com.mht.define.portal.cms.entity.SysUser;
import com.mht.define.portal.cms.entity.UserContent;
import com.mht.define.portal.cms.entity.UserContentDate;
import com.mht.define.portal.cms.service.NewUserCenterService;
import com.mht.modules.sys.entity.User;
@Service
public class NewUserCenterServiceImpl implements NewUserCenterService{
	@Autowired
	private SysUserDao userDao;
	@Autowired
	private UserContentDao userContentDao;
	@Override
	public SysUser selectByPrimaryKey(String id) {
		
		return userDao.selectByPrimaryKey(id);
	}
	@Override
	public List<UserContent> selectContentByPrimeryKey(String id) {
		return userContentDao.selectByUserId(id);
	}
	@Override
	public void InsertContent(UserContent content) {
		userContentDao.insert(content);
		
	}
	@Override
	public void DeleteByPrimeryKey(String id) {
		userContentDao.deleteByPrimaryKey(id);		
	}
	
	@Override
	public List<UserContentDate> changeDate(List<UserContent> list) {
		List<UserContentDate> listDate = new ArrayList<>();
		
		SimpleDateFormat formatter = new SimpleDateFormat("d/M/yyyy HH:mm");
		   String dateString = "";
		   String[] parts = new String[2];
		for (int i = 0; i < list.size(); i++) {
			listDate.add(new UserContentDate()); 
			dateString = formatter.format(list.get(i).getEventTime());
			parts = dateString.split(" ");
			listDate.get(i).setEventTimeY(parts[0]); 
			listDate.get(i).setEventTimeM(parts[1]); 
			listDate.get(i).setId(list.get(i).getId());
			listDate.get(i).setUserId(list.get(i).getUserId());
			listDate.get(i).setEventContent(list.get(i).getEventContent());
			listDate.get(i).setCreateBy(list.get(i).getCreateBy());
			listDate.get(i).setCreateDate(list.get(i).getCreateDate());
			listDate.get(i).setRemarks(list.get(i).getRemarks());
		}
		return listDate;
	}

}
