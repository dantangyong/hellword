/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.mht.define.portal.cms.web;

import java.util.ArrayList;
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
import com.mht.common.mapper.JsonMapper;
import com.mht.common.persistence.Page;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.ArticleData;
import com.mht.define.portal.cms.entity.ArticleDto;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.CmsVideo;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.define.portal.cms.entity.Site;
import com.mht.define.portal.cms.service.ArticleDataService;
import com.mht.define.portal.cms.service.ArticleService;
import com.mht.define.portal.cms.service.CategoryService;
import com.mht.define.portal.cms.service.FileTplService;
import com.mht.define.portal.cms.service.SiteService;
import com.mht.define.portal.cms.utils.CmsUtils;
import com.mht.define.portal.cms.utils.TplUtils;
import com.mht.modules.sys.utils.UserUtils;


/**
 * 文章Controller
 * @author ThinkGem
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/article")
public class ArticleController extends BaseController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleDataService articleDataService;
	@Autowired
	private CategoryService categoryService;
    @Autowired
   	private FileTplService fileTplService;
    @Autowired
   	private SiteService siteService;
	
	@ModelAttribute
	public Article get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return articleService.get(id);
		}else{
			return new Article();
		}
	}
	
	@RequiresPermissions("cms:article:list")
	@RequestMapping(value = {"list", ""})
	public String list(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Article> page = articleService.findPage(new Page<Article>(request, response), article, true); 
        Category category = new Category();
        category.setInMenu(Global.ENABLE);
		List<Category> categories = categoryService.findListForPage(category);
		model.addAttribute("categories", categories);
        model.addAttribute("page", page);
//        model.addAttribute("disable", article.getDisable());
		return "/define/portal/cms/articleList";
	}

	@RequiresPermissions(value={"cms:article:view","cms:article:add","cms:article:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Article article, Model model) {
		// 如果当前传参有子节点，则选择取消传参选择
//		if (article.getCategory()!=null && StringUtils.isNotBlank(article.getCategory().getId())){
//			List<Category> list = categoryService.findByParentId(article.getCategory().getId(), Site.getCurrentSiteId());
//			if (list.size() > 0){
//				article.setCategory(null);
//			}else{
//				 article.setCategory(categoryService.get(article.getCategory().getId()));
////				 CmsUtils.addViewConfigAttribute(model, article.getCategory());
////				  model.addAttribute("contentViewList",getTplContent());
////			        model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
//					model.addAttribute("article", article);
//			}
//			
//		}
		//article.setArticleData(articleDataService.get(article.getId()));
//		if (article.getCategory()=null && StringUtils.isNotBlank(article.getCategory().getId())){
//			Category category = categoryService.get(article.getCategory().getId());
//		}
		 if(article.getArticleData() ==null){
			 ArticleData ad = new ArticleData();
			 articleService.copyFrom(ad);
			 article.setArticleData(ad);
		 }
		    Category category = new Category();
	        category.setInMenu(Global.ENABLE);
			List<Category> categories = categoryService.findListForPage(category);
			model.addAttribute("categories", categories);
			
		return "/define/portal/cms/articleForm";
	}

	@RequiresPermissions(value={"cms:article:add","cms:article:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Article article, Model model, RedirectAttributes redirectAttributes) {
	  String newImage =  StringUtils.replace(article.getImage(), "/_thumbs", "");
	  article.setImage(newImage);
		if (!beanValidator(model, article)){
			return form(article, model);
		}
		articleService.save(article);
		addMessage(redirectAttributes, "保存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
		String categoryId = article.getCategory()!=null?article.getCategory().getId():null;
		String disable = article.getDisable();
//		return "redirect:" + adminPath + "/cms/article/?repage&category.id="+(categoryId!=null?categoryId:"");
		//return "redirect:" + adminPath + "/cms/article/?disable="+disable;
		return "redirect:" + adminPath + "/cms/article/?repage";
	}
	
	@RequiresPermissions("cms:article:del")
	@RequestMapping(value = "delete")
	public String delete(Article article, String categoryId, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
		// 如果没有审核权限，则不允许删除或发布。
		if (!UserUtils.getSubject().isPermitted("cms:article:audit")){
			addMessage(redirectAttributes, "你没有删除或发布权限");
		}
		articleService.delete(article, isRe);
		addMessage(redirectAttributes, (isRe!=null&&isRe?"发布":"删除")+"文章成功");
//		return "redirect:" + adminPath + "/cms/article/?repage&category.id="+(categoryId!=null?categoryId:"");
		return "redirect:" + adminPath + "/cms/article/";
	}
	
	/**
	 * 批量删除视频
	 */
	@RequiresPermissions("cms:article:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			articleService.delete(articleService.get(id));
		}
		addMessage(redirectAttributes, "删除文章成功");
		//return "redirect:"+Global.getAdminPath()+"/cms/video/?repage";
		return "redirect:"+Global.getAdminPath()+"/cms/article/";
	}

	/**
	 * 文章选择列表
	 */
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = "selectList")
	public String selectList(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
        list(article, request, response, model);
		return "/define/portal/cms/articleSelectList";
	}
	
	/**
	 * 文章选择列表ajax请求
	 */
//	@RequiresPermissions("cms:article:view")
	@ResponseBody
	@RequestMapping(value = "categoryList")
	public AjaxJson categoryList(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Article> findList = articleService.findList(article);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("文章拉取成功");
		json.put("articles", findList);
		return json;
	}
	
	/**
	 * 通过编号获取文章标题
	 */
	@RequiresPermissions("cms:article:view")
	@ResponseBody
	@RequestMapping(value = "findByIds")
	public String findByIds(String ids) {
		List<Object[]> list = articleService.findByIds(ids);
		return JsonMapper.nonDefaultMapper().toJson(list);
	}
	
	/**
	 * 获取权重前三的新闻用于首页显示
	 */
	@ResponseBody
	@RequestMapping(value = "findMainNews")
	public AjaxJson findMainNews(Article article) {
		List<Article> main = articleService.findMainNews(article);
		AjaxJson json = new AjaxJson();
		json.setMsg("拉取成功");
		json.setCode("10000");
		json.put("news", main);
		return json;
	}

    private List<String> getTplContent() {
   		List<String> tplList = fileTplService.getNameListByPrefix(siteService.get(Site.getCurrentSiteId()).getSolutionPath());
   		tplList = TplUtils.tplTrim(tplList, Article.DEFAULT_TEMPLATE, "");
   		return tplList;
   	}

    /**
	 * 查看文章详情
	 */
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = "detail")
	@ResponseBody
	public AjaxJson detail(Article article) {
		Article detail = get(article.getId());
		ArticleDto art = new ArticleDto(detail);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("拉取成功");
		json.put("article", art);
		return json;
	}
	
	/**
	 * 新闻轮播图
	 */
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = "newsPics")
	@ResponseBody
	public AjaxJson newsPics(Article article) {
		ArticleDto dto = null;
		AjaxJson json = new AjaxJson();
		List<ArticleDto> dtos = new ArrayList<>();
		List<Article> newsPics = this.articleService.findPics(article);
		for (Article art : newsPics) {
			dto = new ArticleDto(art);
			dtos.add(dto);
		}
		json.setCode("10000");
		json.setMsg("拉取成功");
		json.put("news", dtos);
		return json;
	}
	
	/**
	 * 禁用/启用新闻
	 */
	@RequiresPermissions("cms:article:edit")
	@RequestMapping(value = "disable")
	public String disable(String id, RedirectAttributes redirectAttributes) {
		 String info = articleService.disable(id);
		 addMessage(redirectAttributes, info);
	
	//	return "redirect:" + adminPath + "/cms/article/?repage";
		return "redirect:" + adminPath + "/cms/article/";
	}
	
	/**
	 * 推荐/取消推荐视频
	 */
	@RequiresPermissions("cms:article:edit")
	@RequestMapping(value = "recommend")
	public String recommend(String id, RedirectAttributes redirectAttributes) {
		String info = articleService.recommend(id);
		addMessage(redirectAttributes, info);
		return "redirect:" + adminPath + "/cms/article/";
	
	}
	
	/**
	 * 文章排序
	 */
	@RequiresPermissions("cms:video:edit")
	@ResponseBody
	@RequestMapping(value = "sort")
	public AjaxJson sort(String sourceId, String destinationId, RedirectAttributes redirectAttributes) {
		articleService.sort(sourceId, destinationId);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("排序成功");
		return json;
	}
	
}
