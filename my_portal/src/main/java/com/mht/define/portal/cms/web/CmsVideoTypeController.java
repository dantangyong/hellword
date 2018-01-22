package com.mht.define.portal.cms.web;

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
import com.mht.common.datasource.DynamicDataSource;
import com.mht.common.json.AjaxJson;
import com.mht.common.persistence.Page;
import com.mht.common.utils.CookieUtils;
import com.mht.common.utils.MyBeanUtils;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.CmsBanner;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.service.CmsVideoService;
import com.mht.define.portal.cms.service.CmsVideoTypeService;
import com.mht.define.portal.cms.utils.ConstantDictionary;

/**
 * 视频类型
 * @ClassName: CmsVideoTypeController
 * @Description: 
 * @author wangjie
 * @date 2017年7月27日 下午1:43:04 
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/videoType")
public class CmsVideoTypeController extends BaseController{
	
	@Autowired
	private CmsVideoTypeService videoTypeService;
	@Autowired
	private CmsVideoService videoService;
	@ModelAttribute
	public CmsVideoType get(@RequestParam(required=false) String id) {
		CmsVideoType entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = videoTypeService.get(id);
		}
		if (entity == null){
			entity = new CmsVideoType();
		}
		return entity;
	}
	
	/**
	 * 视频类型列表页面
	 */
	@RequiresPermissions("cms:videoType:list")
	@RequestMapping(value = {"list", ""})
	public String list(CmsVideoType videoType,String pageSize, HttpServletRequest request, HttpServletResponse response, Model model) {
		/**
		 * 切换数据库
		 */
		String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	    DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
//		if("".equals(videoType.getDisable())||videoType.getDisable()==null){
//			videoType.setDisable("1");
//		}
//	    Page<CmsVideoType> newPage = new Page<CmsVideoType>(request, response);
//		if(request.getParameter("repage")!=null && !StringUtils.isNotBlank(pageSize)){
//			logger.info("居然执行了");
//			newPage.setPageSize(Integer.parseInt(pageSize));
//		}
		Page<CmsVideoType> page = videoTypeService.findPage(new Page<CmsVideoType>(request, response), videoType); 
		model.addAttribute("page", page);
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return "/define/portal/cms/cmsVideoTypeList";
	}

	/**
	 * 查看，增加，编辑视频类型表单页面
	 */
	@RequiresPermissions(value={"cms:videoType:view","cms:videoType:add","cms:videoType:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "form")
	public AjaxJson form(CmsVideoType videoType, Model model) {
		CmsVideoType type = get(videoType.getId());
		AjaxJson json = new AjaxJson();
		json.setCode(ConstantDictionary.SUCCESS_CODE);
		json.put("videoType", type);
		return json;
	}

	/**
	 * 保存视频
	 */
	@RequiresPermissions(value={"cms:videoType:add","cms:videoType:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "save")
	public AjaxJson save(CmsVideoType videoType, Model model, RedirectAttributes redirectAttributes) throws Exception{
		AjaxJson json = new AjaxJson();
		if(!videoType.getIsNewRecord()){//编辑表单保存
			CmsVideoType t = videoTypeService.get(videoType.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(videoType, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			videoTypeService.save(t);//保存
		}else{//新增表单保存
//			获取当前最大的排序值
//			Integer sort = videoTypeService.getMaxSort();
//			videoType.setSort(++sort);
			videoType.setDisable(String.valueOf(PageBean.DEFAULT_PAGECODE)); // 默认为启用
			videoTypeService.save(videoType);//保存
		}
		json.setMsg("保存成功");
		return json;
	}
	
	/**
	 * 删除视频
	 */
	@RequiresPermissions("cms:videoType:del")
	@RequestMapping(value = "delete")
	public String delete(CmsVideoType videoType, RedirectAttributes redirectAttributes) {
		videoTypeService.delete(videoType);
		addMessage(redirectAttributes, "删除视频类别成功");
		return "redirect:"+Global.getAdminPath()+"/cms/videoType/?repage";
	}
	
	/**
	 * 批量删除视频
	 */
	@RequiresPermissions("cms:videoType:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			videoTypeService.delete(videoTypeService.get(id));
		}
		addMessage(redirectAttributes, "删除视频成功");
		return "redirect:"+Global.getAdminPath()+"/cms/videoType/?repage";
	}

	/**
	 * 禁用/启用视频类别
	 */
	@RequiresPermissions("cms:videoType:edit")
	@RequestMapping(value = "disable")
	public String disable(String id, RedirectAttributes redirectAttributes,HttpServletRequest request) {
//		String pageSize = CookieUtils.getCookie(request, "pageSize");
		CmsVideoType videoType = videoTypeService.disable(id);
		videoService.disableVideo(videoType);
		if(Global.ENABLE.equals(videoType.getDisable())){
			addMessage(redirectAttributes, "视频类别启用成功");
		} else if (Global.DISABLE.equals(videoType.getDisable())) {
			addMessage(redirectAttributes, "视频类别禁用成功");
		}
		return "redirect:"+Global.getAdminPath()+"/cms/videoType/?repage";
	}
	
	/**
	 * 验证name是否存在
	 */
	@RequiresPermissions(value={"cms:videoType:view","cms:videoType:add","cms:videoType:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "checkName")
	public String getByName(CmsVideoType videoType,String oldName) {
		CmsVideoType type = videoTypeService.getByName(videoType.getTypeName());
		if (null != type){
			if(StringUtils.isNotBlank(oldName)){
				if(type.getTypeName().equals(oldName)){
					return "false";
				}
			}else{
				return "true";
			}
		}else{
			return "false";
		}
		 return "true";
	}
	
	/**
	 * 类别排序
	 */
	@RequiresPermissions("cms:videoType:edit")
	@ResponseBody
	@RequestMapping(value = "sort")
	public AjaxJson sort(String sourceId, String destinationId, RedirectAttributes redirectAttributes) {
		videoTypeService.sort(sourceId, destinationId);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("排序成功");
		return json;
	}
}
