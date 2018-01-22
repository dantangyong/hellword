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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mht.common.config.Global;
import com.mht.common.json.AjaxJson;
import com.mht.common.persistence.Page;
import com.mht.common.utils.CookieUtils;
import com.mht.common.utils.MyBeanUtils;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.CmsBanner;
import com.mht.define.portal.cms.service.CmsBannerService;

/**
 * bannerController
 * @author 王杰
 * @version 2017-07-05
 */
@Controller
@RequestMapping("${adminPath}/portal/cmsBanner")
public class CmsBannerController extends BaseController{
	
	@Autowired
	private CmsBannerService bannerService;
	
	@ModelAttribute
	public CmsBanner get(@RequestParam(required=false) String id) {
		CmsBanner entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bannerService.get(id);
		}
		if (entity == null){
			entity = new CmsBanner();
		}
		return entity;
	}
	
	/**
	 * banner列表页面
	 */
	@RequiresPermissions("cms:banner:list")
	@RequestMapping(value = {"list", ""})
	public String list(CmsBanner CmsBanner,String pageSize, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmsBanner> newPage = new Page<CmsBanner>(request, response);
		if(request.getParameter("repage")!=null && StringUtils.isNotBlank(pageSize)){
			newPage.setPageSize(Integer.parseInt(pageSize));
		}
		Page<CmsBanner> page = bannerService.findPage(newPage, CmsBanner); 
		model.addAttribute("page", page);
		return "/define/portal/cms/cmsBanner";
	}

	/**
	 * 保存banner
	 */
	@RequiresPermissions(value={"cms:banner:add","cms:banner:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(CmsBanner CmsBanner, Model model, RedirectAttributes redirectAttributes,
				HttpServletRequest request,HttpServletResponse response, MultipartFile file) throws Exception{
		if(!CmsBanner.getIsNewRecord()){//编辑表单保存
			CmsBanner t = bannerService.get(CmsBanner.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(CmsBanner, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			this.bannerService.bannerSave(request, file, t);//保存
		}else{//新增表单保存
			this.bannerService.bannerSave(request, file, CmsBanner);//保存
		}
		ObjectMapper mapper = new ObjectMapper();   
		String content = mapper.writeValueAsString("保存成功");    
		return content;  
	}
	
	/**
	 * 禁用banner
	 */
	@RequiresPermissions("cms:banner:edit")
	@RequestMapping(value = "disable")
	public String disable(CmsBanner cmsBanner, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		int count = bannerService.getEnableCount();
		String pageSize = CookieUtils.getCookie(request, "pageSize");
		if(Global.ENABLE.equals(cmsBanner.getDisable())){
			if(count<=1){
				addMessage(redirectAttributes, "禁用失败,请至少启用一个banner!");
				return "redirect:"+Global.getAdminPath()+"/portal/cmsBanner/?repage&pageSize="+pageSize;
			} 
		}  
		if(Global.DISABLE.equals(cmsBanner.getDisable())){
			if(count>=5){
				addMessage(redirectAttributes, "启用失败,最多启用5个banner!");
				return "redirect:"+Global.getAdminPath()+"/portal/cmsBanner/?repage&pageSize="+pageSize;
			}
		}
		bannerService.disable(cmsBanner);
		addMessage(redirectAttributes, Global.ENABLE.equals(cmsBanner.getDisable())?"启用成功":"禁用成功");
		return "redirect:"+Global.getAdminPath()+"/portal/cmsBanner/?repage&pageSize="+pageSize;
	}
	
	/**
	 * banner排序
	 */
	@ResponseBody
	@RequestMapping(value = "sort")
	public AjaxJson sort(String sourceId, String destinationId, RedirectAttributes redirectAttributes) {
		bannerService.sort(sourceId, destinationId);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("排序成功");
		return json;
	}
	
	/**
	 * 编辑banner
	 */
	@RequiresPermissions("cms:banner:edit")
	@ResponseBody
	@RequestMapping(value = "edit")
	public AjaxJson edit(CmsBanner CmsBanner) {
		CmsBanner banner = bannerService.get(CmsBanner);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.put("banner", banner);
		return json;
	}
	
	/**
	 * 删除banner
	 */
	@RequiresPermissions("cms:banner:del")
	@RequestMapping(value = "delete")
	public String delete(CmsBanner CmsBanner, RedirectAttributes redirectAttributes) {
		bannerService.delete(CmsBanner);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/portal/cmsBanner/?repage";
	}
	
	/**
	 * 批量删除banner
	 */
	@RequiresPermissions("cms:banner:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			bannerService.delete(bannerService.get(id));
		}
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/portal/cmsBanner/?repage";
	}
	
}
