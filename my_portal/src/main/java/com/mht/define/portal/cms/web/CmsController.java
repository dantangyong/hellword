/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.mht.define.portal.cms.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mht.common.datasource.DynamicDataSource;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.ArticleData;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.CmsVideo;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.service.ArticleService;
import com.mht.define.portal.cms.service.CategoryService;
import com.mht.define.portal.cms.utils.ConstantConfig;

import jersey.repackaged.com.google.common.collect.Lists;

/**
 * 内容管理Controller
 * @author ThinkGem
 * @version 2013-4-21
 */
@Controller
@RequestMapping(value = "${adminPath}/cms")
public class CmsController extends BaseController {

	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ArticleService articleService;
	/**
	 * 热门频道
	 */
	List<Category> hotChannelList = new ArrayList<>();
	/**
	 * 头条新闻
	 */
	
//	@RequiresPermissions("cms:view")
	@RequestMapping(value = "")
	public String index() {
		System.out.println("进入了cms的首页方法里面");
		return "/define/portal/cms/cmsIndex";
	}
	/**
	 * 
	 * @Title: newsCenter 
	 * @Description: 进入cms主页面访问方式
	 * @return
	 * @author com.mhout.wzw
	 */
	@RequestMapping(value = "newsCenter")
	public String newsCenter(Model model ,ArticleData articleData){
		
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	    DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
		hotChannelList = articleService.selectHotChannel(PageBean.DEFAULT_ZERO);
		model.addAttribute("firstHotChannel", hotChannelList);
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return "/define/portal/cms/newsCenter";
	}
	/**
	 * 
	 * @Title: secondHotChannel 
	 * @Description: 热门频道翻页方法
	 * @param model
	 * @param name
	 * @return
	 * @author com.mhout.wzw
	 */
	@RequestMapping(value = "secondHotChannel")
	public String secondHotChannel(Model model ,ArticleData articleData){
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		 String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	     DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
		hotChannelList = articleService.selectHotChannel(5);
		model.addAttribute("secondHotChannel", hotChannelList);
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return "/define/portal/cms/hotchannel";
	}
	
	/**
	 * 
	 * @Title: hotChannelRequest 
	 * @Description: TODO
	 * @param model
	 * @param name
	 * @return
	 * @author com.mhout.wzw
	 */
	@RequestMapping(value = "hotChannelRequest")
	public String hotChannelRequest(ArticleData articleData,Model model){
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		 String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	     DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
	    
	    // hotChannelList = articleService.selectHotChannel(PageBean.DEFAULT_ZERO);
	        /**
			 * 热门新闻 点击量排序
			 */
	      List<ArticleData> hitsList = Lists.newArrayList();
	       articleData.setNumber(ConstantConfig.HITS);
	       List<ArticleData> list = articleService.selecthotnews(articleData);
	     
	        /**
			 * 热门新闻  推荐，时间排序
			 */
	       articleData.setNumber(Integer.parseInt(ConstantConfig.RECOMMEND));
	       List<ArticleData> recommendList = articleService.selecthotnews(articleData);
	       //解决重复的
			for(ArticleData ad:list){
				if (!recommendList.contains(ad)){
					hitsList.add(ad);
				}
			}
	       
			model.addAttribute("hitsList", hitsList);
			model.addAttribute("recommendList", recommendList);
		
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return "/define/portal/cms/hotchannel";
	}
	
	
	
	
//	@RequiresPermissions("cms:view")
	@RequestMapping(value = "tree")
	public String tree(Model model) {
		model.addAttribute("categoryList", categoryService.findByUser(true, null));
		return "/define/portal/cms/cmsTree";
	}
	
//	@RequiresPermissions("cms:view")
	@RequestMapping(value = "none")
	public String none() {
		return "/define/portal/cms/cmsNone";
	}

}
