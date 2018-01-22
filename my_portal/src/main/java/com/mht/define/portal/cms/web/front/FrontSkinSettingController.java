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
import com.mht.define.portal.cms.entity.UserSkin;
import com.mht.define.portal.cms.service.UserSkinService;

/**
 * 用户皮肤Controller
 * @author 王杰
 * @version 2017-08-01
 */
@Controller
@RequestMapping(value = "${frontPath}/skin")
public class FrontSkinSettingController extends BaseController {

	@Autowired
	private UserSkinService userSkinService;
	
	@ModelAttribute
	public UserSkin get(@RequestParam(required=false) String userId) {
		UserSkin entity = null;
		if (StringUtils.isNotBlank(userId)){
			entity = userSkinService.get(userId);
		}
		if (entity == null){
			entity = new UserSkin();
		}
		return entity;
	}
	

	/**
	 * 保存皮肤
	 */
//	@RequiresPermissions(value={"cms:userSkin:add","cms:userSkin:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "save",method=RequestMethod.POST)
	public AjaxJson save( UserSkin userSkin ) throws Exception{
		if(!userSkin.getIsNewRecord()){//编辑
			UserSkin t = userSkinService.get(userSkin);
			MyBeanUtils.copyBeanNotNull2Bean(userSkin, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			userSkinService.save(t);//保存
		}else{//新增
			if(StringUtils.isNotEmpty(userSkin.getUserId())){
				userSkinService.save(userSkin);//保存
			}
		}
		return new AjaxJson();
	}
	
	@ResponseBody
	@RequestMapping(value = "",method=RequestMethod.GET)
	public AjaxJson getSkin(String userId){
		UserSkin roleSkin = userSkinService.get(userId);
		AjaxJson json = new AjaxJson();
		json.put("skin", roleSkin);
		json.setCode("10000");
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "upload")
	public AjaxJson uploadSkin(UserSkin skin, HttpServletRequest request, MultipartFile file) throws Exception{
		if(!skin.getIsNewRecord()){//编辑表单保存
			UserSkin t = userSkinService.get(skin.getUserId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(skin, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			this.userSkinService.skinUpload(request, file, t);//保存
		}else{//新增表单保存
			this.userSkinService.skinUpload(request, file, skin);//保存
		}
		return new AjaxJson();
	}
}