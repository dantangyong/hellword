/**
 * Copyright &copy; 2015-2020 <a href="http://www.mht.org/">mht</a> All rights reserved.
 */
package com.mht.define.portal.cms.web;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.mht.common.config.Global;
import com.mht.common.json.AjaxJson;
import com.mht.common.persistence.Page;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.NewNotice;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.service.NewNoticeService;
import com.mht.modules.sys.utils.UserUtils;

/**
 * 通知通告Controller
 * 
 * @author mht
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/notice")
public class NewNoticeController extends BaseController {

	@Autowired
	private NewNoticeService newNoticeService;
	
	private NewNotice oaNotify;
	
	
	/*
	 * 通知公告
	 */
	@RequestMapping(value = "notice")
	public ModelAndView searcher(ModelAndView mav,String pageCode) {
		if(StringUtils.isBlank(pageCode)){
			pageCode=PageBean.DEFAULT_PAGECODE+"";
		}
		PageBean<NewNotice> pb=new PageBean<>();
		pb.setPageCode(Integer.parseInt(pageCode));
		 pb.setPageSize(PageBean.DEFAULT_PAGESIZE);
		List<NewNotice>list = new ArrayList<>();
		list = newNoticeService.selectByNotify(pb);
		 pb.setBeginAndEnd(Integer.parseInt(pageCode),PageBean.DEFAULT_NOTISE_PAGESIZE);
		mav.addObject("pageBean", pb);
		mav.addObject("list", list);
		mav.setViewName("/define/portal/cms/notice");
		return mav;
	}
	@RequestMapping(value = "noticeDetail")
	public String frontGet(Model model,String name,HttpServletRequest request) throws UnsupportedEncodingException{
		oaNotify = new NewNotice();
		oaNotify = newNoticeService.get(name);
		String newFile = StringUtils.substring(oaNotify.getFiles(), 1, oaNotify.getFiles().length());
		String newFiles[] = newFile.split("\\|");
		List<NewNotice> noticeFiles = new ArrayList<>();
	  for(String f:newFiles){
		//对查询出来的路径进行解码
		  String result = java.net.URLDecoder.decode(f,"UTF-8");
			File tempFile =new File( result.trim());  
			String fileName = tempFile.getName();
			NewNotice n = new NewNotice();
			n.setFiles(f);
			n.setTitle(fileName);
			noticeFiles.add(n);
	  }
	    model.addAttribute("noticeFiles", noticeFiles);
		model.addAttribute("notice", oaNotify);
		return "/define/portal/cms/noticeDetail";
		
	}
	@RequestMapping(value = "noticeSearch")
	public ModelAndView noticeSearch(ModelAndView mav,String keyWords,String pageCode) {
		PageBean pb=new PageBean();
		if("".equals(pageCode)||pageCode==null){
			pageCode=PageBean.DEFAULT_PAGECODE+"";
		}
		pb.setPageCode(Integer.parseInt(pageCode));
		pb.setPageSize(PageBean.DEFAULT_PAGESIZE);
		if(!"".equals(keyWords)||keyWords!=null){
			pb.setName(keyWords);
		}
		List<NewNotice>list = new ArrayList<>();
		list = newNoticeService.selectByNotifyKeys(pb);
		pb.setBeginAndEnd(Integer.parseInt(pageCode), PageBean.DEFAULT_NOTISE_PAGESIZE);
		mav.addObject("keyWords", keyWords);
		mav.addObject("pageBean", pb);
		mav.addObject("list", list);
		mav.setViewName("/define/portal/cms/notice");
		return mav;
	}

	@ModelAttribute
	public NewNotice get(@RequestParam(required = false) String id) {

		NewNotice entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = newNoticeService.get(id);
		}
		if (entity == null) {
			entity = new NewNotice();
		}

		return entity;
	}

	@RequiresPermissions("notice:oaNotify:list")
	@RequestMapping(value = { "list", "" })
	public String list(NewNotice oaNotify, HttpServletRequest request, HttpServletResponse response, Model model) {

		Page<NewNotice> page = newNoticeService.find(new Page<NewNotice>(request, response), oaNotify);
		model.addAttribute("page", page);

		return "/define/portal/cms/newNotifyList";
	}

	/**
	 * 前端ajax拉取通知列表
	 * 
	 * @Title: list
	 * @Description: TODO
	 * @param oaNotify
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 * @author wangjie
	 */
	@ResponseBody
	@RequestMapping("noticeList")
	public AjaxJson noticeList(NewNotice oaNotify, HttpServletRequest request, HttpServletResponse response,
			Model model) {

		Page<NewNotice> page = newNoticeService.find(new Page<NewNotice>(request, response), oaNotify);
		model.addAttribute("page", page);
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("拉取成功");
		json.put("page", page);
		return json;
	}

	/**
	 * 查看，增加，编辑报告表单页面
	 */
	@RequiresPermissions(value = { "notice:oaNotify:view", "notice:oaNotify:add",
			"notice:oaNotify:edit" }, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(NewNotice oaNotify, Model model) {
//		if (StringUtils.isNotBlank(oaNotify.getId())) {
//			oaNotify = newNoticeService.getRecordList(oaNotify);
//		}
		model.addAttribute("oaNotify", oaNotify);

		return "/define/portal/cms/newNotifyForm";
	}

	@RequiresPermissions(value = { "notice:oaNotify:add", "notice:oaNotify:edit" }, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(NewNotice notice, Model model, RedirectAttributes redirectAttributes) {

	if (!beanValidator(model, notice)) {
			return form(notice, model);
		}
//		// 如果是修改，则状态为已发布，则不能再进行操作
//		if (StringUtils.isNotBlank(id1)) {
//			OaNotify e = oaNotifyService.get(oaNotify.getId());
//			if ("1".equals(e.getStatus())) {
//				addMessage(redirectAttributes, "已发布，不能操作！");
//				return "redirect:" + adminPath + "/cms/notice/?repage";
//			}
//		}
		notice.setOffice(UserUtils.getUser().getOffice());
		notice.setStatus("1");
		notice.setType("1");
		if (notice.getContent()!=null){
			notice.setContent(StringEscapeUtils.unescapeHtml4(
					notice.getContent()));
		}
		newNoticeService.save(notice);
		addMessage(redirectAttributes, "保存通知'" + notice.getTitle() + "'成功");
		return "redirect:" + adminPath + "/cms/notice/";
	}

	@RequiresPermissions("notice:oaNotify:del")
	@RequestMapping(value = "delete")
	public String delete(NewNotice oaNotify, RedirectAttributes redirectAttributes) {
		newNoticeService.deleteByLogic(oaNotify);
		addMessage(redirectAttributes, "删除通知成功");

		return "redirect:" + adminPath + "/cms/notice/";
	}

	@RequiresPermissions("notice:oaNotify:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] = ids.split(",");
		for (String id : idArray) {
			newNoticeService.deleteByLogic(newNoticeService.get(id));
		}
		addMessage(redirectAttributes, "删除通知成功");
		return "redirect:" + adminPath + "/cms/notice/";
	}

	/**
	 * 查看通知详情
	 */
	@RequestMapping(value = "oaNotifyDetail")
	public String oaNotifyDetail(NewNotice oaNotify, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		return "/define/portal/cms/newNotifyDetail";
	}

	/**
	 * 查看通知详情--数据
	 */
	// @RequiresPermissions("notice:oaNotify:view")
	@RequestMapping(value = "detail")
	@ResponseBody
	public AjaxJson detail(NewNotice oaNotify) {
		NewNotice detail = get(oaNotify.getId());
		AjaxJson json = new AjaxJson();
		json.setCode("10000");
		json.setMsg("拉取成功");
		json.put("oaNotify", detail);

		return json;
	}
	
	/**
	 * 禁用/启用通知
	 */
	@RequiresPermissions("notice:oaNotify:edit")
	@RequestMapping(value = "disable")
	public String disable(String id, RedirectAttributes redirectAttributes) {
		 String info  = newNoticeService.disable(id);
		 addMessage(redirectAttributes, info);
		
		return "redirect:" + adminPath + "/cms/notice/";
	}
}