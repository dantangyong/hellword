package com.mht.define.portal.cms.web.solr;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.mht.common.config.Global;
import com.mht.common.datasource.DynamicDataSource;
import com.mht.common.json.AjaxJson;
import com.mht.common.persistence.Page;
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
@RequestMapping(value = "${frontPath}/mobileSolr")
public class MobileSolrController extends BaseController {
	@Autowired
	SolrController solrController;
	
	@Autowired
	private SolrSearchService solrSearch;
	
	@ResponseBody
	@RequestMapping(method = { RequestMethod.GET, RequestMethod.POST }, value = "newsList")
	public AjaxJson newsList(HttpServletRequest request ,HttpServletResponse response) {
		String address = "http://" + request.getServerName() + ":" + request.getServerPort();
		AjaxJson ajaxJson = new AjaxJson();
		Map<String,List<String>> coreMap = solrController.getCoreMap();
		List<Map<String, List<String>>> list = solrController.getList();
		Map<String,List<String>> returnFields = solrController.getReturnFields();
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
		String oldDataSource = DynamicDataSource.getCurrentLookupKey();
	    DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
	   //初始化索引库映射关系
 		solrSearch.setPage(PageBean.DEFAULT_PAGECODE);
		solrSearch.loadCoreMap(coreMap,returnFields);
		//获取当前页码
		String page = request.getParameter("pageCode");
		if (page != null) {
			solrSearch.setPage(Integer.parseInt(page));
		}else{
			solrSearch.setPage(Integer.parseInt(Global.ENABLE));
		}
		//获取搜索关键字
		String search = solrSearch.removeSpecialWord(request.getParameter("solr"));
		//获取索引库编号
		String core = request.getParameter("type");
		String pageSize = request.getParameter("pageSize");
		if(pageSize!=null||"".equals(pageSize)){
			solrSearch.setPageSize(Integer.parseInt(pageSize));
		}else{
			solrSearch.setPageSize(PageBean.DEFAULT_PAGESIZE);
		}
		//根据key获取索引结果
		if("0".equals(core)){
			List<Map<String, List<String>>> newsList = null;
			List<Map<String, List<String>>> serviceList = null;
			for(String key : coreMap.keySet()) {
				if(coreMap.get(key).contains("1")) {
					solrSearch.selectCore(key);
					String[] f = (String[])returnFields.get(key).toArray();
					newsList = solrSearch.getResult(search, f);
					ajaxJson.put("newsList", newsList);
				}else if(coreMap.get(key).contains("2")){
					solrSearch.selectCore(key);
					String[] f = (String[])returnFields.get(key).toArray();
					serviceList = solrSearch.getResult(search, f);
					ajaxJson.put("serviceList", serviceList);
				}
			}
		}else{
		for(String key : coreMap.keySet()) {
			if(coreMap.get(key).contains(core)) {
				solrSearch.selectCore(key);
				String[] f = (String[])returnFields.get(key).toArray();
				list = solrSearch.getResult(search, f);
			}
		}
		ajaxJson.put("researchList", list);
		}
		
		/**
		 * 操作完成还回数据源
		 */
		DynamicDataSource.setCurrentLookupKey(oldDataSource);
		//根据对应的索引库进行跳转
		ajaxJson.setMsg("操作成功");
		ajaxJson.setCode("10000");
		ajaxJson.getBody().put("address", address);
		return ajaxJson;
	}
	
}












