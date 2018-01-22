package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;
import com.mht.modules.sys.entity.Role;

/**
 * 
 * @ClassName: AppAuthRole
 * @Description: 应用角色授权
 * @author wangjie
 * @date 2017年7月28日 上午10:39:44 
 * @version 1.0.0
 */
public class AppAuthRole extends DataEntity<AppAuthRole>{

	private static final long serialVersionUID = 1L;

    /**
     * 被授权的角色
     */
    private Role role;
    
    /**
     * 被授权的应用
     */
    private FrontApp app;
    
    /**
     * 访问权限（0:无  1：有）
     */
    private String accessAuth;
    
    private String roleId;
    private String appId;
    
	public FrontApp getApp() {
		return app;
	}
	public void setApp(FrontApp app) {
		this.app = app;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public String getAccessAuth() {
		return accessAuth;
	}
	public void setAccessAuth(String accessAuth) {
		this.accessAuth = accessAuth;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
    
}
