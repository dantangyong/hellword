package com.mht.define.portal.cms.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mht.common.json.AjaxJson;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.BiDto;
import com.mht.define.portal.cms.entity.CmsIndexShowAcademyrank;
import com.mht.define.portal.cms.entity.CmsIndexShowEducation;
import com.mht.define.portal.cms.entity.CmsIndexShowRate;
import com.mht.define.portal.cms.entity.CmsIndexShowResearch;
import com.mht.define.portal.cms.entity.CmsIndexShowTeacherStudent;
import com.mht.define.portal.cms.entity.CmsIndexShowTeachers;
import com.mht.define.portal.cms.service.CmsIndexShowAcademyrankService;
import com.mht.define.portal.cms.service.CmsIndexShowEducationService;
import com.mht.define.portal.cms.service.CmsIndexShowHotSearchService;
import com.mht.define.portal.cms.service.CmsIndexShowRateService;
import com.mht.define.portal.cms.service.CmsIndexShowResearchService;
import com.mht.define.portal.cms.service.CmsIndexShowTeacherStudentService;
import com.mht.define.portal.cms.service.CmsIndexShowTeachersService;
import com.mht.define.portal.cms.service.FrontAppService;

/**
 * 首页控制层
 * @ClassName: IndexController
 * @Description: 
 * @author wangjie
 * @date 2017年5月26日 下午3:46:46 
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/index")
public class IndexController extends BaseController{
	
	@Autowired
	private FrontAppService frontAppService;
	
	@Autowired
	private CmsIndexShowResearchService cmsIndexShowResearchService;
	@Autowired
	private CmsIndexShowTeachersService cmsIndexShowTeachersService;
	@Autowired
	private CmsIndexShowAcademyrankService cmsIndexShowAcademyrankService;
	@Autowired
	private CmsIndexShowEducationService cmsIndexShowEducationService;
	@Autowired
	private CmsIndexShowRateService cmsIndexShowRateService;
	@Autowired
	private CmsIndexShowTeacherStudentService cmsIndexShowTeacherStudentService;
	@Autowired
	private CmsIndexShowHotSearchService cmsIndexShowHotSearchService;
	
	@RequestMapping("")
	public String index(){
		return "/define/portal/front/index";
	}
	
	@RequestMapping("show")
	public String echartShow(){
		return "/define/portal/front/echartShow";
	}

	/**
	 * 展示科研获奖级别数据
	 * @param cmsIndexShowResearch
	 * @return json
	 */
	@RequestMapping("showResearchs")
	@ResponseBody
    public AjaxJson showResearchs(CmsIndexShowResearch cmsIndexShowResearch) {
	    AjaxJson json = new AjaxJson();
		
		//获取科研获奖级别researchLegendData数据
		List<CmsIndexShowResearch> researchLegendData = cmsIndexShowResearchService.getResearchLegendData();
		//获取科研获奖级别series中的data数据
		List<CmsIndexShowResearch> researchSeriesData = cmsIndexShowResearchService.getResearchSeriesData();

		json.put("legend", researchLegendData);
		json.put("series", researchSeriesData);
		
        return json;
    }
	/**
	 * 展示教职工职称数据
	 * @param CmsIndexShowTeachers
	 * @return json
	 */
	@RequestMapping("showTeachers")
	@ResponseBody
	public AjaxJson showTeachers() {
		AjaxJson json = new AjaxJson();
		
		//获取教职工职称Legend中的Data数据
		List<CmsIndexShowTeachers> teachersLegendData = cmsIndexShowTeachersService.getTeachersLegendData();
		//获取教职工职称series中的data数据
		List<CmsIndexShowTeachers> teachersSeriesData = cmsIndexShowTeachersService.getTeachersSeriesData();
		
		json.put("legend", teachersLegendData);
		json.put("series", teachersSeriesData);
		
		return json;
	}
	/**
	 * 展示学院排名数据
	 * @param CmsIndexShowAcademyrank
	 * @return json
	 */
	@RequestMapping("showAcademyrank")
	@ResponseBody
	public AjaxJson showAcademyrank() {
		AjaxJson json = new AjaxJson();
		
		//获取学院排名Legend中的Data数据
		List<CmsIndexShowAcademyrank> academyrankLegendData = cmsIndexShowAcademyrankService.getAcademyrankLegendData();
		//获取学院排名series中的data数据
		List<CmsIndexShowAcademyrank> academyrankSeriesData = cmsIndexShowAcademyrankService.getAcademyrankSeriesData();
		
		json.put("legend", academyrankLegendData);
		json.put("series", academyrankSeriesData);
		
		return json;
	}
	
	/**
	 * 展示教职工学历数据
	 * @param CmsIndexShowEducation
	 * @return json
	 */
	@RequestMapping("showEducation")
	@ResponseBody
	public AjaxJson showEducation() {
		AjaxJson json = new AjaxJson();
		
		//获取教职工学历Legend中的Data数据
		List<CmsIndexShowEducation> educationLegendData = cmsIndexShowEducationService.getEducationLegendData();
		//获取教职工学历xAxis中的data数据数据
		List<CmsIndexShowEducation> educationXAxisData = cmsIndexShowEducationService.getEducationXAxisData();
		//获取教职工学历series中的data数据
		Map<String, List<Integer>> educationSeriesData = cmsIndexShowEducationService.getEducationSeriesData();
		
		json.put("legend", educationLegendData);
		json.put("xAxis", educationXAxisData);
		json.put("series", educationSeriesData);
		
		return json;
	}

	/**
	 * 展示就业率数据
	 * @param CmsIndexShowEducation
	 * @return json
	 */
	@RequestMapping("showRate")
	@ResponseBody
	public AjaxJson showRate() {
		AjaxJson json = new AjaxJson();
		
		//获取就业率Legend中的Data数据
		List<CmsIndexShowRate> rateLegendData = cmsIndexShowRateService.getRateLegendData();
		//获取就业率xAxis中的data数据数据
		List<CmsIndexShowRate> rateXAxisData = cmsIndexShowRateService.getRateXAxisData();
		//获取就业率series中的data数据
		Map<String, List<Integer>> rateSeriesData = cmsIndexShowRateService.getRateSeriesData();
		
		json.put("legend", rateLegendData);
		json.put("xAxis", rateXAxisData);
		json.put("series", rateSeriesData);
		
		return json;
	}
	
	/**
	 * 展示师生比数据
	 * @param CmsIndexShowEducation
	 * @return json
	 */
	@RequestMapping("showTeacherStudent")
	@ResponseBody
	public AjaxJson showTeacherStudent() {
		AjaxJson json = new AjaxJson();
		
		//获取师生比Legend中的Data数据
		List<CmsIndexShowTeacherStudent> teacherStudentLegendData = cmsIndexShowTeacherStudentService.getTeacherStudentLegendData();
		//获取师生比xAxis中的data数据数据
		List<CmsIndexShowTeacherStudent> teacherStudentYAxisData = cmsIndexShowTeacherStudentService.getTeacherStudentYAxisData();
		//获取师生比series中的data数据
		Map<String, List<Integer>> teacherStudentSeriesData = cmsIndexShowTeacherStudentService.getTeacherStudentSeriesData();
		
		json.put("legend", teacherStudentLegendData);
		json.put("yAxis", teacherStudentYAxisData);
		json.put("series", teacherStudentSeriesData);
		
		return json;
	}
	
	
	/**
	 * 展示热门搜索数据
	 * @param CmsIndexShowHotSearch
	 * @return json
	 */
	@RequestMapping("showHotSearch")
	@ResponseBody
	public AjaxJson showHotSearcht() {
		AjaxJson json = new AjaxJson();
		
		//获取师生比series中的data数据
		//List<Map<String, Object>> hotSearchData = cmsIndexShowHotSearchService.getHotSearchSeriesData();
		Map<String, Object> hotSearchData = cmsIndexShowHotSearchService.getHotSearchSeriesData();
		json.put("data", hotSearchData);
		return json;
	}
	
	
	
	
	@RequestMapping("bi")
	public String bi(Model model){
		List<BiDto> biList = frontAppService.biList();
		model.addAttribute("bis", biList);
		return "/define/portal/front/bi";
	}
	
	@RequestMapping("login")
	public String login(Model model,String url){
		return "/define/portal/checkUser";
	}

}
