package com.mht.define.portal.cms.web.solr;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.mht.common.config.Global;
import com.mht.common.datasource.DynamicDataSource;
import com.mht.common.json.AjaxJson;
import com.mht.common.utils.CacheUtils;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.entity.SensitiveWord;
import com.mht.define.portal.cms.entity.SolrDir;
import com.mht.define.portal.cms.entity.SolrHistory;
import com.mht.define.portal.cms.service.CategoryService;
import com.mht.define.portal.cms.service.NewNoticeService;
import com.mht.define.portal.cms.service.SensitiveWordService;
import com.mht.define.portal.cms.service.SolrHistoryLogService;
import com.mht.define.portal.cms.service.SolrSearchService;
import com.mht.define.portal.cms.utils.ConstantDictionary;
import com.mht.define.portal.cms.utils.HtmlEscape;
import com.mht.define.portal.cms.utils.SensitiveWordUtil;

@Controller
@RequestMapping(value = "${adminPath}/cms/solr")
public class SolrController extends BaseController {
	
	public static final Logger logger = LoggerFactory.getLogger(SolrController.class); 
	/**
	 * maxSizeNum为上一页和下一页按钮之间的最大页数
	 */
	private final int MAX_SIZE_NUM = ConstantDictionary.DEFAULT_SOLR_MAX_SIZE_NUM;
	
	/**
	 * coreMap用于存放索引库映射关系
	 */
	private Map<String,List<String>> coreMap = new HashMap<>();
	/**
	 * returnFields用于定义需要返回的字段和core的映射关系
	 */
	private Map<String,List<String>> returnFields = new HashMap<>();
	/**
	 * 用于存放返回的条目具体结果
	 */
	private List<Map<String, List<String>>> list = null;
	/**
	 * 用于存放分页组件
	 */
	private List<Map<String, Object>> divedPage = null;

	@Autowired
	private SolrSearchService solrSearch;

	@Autowired
	private SolrHistoryLogService log;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private NewNoticeService newNoticeService;
	
	@Autowired
	private SensitiveWordService sensitiveWordService;
	
	public Map<String, List<String>> getCoreMap() {
		return coreMap;
	}

	public void setCoreMap(Map<String, List<String>> coreMap) {
		this.coreMap = coreMap;
	}

	public Map<String, List<String>> getReturnFields() {
		return returnFields;
	}

	public void setReturnFields(Map<String, List<String>> returnFields) {
		this.returnFields = returnFields;
	}

	public List<Map<String, List<String>>> getList() {
		return list;
	}

	public void setList(List<Map<String, List<String>>> list) {
		this.list = list;
	}

	public List<Map<String, Object>> getDivedPage() {
		return divedPage;
	}

	public void setDivedPage(List<Map<String, Object>> divedPage) {
		this.divedPage = divedPage;
	}

	public SolrSearchService getSolrSearch() {
		return solrSearch;
	}

	public void setSolrSearch(SolrSearchService solrSearch) {
		this.solrSearch = solrSearch;
	}

	/**
	 * 
	 * @Title: search 
	 * @Description: solr页面
	 * @param model
	 * @param request
	 * @return String
	 * @author dty
	 */
	@RequestMapping(value = "search")
	public String search(Model model, HttpServletRequest request) {
		String search =  solrSearch.removeSpecialWord(request.getParameter("search"));
		String core = request.getParameter("service");
		model.addAttribute("search", search);
		model.addAttribute("service", core);
		return "/define/portal/cms/solrIndexNew";
	}
	
	/**
	 * 处理热门搜索ajax请求
	 * @param model
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "hotName")
	public AjaxJson hotName(Model model, HttpServletRequest request) {
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	    DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
		String service = request.getParameter("service");
		AjaxJson json = new AjaxJson();
		json.setCode(ConstantDictionary.SUCCESS_CODE);
		json.setMsg("拉取成功");
		if (service == null) {
			model.addAttribute("hotName", log.hotName());
			json.put("composes", log.hotName());
		} else {
			SolrHistory solr = new SolrHistory();
			solr.setService(service);
			model.addAttribute("hotName", log.hotServiceName(solr));
			json.put("composes", log.hotServiceName(solr));
		}
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		return json;
	}
	
	/**
	 * 除第一次请求外，处理其余所有搜索请求
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "change")
	public String change(Model model, HttpServletRequest request) {
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	    DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
	   //初始化索引库映射关系
 		solrSearch.setPage(PageBean.DEFAULT_PAGECODE);
		solrSearch.loadCoreMap(coreMap,returnFields);
		//获取当前页码
		String page = request.getParameter("mypage");
		if (page != null) {
			solrSearch.setPage(Integer.parseInt(page));
		}else{
			solrSearch.setPage(Integer.parseInt(Global.ENABLE));
		}
		//获取搜索关键字
		String search = solrSearch.removeSpecialWord(request.getParameter("solr"));
		//获取索引库编号
		String core = request.getParameter("type");
		if("4".equals(core)){
			solrSearch.setPageSize(16);
		}else {
			solrSearch.setPageSize(5);
		}
		getListAndSaveHistory(search, core);
		Long sum = solrSearch.getAllresult();
		//如果搜索的是服务就替换service_details
		if("2".equals(core)){
			DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_SERVICE);
			for (Map<String, List<String>> map : list) {
				logger.info(map.get("id").get(0)+"+++++++++");
				String service_details = categoryService.selectService(map.get("id").get(0));
				map.get("service_details").set(0,service_details);
			}
		}
		//如果搜索的是通知就替换notice_content
		if("3".equals(core)){
			for (Map<String, List<String>> map : list) {
				logger.info(map.get("id").get(0)+"+++++++++");
				String notice_content =  newNoticeService.selectNotice(map.get("id").get(0));
				 if(StringUtils.isNotBlank(notice_content)){
					 String nc = HtmlEscape.getTextFromHtml(notice_content);
					 map.get("notice_content").set(0,nc);
					 if(nc.contains(search)){
							String n = nc.replace(search, "<em style='color:red'>"+search+"</em>");
							 map.get("notice_content").set(0,n);
						}
				 }
			}
		}
		model.addAttribute("documentList", list);
		model.addAttribute("total", sum);
		model.addAttribute("divedPage", divedPage);
		model.addAttribute("nowDate", new Date());
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		//根据对应的索引库进行跳转
		return "/define/portal/cms/solr"+solrSearch.core;
	}
	/**
	 * 
	 * @Title: create 
	 * @Description: 创建Solr索引库
	 * @param solrDir
	 * @return String
	 * @author yuanyue
	 */
	@ResponseBody
	@RequestMapping(value = "create")
	public String create(SolrDir solrDir) {
		solrSearch.createSolrDir(solrDir);
		return "";
	}
	
	
	/**
	 * 根据索引库和关键字获取对应的结果封装到list，获取分页组件封装到divedPage
	 * @param search 查询关键字
	 * @param core 索引库编号
	 */
	private void getListAndSaveHistory(String search, String core) {
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	    DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
		//根据key获取索引结果
		for(String key : coreMap.keySet()) {
			if(coreMap.get(key).contains(core)) {
				solrSearch.selectCore(key);
				String[] f = (String[])returnFields.get(key).toArray();
				list = solrSearch.getResult(search, f);
				divedPage = solrSearch.DivedPage(MAX_SIZE_NUM);
			}
		}
		//记录搜索的关键字到数据库
		if (StringUtils.isNotBlank(search)) {
			SolrHistory record = new SolrHistory();
			record.setName(search);
			boolean b = log.getName(record);
			if (b) {
				log.update(record, true);
			} else {
				/*
				 * 关键字过滤
				 */
				  initSensitiveWords();
				if(!SensitiveWordUtil.contains(search)){
					record.setService(core);
					log.addData(record);
				}
			}
		}
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
	}
	/**
	 * 
	 * @Title: createSolr 
	 * @Description: 页面直接创建solr索引
	 * @param req
	 * @author com.mhout.wzw
	 */
	@RequestMapping(value = "createSolr")
	public void createSolr(HttpServletRequest req) {
		SolrDir solrDir = new SolrDir();
		solrDir.setCoreName(req.getParameter("coreName"));
		solrDir.setTableName(req.getParameter("tableName"));
		SolrSearchService solr = new SolrSearchService();
		solr.createSolrDir(solrDir);
	}
	
	/**
	 * 
	 * @Title: initSensitiveWords 
	 * @Description: 初始化敏感词库
	 * @param 
	 * @author com.mhout.dty
	 */
	public void initSensitiveWords(){
		logger.info("======================================初始化敏感词库");
		@SuppressWarnings("unchecked")
		Set<SensitiveWord> sensitiveWords = (Set<SensitiveWord>) CacheUtils.get("sensitiveWords");
		if(sensitiveWords!= null  && sensitiveWords.isEmpty() ){
			SensitiveWordUtil.init(sensitiveWords);
		} else{
			sensitiveWords = sensitiveWordService.findAll();
			CacheUtils.put("sensitiveWords", sensitiveWords);
			SensitiveWordUtil.init(sensitiveWords);
		}
		
	}
	

}
