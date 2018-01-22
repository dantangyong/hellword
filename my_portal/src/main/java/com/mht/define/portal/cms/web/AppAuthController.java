package com.mht.define.portal.cms.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser.Feature;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mht.common.json.AjaxJson;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.AppAuthRole;
import com.mht.define.portal.cms.entity.AppAuthUser;
import com.mht.define.portal.cms.service.AppAuthRoleService;
import com.mht.define.portal.cms.service.AppAuthUserService;
import com.mht.modules.sys.entity.Role;
import com.mht.modules.sys.entity.User;

/**
 * 
 * @ClassName: AuthController
 * @Description: 门户权限管理
 * @author wangjie
 * @date 2017年7月28日 上午9:27:33 
 * @version 1.0.0
 */
@Controller
@RequestMapping(value="${adminPath}/portal/auth")
public class AppAuthController extends BaseController {
	
	@Autowired
	private AppAuthRoleService authRoleService;
	
	@Autowired
	private AppAuthUserService authUserService;

	/**
	 * 门户角色授权 == 页面
	 * @Title: roleIndex
	 * @Description: TODO
	 * @Description: TODO
	 * @return String
	 * @author wangjie
	 */
	@RequiresPermissions("portal:authRole:list")
	@RequestMapping("role")
	public String roleIndex(){
		return "/define/portal/authRole";
	}
	
	/**
	 * 门户角色授权 == 数据
	 * @Title: roleList 
	 * @Description: TODO
	 * @return String
	 * @author wangjie
	 */
	@RequiresPermissions("portal:authRole:list")
	@RequestMapping(value="roleList")
	public String roleList( Model model, Role role ){
		List<AppAuthRole> list = null;
		if(StringUtils.isBlank(role.getId())){
			list = new ArrayList<>();
			role = new Role();
			this.addMessage(model, "角色信息错误");
		}else{
			list = authRoleService.findListByRoleId(role.getId());
		}
		model.addAttribute("role", role);
		model.addAttribute("list", list);
		return "/define/portal/roleAppList";
	}
	
	/**
	 * 门户用户授权 == 页面
	 * @Title: roleIndex
	 * @Description: TODO
	 * @Description: TODO
	 * @return String
	 * @author wangjie
	 */
	@RequiresPermissions("portal:authUser:list")
	@RequestMapping("user")
	public String userIndex(){
		return "/define/portal/authUser";
	}
	
	/**
	 * 门户用户授权 == 数据
	 * @Title: userList 
	 * @Description: TODO
	 * @return String
	 * @author wangjie
	 */
	@RequiresPermissions("portal:authUser:list")
	@RequestMapping(value="userList")
	public String userList( Model model, User user ){
		List<AppAuthUser> list = null;
		if(StringUtils.isBlank(user.getId())){
			list = new ArrayList<>();
			user = new User();
			this.addMessage(model, "用户信息错误");
		}else{
			list = authUserService.findListByUserId(user.getId());
		}
		model.addAttribute("user", user);
		model.addAttribute("list", list);
		return "/define/portal/userAppList";
	}

	/**
	 * 
	 * @Title: save 
	 * @Description: 应用角色授权
	 * @param authRoleForm
	 * @param role
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException AjaxJson
	 * @author wangjie
	 */
//	@RequiresPermissions("portal:authRole:save")
	@ResponseBody
	@RequestMapping(value = "/saveRole",method=RequestMethod.POST)
	public AjaxJson saveRole(String authRoleForm,Role role) throws JsonParseException, JsonMappingException, IOException{
			authRoleForm = StringEscapeUtils.unescapeHtml4(authRoleForm);
	        ObjectMapper jacksonMapper = new ObjectMapper();
	        jacksonMapper.configure(Feature.ALLOW_SINGLE_QUOTES, true);
	        jacksonMapper.configure(Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
	        JavaType javaType = null;
	        javaType = jacksonMapper.getTypeFactory().constructParametricType(List.class, AppAuthRole.class);
	        List<AppAuthRole> list = jacksonMapper.readValue(authRoleForm, javaType);
	        this.authRoleService.saveForm(list, role.getId());
	        return new AjaxJson();
	}
	/**
	 * 
	 * @Title: save 
	 * @Description: 应用用户授权
	 * @param authUserForm
	 * @param role
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException AjaxJson
	 * @author wangjie
	 */
//	@RequiresPermissions("portal:authRole:save")
	@ResponseBody
	@RequestMapping(value = "/saveUser",method=RequestMethod.POST)
	public AjaxJson saveUser(String authUserForm,String userId) throws JsonParseException, JsonMappingException, IOException{
		authUserForm = StringEscapeUtils.unescapeHtml4(authUserForm);
        ObjectMapper jacksonMapper = new ObjectMapper();
        jacksonMapper.configure(Feature.ALLOW_SINGLE_QUOTES, true);
        jacksonMapper.configure(Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
        JavaType javaType = null;
        javaType = jacksonMapper.getTypeFactory().constructParametricType(List.class, AppAuthUser.class);
        List<AppAuthUser> list = jacksonMapper.readValue(authUserForm, javaType);
        this.authUserService.saveAuths(list, userId);
		return new AjaxJson();
	}
}
