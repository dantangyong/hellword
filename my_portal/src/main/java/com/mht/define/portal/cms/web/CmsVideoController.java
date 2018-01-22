/**
 * Copyright &copy; 2015-2020 <a href="http://www.mht.org/">mht</a> All rights reserved.
 */
package com.mht.define.portal.cms.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mht.common.config.Global;
import com.mht.common.json.AjaxJson;
import com.mht.common.persistence.Page;
import com.mht.common.utils.CacheUtils;
import com.mht.common.utils.MyBeanUtils;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.CmsVideo;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.define.portal.cms.service.CmsVideoService;
import com.mht.define.portal.cms.service.CmsVideoTypeService;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.utils.DictUtils;

/**
 * 视频Controller
 * @author 王杰
 * @version 2017-07-25
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/video")
public class CmsVideoController extends BaseController {

	@Autowired
	private CmsVideoService cmsVideoService;
	
	@Autowired
	private CmsVideoTypeService videoTypeService;
		
	@ModelAttribute
	public CmsVideo get(@RequestParam(required=false) String id) {
		CmsVideo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmsVideoService.get(id);
		}
		if (entity == null){
			entity = new CmsVideo();
		}
		return entity;
	}
	
	/**
	 * 视频列表页面
	 */
	@RequiresPermissions("cms:video:list")
	@RequestMapping(value = {"list", ""})
	public String list(CmsVideo cmsVideo, HttpServletRequest request, HttpServletResponse response, Model model) {
		if("".equals(cmsVideo.getVideoType())||cmsVideo.getVideoType()==null){
			cmsVideo.setVideoType(new CmsVideoType());
		}
		if("".equals(cmsVideo.getCreateBy())||cmsVideo.getCreateBy()==null){
			cmsVideo.setCreateBy(new User());
		}
		Page<CmsVideo> page = cmsVideoService.findPage(new Page<CmsVideo>(request, response), cmsVideo); 
		System.out.println(cmsVideo.getVideoType()+"+===========");
		CmsVideoType videoType = new CmsVideoType();
		videoType.setDisable(Global.ENABLE);
		List<CmsVideoType> types = videoTypeService.findList(videoType);
//		List<User> authors = videoTypeService.findAuthors(cmsVideo);
		model.addAttribute("videoTypes", types);
//		model.addAttribute("authors", authors);
		model.addAttribute("page", page);
		return "/define/portal/cms/cmsVideoList";
	}
	/**
	 * 
	 * @param cmsVideo
	 * @param 后台视频添加页面高级搜索方法
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cms:video:list")
	@RequestMapping(value = "highSearch")
	public String highSearch(CmsVideo cmsVideo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmsVideo> page = cmsVideoService.findPage(new Page<CmsVideo>(request, response), cmsVideo); 
		CmsVideoType videoType = new CmsVideoType();
		videoType.setDisable(Global.ENABLE);
		List<CmsVideoType> types = videoTypeService.findList(videoType);
//		List<User> authors = videoTypeService.findAuthors(cmsVideo);
		model.addAttribute("videoTypes", types);
//		model.addAttribute("authors", authors);
		model.addAttribute("page", page);
		return "/define/portal/cms/cmsVideoList";
	}

	/**
	 * 查看，增加，编辑视频表单页面
	 */
	@RequiresPermissions(value={"cms:video:view","cms:video:add","cms:video:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(CmsVideo cmsVideo, Model model) {
		CmsVideoType videoType = new CmsVideoType();
		videoType.setDisable(Global.ENABLE);
		List<CmsVideoType> typeList = videoTypeService.findList(videoType);
		if(Global.VIDEO_SOURCE_LINK.equals(cmsVideo.getVideoSource())){
			cmsVideo.setVideoUrlTemp(cmsVideo.getVideoUrl());
		} else if(Global.VIDEO_SOURCE_LOCAL.equals(cmsVideo.getVideoSource())){
			cmsVideo.setVideoUrlCache(cmsVideo.getVideoUrl());
		}
		model.addAttribute("videoTypes", typeList);
		model.addAttribute("cmsVideo", cmsVideo);
		return "/define/portal/cms/cmsVideoForm";
	}

	/**
	 * 保存视频
	 */
	@RequiresPermissions(value={"cms:video:add","cms:video:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(CmsVideo cmsVideo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		String[] videoImage = cmsVideo.getVideoImage().split(",");
		if(!"".equals(cmsVideo.getVideoUrlTemp())&&cmsVideo.getVideoUrlTemp()!=null){
			if("".equals(videoImage[0])||videoImage[0]==null){
				addMessage(redirectAttributes, "保存失败：视频图片不能为空");
				return "redirect:"+Global.getAdminPath()+"/cms/video/?repage";
			}else{
				cmsVideo.setVideoImage(videoImage[0]);
			}
		}else{
		if(("".equals(cmsVideo.getVideoUrlCache())&&"".equals(cmsVideo.getVideoUrlTemp()))
				||(cmsVideo.getVideoUrlCache()==null&&cmsVideo.getVideoUrlTemp()==null)){
			addMessage(redirectAttributes, "保存失败：视频流不能为空");
			return "redirect:"+Global.getAdminPath()+"/cms/video/?repage";
			
		}
		logger.info("================cmsVideo.getVideoImage()"+cmsVideo.getVideoImage());
		if(videoImage.length<=0){
				addMessage(redirectAttributes, "保存失败：视频图片不能为空");
				return "redirect:"+Global.getAdminPath()+"/cms/video/?repage";
		}else{
			cmsVideo.setVideoImage(videoImage[videoImage.length-1]);
		}
		}
		
		
		if (!beanValidator(model, cmsVideo)){
			return form(cmsVideo, model);
		}
		cmsVideo.setUpdateDate(new Date());
		if(!cmsVideo.getIsNewRecord()){//编辑表单保存
			if(Global.VIDEO_SOURCE_LINK.equals(cmsVideo.getVideoSource())){
				cmsVideo.setVideoUrl(cmsVideo.getVideoUrlTemp());
			} else if(Global.VIDEO_SOURCE_LOCAL.equals(cmsVideo.getVideoSource())){
				cmsVideo.setVideoUrl(cmsVideo.getVideoUrlCache());
			}
			CmsVideo t = cmsVideoService.get(cmsVideo.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(cmsVideo, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			cmsVideoService.save(t);//保存
		}else{//新增表单保存
			if(Global.VIDEO_SOURCE_LINK.equals(cmsVideo.getVideoSource())){
				cmsVideo.setVideoUrl(cmsVideo.getVideoUrlTemp());
			} else if(Global.VIDEO_SOURCE_LOCAL.equals(cmsVideo.getVideoSource())){
				cmsVideo.setVideoUrl(cmsVideo.getVideoUrlCache());
			}
			cmsVideo.setVideoImage(cmsVideo.getVideoImage().replace(",", ""));
			cmsVideo.setDisable("1");
			cmsVideoService.save(cmsVideo);//保存
		}
		addMessage(redirectAttributes, "保存视频成功");
		//return "redirect:"+Global.getAdminPath()+"/cms/video/?repage";
		return "redirect:"+Global.getAdminPath()+"/cms/video/";
	}
	
	/**
	 * 删除视频
	 */
	@RequiresPermissions("cms:video:del")
	@RequestMapping(value = "delete")
	public String delete(CmsVideo cmsVideo, RedirectAttributes redirectAttributes) {
		cmsVideoService.delete(cmsVideo);
		addMessage(redirectAttributes, "删除视频成功");
		//return "redirect:"+Global.getAdminPath()+"/cms/video/?repage";
		return "redirect:"+Global.getAdminPath()+"/cms/video/";
	}
	
	/**
	 * 批量删除视频
	 */
	@RequiresPermissions("cms:video:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			cmsVideoService.delete(cmsVideoService.get(id));
		}
		addMessage(redirectAttributes, "删除视频成功");
		//return "redirect:"+Global.getAdminPath()+"/cms/video/?repage";
		return "redirect:"+Global.getAdminPath()+"/cms/video/";
	}
	
	/**
	 * 禁用/启用视频
	 */
	@RequiresPermissions("cms:video:edit")
	@RequestMapping(value = "disable")
	public String disable(String id, RedirectAttributes redirectAttributes) {
		String info = cmsVideoService.disable(id);
		addMessage(redirectAttributes, info);
		return "redirect:"+Global.getAdminPath()+"/cms/video/";
	
	}
	
	/**
	 * 推荐/取消推荐视频
	 */
	@RequiresPermissions("cms:video:edit")
	@RequestMapping(value = "recommend")
	public String recommend(String id, RedirectAttributes redirectAttributes) {
		String info = cmsVideoService.recommend(id);
		addMessage(redirectAttributes, info);
		return "redirect:"+Global.getAdminPath()+"/cms/video/";
	
	}
	
	/**
	 * 类别排序
	 */
	@RequiresPermissions("cms:video:edit")
	@ResponseBody
	@RequestMapping(value = "sort")
	public AjaxJson sort(String sourceId, String destinationId, RedirectAttributes redirectAttributes) {
		cmsVideoService.sort(sourceId, destinationId);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("排序成功");
		return json;
	}
	
	
}