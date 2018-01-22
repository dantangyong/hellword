package com.mht.define.portal.cms.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.mht.common.datasource.DynamicDataSource;
import com.mht.common.json.AjaxJson;
import com.mht.define.portal.cms.entity.ArticleData;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.service.ArticleService;
import com.mht.define.portal.cms.utils.ConstantDictionary;

/**
 * 
 * @ClassName: NewChannelController
 * @Description: 重写新闻频道
 * @author com.mhout.wzw
 * @date 2017年9月14日 上午9:21:28 
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/solr")
public class NewChannelController {
	
	@Autowired
	private ArticleService articleService;
	
	private ArticleData caData = new ArticleData();
	/**
	 * 
	 * @Title: initChannel 
	 * @Description: 初始化频道标题
	 * @param mav
	 * @param name
	 * @param pageCode
	 * @return
	 * @author com.mhout.wzw
	 */
	@ResponseBody
	@RequestMapping(value = "initChannel")
	public AjaxJson initChannel(AjaxJson json, String name,String pageCode) {
		List<Category> allchannel= new ArrayList<>();
		allchannel = articleService.selectAllChannel();
		StringBuffer buff = new StringBuffer();
		for (Category list : allchannel) {
			buff.append(list);
		}
		json.setMsg(buff.toString());
		return json;
	}
	/** 
	 * @Title: searcher 
	 * @Description: 新闻中心查询内容方法
	 * @param mav
	 * @param name
	 * @param pageCode
	 * @return
	 * @author com.mhout.wzw
	 */
	@RequestMapping(value = "otherChannel")
	public String searcher(Model model,String name,String pageCode) {
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		 String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	     DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
		
	     List<ArticleData> list= new ArrayList<>();
		List<ArticleData> hotlist= new ArrayList<>();
		List<Category> channelList= new ArrayList<>();
		List<Category> allchannel= new ArrayList<>();
		allchannel = articleService.selectAllChannel();
		model.addAttribute("allchannel", allchannel);
		channelList = articleService.selectChannel(name);
//		if(channelList.size()>PageBean.DEFAULT_ZERO){
//			if("".equals(channelList.get(PageBean.DEFAULT_ZERO).getHref())||channelList.get(PageBean.DEFAULT_ZERO).getHref()==null){
//				channelList.get(PageBean.DEFAULT_ZERO).setHref("/define/portal/cms/channelMsessage");
//			}
//				mav.setViewName(channelList.get(PageBean.DEFAULT_ZERO).getHref());
		model.addAttribute("channel", channelList.get(PageBean.DEFAULT_ZERO));
//		}else{
//			mav.setViewName("/define/portal/cms/teach");
//		}
		if("".equals(pageCode)||pageCode==null||pageCode.equals(String.valueOf(PageBean.DEFAULT_ZERO))){
			pageCode=String.valueOf(PageBean.DEFAULT_PAGECODE);
		}
		PageBean pb=new PageBean();
		pb.setPageCode(Integer.parseInt(pageCode));
		pb.setPageSize(PageBean.DEFAULT_PAGESIZE);
		list = articleService.selectnews(name,pb);
		model.addAttribute("channellist", list);
		Category category = new Category();
		category.setName(name);
		caData.setCategory(category);
		hotlist = articleService.selecthotnews(caData);
		model.addAttribute("hotlist", hotlist);
		pb.setBeginAndEnd(Integer.parseInt(pageCode), PageBean.DEFAULT_SHOWPAGE);
		if(pb.getTotalRecods()==PageBean.DEFAULT_ZERO){
			pb.setTotalRecods(ConstantDictionary.DEFAULT_PAGE);
		}
		model.addAttribute("pageBean", pb);
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return "/define/portal/cms/channelMessage";

	}
	@RequestMapping(value = "newsChannel")
	public ModelAndView searchertwo(ModelAndView mav, String name,String pageCode) {
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		 String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	     DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
		
	     List<ArticleData> list= new ArrayList<>();
		List<ArticleData> hotlist= new ArrayList<>();
		List<Category> channelList= new ArrayList<>();
		List<Category> allchannel= new ArrayList<>();
		allchannel = articleService.selectAllChannel();
		mav.addObject("allchannel", allchannel);
		channelList = articleService.selectChannel(name);
		if(channelList.size()>PageBean.DEFAULT_ZERO){
			if("".equals(channelList.get(PageBean.DEFAULT_ZERO).getHref())||channelList.get(PageBean.DEFAULT_ZERO).getHref()==null){
				channelList.get(PageBean.DEFAULT_ZERO).setHref("/define/portal/cms/channelMessage");
			}
				mav.setViewName(channelList.get(PageBean.DEFAULT_ZERO).getHref());
				mav.addObject("channel", channelList.get(PageBean.DEFAULT_ZERO));
		}else{
			mav.setViewName("/define/portal/cms/teach");
		}
		if(pageCode.equals("")||pageCode==null||pageCode.equals(PageBean.DEFAULT_ZERO+"")){
			pageCode=String.valueOf(PageBean.DEFAULT_PAGECODE);
		}
		PageBean pb=new PageBean();
		pb.setPageCode(Integer.parseInt(pageCode));
		pb.setPageSize(PageBean.DEFAULT_PAGESIZE);
		list = articleService.selectnews(name,pb);
		mav.addObject("channellist", list);
		Category category = new Category();
		category.setName(name);
		caData.setCategory(category);
		hotlist = articleService.selecthotnews(caData);
		mav.addObject("hotlist", hotlist);
		pb.setBeginAndEnd(Integer.parseInt(pageCode), PageBean.DEFAULT_SHOWPAGE);
		if(pb.getTotalRecods()==PageBean.DEFAULT_ZERO){
			pb.setTotalRecods(ConstantDictionary.DEFAULT_PAGE);
		}
		mav.addObject("pageBean", pb);
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return mav;

	}
	@RequestMapping(value = "newsDetailJsp")
	public String artical(Model mav, String name) {
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		 String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	     DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
		caData = articleService.selectclicknews(name);
		List<ArticleData> list3= new ArrayList<>();
		list3.add(caData);
//		更新点击数
		articleService.updateHitsAddOne(caData.getId());
		mav.addAttribute("channel", caData.getCategory().getName());
		mav.addAttribute("list03", list3);
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return "/define/portal/cms/newsDetail";
	}
	@RequestMapping(value = "solrDetailJsp")
	public String solrDetailJsp(Model mav, String name) {
		/*
		 * 进入方法切换数据库数据源为portal数据库
		 */
		 String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	     DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
	     List<Category> hotChannelList = new ArrayList<>();
	     List<ArticleData> hotNewsList = new ArrayList<>();
	     hotChannelList = articleService.selectHotChannel(PageBean.DEFAULT_ZERO);
	     mav.addAttribute("firstHotChannel", hotChannelList);
	     mav.addAttribute("nowDate", new Date());
	     Category category = new Category();
		category.setName(name);
		caData.setCategory(category);
		hotNewsList = articleService.selecthotnews(caData);
		mav.addAttribute("hotNews", hotNewsList);
		caData = articleService.selectclicknews(name);
//		更新点击数
		articleService.updateHitsAddOne(caData.getId());
		List<ArticleData> list3= new ArrayList<>();
		list3.add(caData);
		mav.addAttribute("channel", caData.getCategory().getName());
		mav.addAttribute("list03", list3);
		/*
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return "/define/portal/cms/solrNewsDetail";
	}
}
