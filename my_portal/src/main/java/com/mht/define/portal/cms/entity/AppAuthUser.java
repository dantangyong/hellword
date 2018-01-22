package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;
import com.mht.modules.sys.entity.User;

/**
 * 
 * @ClassName: AppAuthUser
 * @Description: 应用用户授权
 * @author wangjie
 * @date 2017年7月28日 上午10:39:27 
 * @version 1.0.0
 */
public class AppAuthUser extends DataEntity<AppAuthUser> {

	private static final long serialVersionUID = 1L;

	 /**
     * 被授权的用户
     */
    private User user;
    
    /**
     * 被授权的应用
     */
    private FrontApp app;
    
    /**
     * 访问权限（0:无  1：有）
     */
    private String accessAuth;
    
    private String userId;
    private String appId;//应用ID 
    
	public FrontApp getApp() {
		return app;
	}
	public void setApp(FrontApp app) {
		this.app = app;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getAccessAuth() {
		return accessAuth;
	}
	public void setAccessAuth(String accessAuth) {
		this.accessAuth = accessAuth;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
    
}
