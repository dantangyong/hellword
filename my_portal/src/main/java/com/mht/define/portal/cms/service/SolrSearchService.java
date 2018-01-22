package com.mht.define.portal.cms.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.ParsePosition;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;

import org.apache.solr.client.solrj.SolrServerException;

import org.apache.solr.client.solrj.impl.HttpSolrClient.Builder;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mht.common.utils.DateUtils;
import com.mht.common.utils.StringUtils;
import com.mht.define.portal.cms.dao.SolrCoreMapDao;
import com.mht.define.portal.cms.dao.SolrDirDao;
import com.mht.define.portal.cms.dao.impl.SolrDirDaoImpl;
import com.mht.define.portal.cms.entity.SolrCoreMap;
import com.mht.define.portal.cms.entity.SolrDir;
import com.mht.define.portal.cms.entity.SolrReturnField;
import static com.mht.define.portal.cms.utils.ConstantDictionary.*;
import com.mht.define.portal.cms.utils.SolrDvidePage;
import com.mht.define.portal.cms.utils.solrstrategy.SolrCommand;
import com.mht.define.portal.cms.web.solr.SolrController;

@Service
public class SolrSearchService {
	private QueryResponse queryResponse;
	private long allResult = DEFAULT_ALLRESULT;
	private int page = DEFAULT_PAGE;
	private int last = DEFAULT_LAST;
	public String core = DEFAULT_SOLR_CORE;
	private String order = null;
	private int pageSize;
	private String baseURL;
	private String commandStrategy;
	public static final Logger logger = LoggerFactory.getLogger(SolrSearchService.class); 
	@Autowired
	private SolrCoreMapDao solrCoreMapDao;
//	@Autowired
//	private SolrDirDao solrDirDao;
	private SolrDirDao solrDirDao = new SolrDirDaoImpl();
	
	/**
	 * 从构造方法中根据配置文件初始化
	 */
	public SolrSearchService(){
		InputStream ins = this.getClass().getResourceAsStream(DEFAULT_SOLR_CONFIG);
		Properties prop = new Properties();
		try {
			prop.load(ins);
			this.setBaseURl(prop.getProperty("baseURL"));
			this.setPageSize(Integer.parseInt(prop.getProperty("pageSize")));
			this.setCommandStrategy(prop.getProperty("SOLR_SYS"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public String getCommandStrategy() {
		return commandStrategy;
	}
	public void setCommandStrategy(String commandStrategy) {
		this.commandStrategy = commandStrategy;
	}
	/**
	 * 选择索引库
	 * @param core
	 */
	public void selectCore(String core) {
		this.core = core;
	}
	/**
	 * 设置当前页
	 * @param page
	 */
	public void setPage(int page) {
		this.page = page;
	}

	public void setOrder(String order) {
		this.order = order;
	}
	/**
	 * 设置基本路径
	 * @param solrUrl
	 */
	public void setBaseURl(String solrUrl) {
		baseURL = solrUrl;
	}
	/**
	 * 设置每页条目数
	 * @param size
	 */
	public void setPageSize(int size) {
		pageSize = size;
	}
	/**
	 * 获取总结果数
	 * @return
	 */
	public long getAllresult() {
		return allResult;
	}
	/**
	 * 构建solr客户端
	 * @return
	 */
	private SolrClient getSolrClient() {
		Builder builder = new Builder(baseURL + core);
		SolrClient solrClient = builder.build();
		return solrClient;
	}
	/**
	 * 获取query
	 * @return
	 */
	private SolrQuery seacher() {
		SolrQuery solrQuery = new SolrQuery();
		return solrQuery;

	}
	/**
	 * 获取索引结果
	 * @param a 查询条件
	 * @param f1 需要返回的字段
	 * @return
	 */
	private QueryResponse getSeacherResponse(String a, String... f1) {
		SolrQuery query = seacher();
		query.setRequestHandler("/select");
		query.setQuery(a);
		if(core.equals("video")){
			query.setFilterQueries("disable:1");
			query.setFilterQueries("del_flag:0");
		}else if(core.equals("news")){
			query.setFilterQueries("article_del_flag:0");
		}else{
			query.setFilterQueries("del_flag:0");
		}
		query.addField("id");
		query.setHighlight(true);
		query.setHighlightSimplePre("<em style='color:red'>");
		query.setHighlightSimplePost("</em>");
		if (f1.length == 0) {
			query.addField("article_title");
			query.addField("article_description");
			query.addField("create_date");
			query.addHighlightField("article_title");
			query.addHighlightField("article_description");
			query.setFilterQueries("del_flag:0");
		}
		else {
			String[] f = f1.clone();
			for (String field : f) {
				query.addField(field);
				query.addHighlightField(field);
			}
		}
		query.setStart((page - 1) * pageSize);
		query.setRows(pageSize);
		try {
			 System.out.println(query.toString());
			QueryResponse response = getSolrClient().query(query);
			
			 System.out.println(response);
			return response;
		} catch (SolrServerException e) {
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 获取结果数据
	 * @param query
	 * @param f
	 * @return
	 */
	public List<Map<String, List<String>>> getResult(String query, String... f) {
		queryResponse = getSeacherResponse(query, f);
		SolrDocumentList documentList = queryResponse.getResults();
		List<Map<String, List<String>>> list = new ArrayList<>();
		if (documentList != null) {
			allResult = documentList.getNumFound();
			List<String> id = new ArrayList<>();
			List<Map<String, List<String>>> h = new ArrayList<>();
			for (SolrDocument document : documentList) {
				Map<String, List<String>> map = new HashMap<>();
				for (String field : document.getFieldNames()) {
					List<String> obj = new ArrayList<>();
					Collection<Object> col = document.getFieldValues(field);
					Object[] values = col.toArray();
					for (Object ob : values) {
						obj.add(ob.toString());
					}
					Object obj1 = document.getFirstValue(field);
					if (field.equals("id")) {
						id.add((String) document.getFieldValue(field));
						map.put(field, obj);
						
					} else {
						if (obj1 instanceof Date) {
							obj.clear();
							String s = DateUtils.formatDate(((Date) obj1), "yyyy-MM-dd HH:mm:ss");
							obj1 = DateUtils.parseDate(s);
							obj1 = ((Date) obj1).toLocaleString();
							obj.add(obj1.toString());
						}
						map.put(field, obj);
					}
				}
				
				list.add(map);
			}

			Map<String, Map<String, List<String>>> hmap = queryResponse.getHighlighting();
			for (String sid : id) {
				Map<String, List<String>> dmap = hmap.get(sid);
				h.add(dmap);
			}

			// 用高亮数据替换普通文本
			for (int i = 0; i < h.size(); i++) {
				Map<String, List<String>> mapH = h.get(i);
				Iterator<String> it = mapH.keySet().iterator();
				while (it.hasNext()) {
					String key = it.next();
					if (list.get(i).containsKey(key) && !key.equals("service_img") && !key.equals("article_image")) {
						    list.get(i).replace(key, mapH.get(key));
					}
				}
			}
		}
		return list;
	}
	/**
	 * 获取最后一页的页码
	 * @return
	 */
	public int lastPage() {
		if (allResult > 0 && allResult % pageSize == 0) {
			last = (int) (allResult / pageSize);
		}
		if (allResult > 0 && allResult % pageSize != 0) {
			last = (int) (allResult / pageSize + 1);
		}
		return (int) last;
	}
	/**
	 * 获取分页组件
	 * @param num
	 * @return
	 */
	public List<Map<String, Object>> DivedPage(int num) {
		return SolrDvidePage.input(page, lastPage(), num);
	}
	
	/**
	 * 初始化索引库映射关系,索引库和返回字段的映射关系
	 * @param returnFields 
	 */
	public void loadCoreMap(Map<String,List<String>> coreMap, Map<String, List<String>> returnFields) {
		List<SolrCoreMap> coreMapList = solrCoreMapDao.getCoreMap();
		for(SolrCoreMap map : coreMapList) {
			String[] codes = map.getMapCode().split(",");
			coreMap.put(map.getCoreName(), Arrays.asList(codes));
		}
		
		List<SolrReturnField> returnFieldsList = solrCoreMapDao.getReturnFields();
		for(SolrReturnField solrReturnfields : returnFieldsList) {
			String[] fields = solrReturnfields.getFieldName().split(",");
			returnFields.put(solrReturnfields.getCoreName(), Arrays.asList(fields));
		}
	}
	
	public void createSolrDir(SolrDir solrDir) {
		List<Map<String,String>> fieldList = solrDirDao.getFieldList(solrDir.getTableName());
		
		createSolrCore(solrDir);
		
		createDataConfig(solrDir, fieldList); 
      
		//System.out.println("读取到的表数据："+fieldList);
	}
	/**
	 * 
	 * @Title: createSolrCore 
	 * @Description: 根据coreName创建索引库
	 * @param solrDir void
	 * @author yuanyue
	 */
	private void createSolrCore(SolrDir solrDir) {
		SolrCommand command = null;
		try {
			command = (SolrCommand) Class.forName("com.mht.define.portal.cms.utils.solrstrategy.impl."+commandStrategy).newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		command.createSolrCore(solrDir);
	}
	/**
	 * 创建Solr索引库-数据库映射配置文件
	 * @param solrDir
	 * @param fieldList
	 */
	private void createDataConfig(SolrDir solrDir, List<Map<String, String>> fieldList) {
		SolrCommand command = null;
		try {
			command = (SolrCommand) Class.forName("com.mht.define.portal.cms.utils.solrstrategy.impl."+commandStrategy).newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		command.createDataConfig(solrDir, fieldList);
		command.restartSolrService();
		command.createSolrIndex(solrDir);
	}

	public static void main(String[] args) {
		SolrDir solrDir = new SolrDir();
		solrDir.setCoreName("wzwStudy");
		solrDir.setTableName("cms_article");
		SolrSearchService solr = new SolrSearchService();
		solr.createSolrDir(solrDir);
	}
    
	/**
	 * @Title: removeSpecialWord
	 * @Description:过滤特殊字符
	 * @param s
	 * @return
	 * @author dty
	 */
	
	public String removeSpecialWord(String s){
		 String regEx="[`~!@#$^&*()=+|{}':;',\\[\\].·<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、?？%\"]";   
		  Pattern   p   =   Pattern.compile(regEx);      
		  Matcher   m   =   p.matcher(s);      
		  return   m.replaceAll("").trim();  
	}
	public String selectService(String string) {
		return solrCoreMapDao.selectService(string);
	}
}
