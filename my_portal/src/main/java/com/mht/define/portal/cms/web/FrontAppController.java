package com.mht.define.portal.cms.web;

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
import com.mht.define.portal.cms.entity.CmsBanner;
import com.mht.define.portal.cms.entity.FrontApp;
import com.mht.define.portal.cms.service.FrontAppService;

/**
 * 首页排版
 * @ClassName: ComposingController
 * @Description: 
 * @author wangjie
 * @date 2017年5月22日 下午6:09:22 
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/portal/frontApp")
public class FrontAppController extends BaseController{
	
	@Autowired
	private FrontAppService appService;
	
	@ModelAttribute
	public FrontApp get(@RequestParam(required=false) String id) {
		FrontApp entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = appService.get(id);
		}
		if (entity == null){
			entity = new FrontApp();
		}
		return entity;
	}
	
	@RequiresPermissions("portal:frontAPP:list")
	@RequestMapping(value = {"list", ""})
	public String list(FrontApp frontApp,String pageSize, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FrontApp> newPage = new Page<FrontApp>(request, response);
//		if(request.getParameter("repage")!=null && StringUtils.isNotBlank(pageSize)){
//			newPage.setPageSize(Integer.parseInt(pageSize));
//		}
		Page<FrontApp> page = appService.findPage(newPage, frontApp);  
        model.addAttribute("page", page);
		return "/define/portal/cms/frontApp";
	}
	
	/**
	 * 查看，增加，编辑视频表单页面
	 */
	@RequiresPermissions(value={"portal:frontAPP:view","portal:frontAPP:add","portal:frontAPP:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "form")
	public AjaxJson form(FrontApp app, Model model) {
		FrontApp frontApp = get(app.getId());
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.put("app", frontApp);
		return json;
	}

	/**
	 * 保存应用
	 */
	@ResponseBody
	@RequiresPermissions(value={"portal:frontAPP:add","portal:frontAPP:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(FrontApp app, Model model, HttpServletRequest request, MultipartFile file) throws Exception{
		
		if(!app.getIsNewRecord()){//编辑表单保存
			FrontApp t = appService.get(app.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(app, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			appService.save(request, file, t);//保存
		}else{//新增表单保存
			app.setDisable("2");
			appService.save(request, file, app);//保存
		}
//		AjaxJson json = new AjaxJson();
//		json.setCode("10000");
//		json.setMsg("应用保存成功");
//		return json;
		ObjectMapper mapper = new ObjectMapper();   
		String content = mapper.writeValueAsString("保存成功");    
		return content;  
	}
	
	/**
	 * 删除应用
	 */
	@RequiresPermissions("portal:frontAPP:del")
	@RequestMapping(value = "delete")
	public String delete(FrontApp app, RedirectAttributes redirectAttributes) {
		appService.delete(app);
		addMessage(redirectAttributes, "删除应用成功");
		return "redirect:"+Global.getAdminPath()+"/portal/frontApp/?repage";
	}
	
	/**
	 * 批量删除应用
	 */
	@RequiresPermissions("portal:frontAPP:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			appService.delete(appService.get(id));
		}
		addMessage(redirectAttributes, "删除应用成功");
		return "redirect:"+Global.getAdminPath()+"/portal/frontApp/?repage";
	}
	
	/**
	 * 禁用/启用应用
	 */
	@RequiresPermissions("portal:frontAPP:edit")
	@RequestMapping(value = "disable")
	public String disable(String id, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		String pageSize = CookieUtils.getCookie(request, "pageSize");
		FrontApp app = appService.disable(id);
		if(Global.ENABLE.equals(app.getDisable())){
			addMessage(redirectAttributes, "应用启用成功");
		} else if (Global.DISABLE.equals(app.getDisable())) {
			addMessage(redirectAttributes, "应用禁用成功");
		}
//		return "redirect:"+Global.getAdminPath()+"/portal/frontApp/?repage&pageSize="+pageSize;
		return "redirect:"+Global.getAdminPath()+"/portal/frontApp/?repage";
	}
	
	/**
	 * 应用排序
	 */
	@ResponseBody
	@RequestMapping(value = "sort")
	public AjaxJson sort(String sourceId, String destinationId ) {
		appService.sort(sourceId, destinationId);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("排序成功");
		return json;
	}
	/**
	 * 首页右上角应用
	 * @Title: apps 
	 * @Description: TODO
	 * @param app
	 * @return AjaxJson
	 * @author wangjie
	 */
	@ResponseBody
	@RequestMapping(value = "showApps")
	public AjaxJson showApps(FrontApp app){
		List<FrontApp> frontApps = appService.findShowApps(app);
		AjaxJson json = new AjaxJson();
		json.put("apps", frontApps);
		return json;
	}
}
