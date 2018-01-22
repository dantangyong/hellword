/**
 * Copyright &copy; 2015-2020 <a href="http://www.mht.org/">mht</a> All rights reserved.
 */
package com.mht.define.portal.cms.web.front;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mht.common.json.AjaxJson;
import com.mht.common.utils.MyBeanUtils;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.RoleSkin;
import com.mht.define.portal.cms.service.RoleSkinService;

/**
 * 用户皮肤Controller
 * @author 王杰
 * @version 2017-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/skin")
public class oldFrontSkinSettingController extends BaseController {

	@Autowired
	private RoleSkinService roleSkinService;
	
	@ModelAttribute
	public RoleSkin get(@RequestParam(required=false) String roleId) {
		RoleSkin entity = null;
		if (StringUtils.isNotBlank(roleId)){
			entity = roleSkinService.get(roleId);
		}
		if (entity == null){
			entity = new RoleSkin();
		}
		return entity;
	}
	

	/**
	 * 保存皮肤
	 */
//	@RequiresPermissions(value={"cms:userSkin:add","cms:userSkin:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "save",method=RequestMethod.POST)
	public AjaxJson save( RoleSkin roleSkin ) throws Exception{
		if(!roleSkin.getIsNewRecord()){//编辑
			RoleSkin t = roleSkinService.get(roleSkin);
			MyBeanUtils.copyBeanNotNull2Bean(roleSkin, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			roleSkinService.save(t);//保存
		}else{//新增
			if(StringUtils.isNotEmpty(roleSkin.getRoleId())){
				roleSkinService.save(roleSkin);//保存
			}
		}
		return new AjaxJson();
	}
	
	@ResponseBody
	@RequestMapping(value = "",method=RequestMethod.GET)
	public AjaxJson getSkin(String roleId){
		RoleSkin roleSkin = roleSkinService.get(roleId);
		AjaxJson json = new AjaxJson();
		json.put("skin", roleSkin);
		json.setCode("10000");
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "upload")
	public AjaxJson uploadSkin(RoleSkin skin, HttpServletRequest request, MultipartFile file) throws Exception{
		if(!skin.getIsNewRecord()){//编辑表单保存
			RoleSkin t = roleSkinService.get(skin.getRoleId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(skin, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			this.roleSkinService.skinUpload(request, file, t);//保存
		}else{//新增表单保存
			this.roleSkinService.skinUpload(request, file, skin);//保存
		}
		return new AjaxJson();
	}
}