/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.mht.define.portal.cms.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.mht.common.config.Global;
import com.mht.common.json.AjaxJson;
import com.mht.common.persistence.Page;
import com.mht.common.utils.CookieUtils;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.dao.CategoryDao;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.CmsVideo;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.define.portal.cms.entity.Site;
import com.mht.define.portal.cms.entity.SysOffice;
import com.mht.define.portal.cms.service.CategoryService;
import com.mht.define.portal.cms.service.FileTplService;
import com.mht.define.portal.cms.service.SiteService;
import com.mht.define.portal.cms.utils.TplUtils;
import com.mht.modules.sys.utils.UserUtils;

/**
 * 栏目Controller
 * @author ThinkGem
 * @version 2013-4-21
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/category")
public class CategoryController extends BaseController {

	@Autowired
	private CategoryService categoryService;
    @Autowired
   	private FileTplService fileTplService;
    @Autowired
   	private SiteService siteService;
	
    @Autowired
	CategoryDao categoryDao;
	@ModelAttribute("category")
	public Category get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return categoryService.get(id);
		}else{
			return new Category();
		}
	}

	@RequiresPermissions("cms:category:list")
	@RequestMapping(value = {"list", ""})
	public String list( Category category,Model model,HttpServletRequest request, HttpServletResponse response) {
//	    String pageNo = request.getParameter("pageNo");
//		String pageSize = request.getParameter("pageSize");
//		List<Category> list = Lists.newArrayList();
//		List<Category> sourcelist = categoryService.findByUser(true, null);
//	    Category.sortList(list, sourcelist, "1");   //	参数1有问题 
//		Page<Category> newPage = new Page<Category>(request, response);
//		if(request.getParameter("repage")){
//			newPage.setPageSize(Integer.parseInt(CookieUtils.getCookie(request, "pageSize")));
//		}
		Page<Category> page = categoryService.findPage(new Page<Category>(request, response), category); 
        model.addAttribute("page", page);
		return "/define/portal/cms/categoryList";
	}

	@RequiresPermissions(value={"cms:category:view","cms:category:add","cms:category:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Category category, Model model) {
		if (category.getParent()==null||category.getParent().getId()==null){
			if(categoryService.get("1") ==null){
			    Category c = init();
				category.setParent(c);
			}else{
				category.setParent(new Category("1"));
			}
		}
		Category parent = categoryService.get(category.getParent().getId());
		category.setParent(parent);
		category.setModule("article");
//		if (category.getOffice()==null||category.getOffice().getId()==null){
//			category.setOffice(parent.getOffice());
//		}
//        model.addAttribute("listViewList",getTplContent(Category.DEFAULT_TEMPLATE));
//        model.addAttribute("category_DEFAULT_TEMPLATE",Category.DEFAULT_TEMPLATE);
//        model.addAttribute("contentViewList",getTplContent(Article.DEFAULT_TEMPLATE));
//        model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
//		model.addAttribute("office", category.getOffice());
		model.addAttribute("category", category);
		return "/define/portal/cms/categoryForm";
	}
	
	@RequiresPermissions(value={"cms:category:add","cms:category:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Category category, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/cms/category/";
		}
		if (category.getParent()==null||category.getParent().getId()==null){
			category.setParent(new Category("1"));
		}
		Category parent = categoryService.get(category.getParent().getId());
		category.setParent(parent);
		category.setModule("article");
		if (category.getOffice()==null||category.getOffice().getId()==null){
			category.setOffice(parent.getOffice());
		}
		if (!beanValidator(model, category)){
			return form(category, model);
		}
		
		categoryService.save(category);
		addMessage(redirectAttributes, "保存栏目'" + category.getName() + "'成功");
		return "redirect:" + adminPath + "/cms/category/?repage";
	}
	
	@RequiresPermissions("cms:category:del")
	@RequestMapping(value = "delete")
	public String delete(Category category, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/cms/category/";
		}
		if (Category.isRoot(category.getId())){
			addMessage(redirectAttributes, "删除栏目失败, 不允许删除顶级栏目或编号为空");
		}else{
			categoryService.delete(category);
			addMessage(redirectAttributes, "删除栏目成功");
		}
		return "redirect:" + adminPath + "/cms/category/";
	}
	
	@RequiresPermissions("cms:category:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] = ids.split(",");
		for (String id : idArray) {
			categoryService.deleteByLogic(categoryService.get(id));
		}
		addMessage(redirectAttributes, "删除栏目成功");
		return "redirect:" + adminPath + "/cms/category/";
	}

	/**
	 * 批量修改栏目排序
	 */
	@RequiresPermissions("cms:category:edit")
	@RequestMapping(value = "updateSort")
	public String updateSort(String[] ids, Integer[] sorts, RedirectAttributes redirectAttributes) {
    	int len = ids.length;
    	Category[] entitys = new Category[len];
    	for (int i = 0; i < len; i++) {
    		entitys[i] = categoryService.get(ids[i]);
    		entitys[i].setSort(sorts[i]);
    		categoryService.save(entitys[i]);
    	}
    	addMessage(redirectAttributes, "保存栏目排序成功!");
		return "redirect:" + adminPath + "/cms/category/";
	}
	
//	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(String module, @RequestParam(required=false) String extId, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Category> list = categoryService.findByUser(true, module);
		for (int i=0; i<list.size(); i++){
			Category e = list.get(i);
			if (extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParent()!=null?e.getParent().getId():0);
				map.put("name", e.getName());
				map.put("module", e.getModule());
				mapList.add(map);
			}
		}
		return mapList;
	}

    private List<String> getTplContent(String prefix) {
   		List<String> tplList = fileTplService.getNameListByPrefix(siteService.get(Site.getCurrentSiteId()).getSolutionPath());
   		tplList = TplUtils.tplTrim(tplList, prefix, "");
   		return tplList;
   	}
    
    /**
	 * @Title: setStatus
	 * @Description: 设置栏目类别在前台显示或者掩藏
	 * @param id
	 * @param redirectAttributes
	 * @return
	 * @author com.mhout.dty
	 */
    @RequiresPermissions("cms:category:edit")
	@RequestMapping(value = "showOrHide")
	public String setStatus(String id, RedirectAttributes redirectAttributes) {
	    String statusInfo = categoryService.setStatus(id);
		addMessage(redirectAttributes, statusInfo);
		return "redirect:" + adminPath + "/cms/category/?repage";
	}
    
    /**
	 * 验证name是否存在
	 */
	@RequiresPermissions(value={"cms:category:add","cms:category:edit","cms:category:view"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "checkName")
	public String getByName(Category category,String oldName) {
		 Category c = categoryService.getByName(category.getName());
		if (null != c){
			if(c.getName().equals(oldName)){
				return "true";
			}else{
				return "false";
			}
			 
		}
		 return "true";
	}
	
	/**
	 * 类别排序
	 */
	@RequiresPermissions("cms:category:edit")
	@ResponseBody
	@RequestMapping(value = "sort")
	public AjaxJson sort(String sourceId, String destinationId, RedirectAttributes redirectAttributes) {
		categoryService.sort(sourceId, destinationId);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("排序成功");
		return json;
	}
	
	/**
	 * 初始化根节点类别
	 */
	public Category init(){
		Category c = new Category();
		Category c1 = new Category();
		c1.setId("0");
		c.setId("1");
		c.setParent(c1);
		c.setParentIds("0,");
		c.setName("顶级栏目");
		c.setOffice(UserUtils.getUser().getOffice());
		categoryDao.insert(c);
		return c;
	}
}
