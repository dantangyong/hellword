package com.mht.define.portal.cms.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mht.common.json.AjaxJson;
import com.mht.common.utils.MyBeanUtils;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.entity.TagManage;
import com.mht.define.portal.cms.service.TagManageService;
import com.mht.define.portal.cms.utils.ConstantDictionary;

/**
 * 
 * @ClassName: TagManageController
 * @Description: 标签管理
 * @author wangjie
 * @date 2017年7月27日 下午5:56:53 
 * @version 1.0.0
 */
@Controller
@RequestMapping(value="${adminPath}/portal/tagManage")
public class TagManageController extends BaseController{

	@Autowired
	private TagManageService tagManageService;
	
	@ModelAttribute
	public TagManage get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return tagManageService.get(id);
		}else{
			return new TagManage();
		}
	}
	
	@RequestMapping("")
	public String index(){
		return "/define/portal/cms/tagManage";
	}
	
	@ResponseBody
	@RequestMapping("show")
	public AjaxJson indexData(TagManage tag){
		List<TagManage> list = tagManageService.findList(tag);
		AjaxJson json = new AjaxJson();
		json.setCode(ConstantDictionary.SUCCESS_CODE);
		json.put("tag", list.get(PageBean.DEFAULT_ZERO));
		return json;
	}
	
	@ResponseBody
	@RequestMapping("save")
	public AjaxJson save(TagManage tag, HttpServletRequest request, MultipartFile file) throws Exception{
		logger.info("===================="+tag.getEdition());
		if(!tag.getIsNewRecord()){//编辑表单保存
			TagManage t = tagManageService.get(tag.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(tag, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			tagManageService.save(request, file, t);//保存
		}else{//新增表单保存
			tagManageService.save(request, file, tag);//保存
		}
		AjaxJson json = new AjaxJson();
		json.setMsg("保存成功");
		json.setCode(ConstantDictionary.SUCCESS_CODE);
		return json;
		
	}
}
