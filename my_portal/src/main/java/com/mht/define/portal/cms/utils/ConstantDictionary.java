package com.mht.define.portal.cms.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.mht.define.portal.cms.service.SolrSearchService;

/**
 * 常量字典
 * @author yy
 * @version 2017-7-26
 * 
 */
public class ConstantDictionary {
	/**
	 * 默认结果数
	 */
	public static final int DEFAULT_ALLRESULT = 0;
	/**
	 * 默认当前页
	 */
	public static final int DEFAULT_PAGE = 1;
	/**
	 * 默认最后页
	 */
	public static final int DEFAULT_LAST = 1;
	/**
	 * 默认solr索引库
	 */
	public static final String DEFAULT_SOLR_CORE = "news";
	/**
	 * 默认solr配置文件
	 */
	public static final String DEFAULT_SOLR_CONFIG = "solr-config.properties";
	/**
	 * 默认solr索引库服务code
	 */
	public static final String DEFAULT_SOLR_SERVICECODE = "0";
	/**
	 * 默认solr分页组件上一页和下一页之间页码的容量
	 */
	public static final int DEFAULT_SOLR_MAX_SIZE_NUM = 10;
	/**
	 * Solr创建索引用到的数据库Url
	 */
	public static String SOLR_DATABASE_URL;
	/**
	 * Solr链接数据库用户名
	 */
	public static String USERNAME;
	/**
	 * Solr链接数据库密码
	 */
	public static String PASSWORD;
	/**
	 * Solr获取表字段的基础sql语句
	 */
	public static final String SOLR_SQL_BASE = "select * from ";
	/**
	 * 远程Solr服务器IP
	 */
	public static String REMOTE_SOLR_LINUX_IP;
	/*
	 * 成功请求后返回信息
	 */
	public static final String SUCCESS_CODE = "10000";
	
	public static String SOLR_LINUX_USER;
	
	public static String SOLR_LINUX_PASSWORD;
	
	public static String SOLR_LINUX_BASE_PATH;
	
	public static String SOLR_LINUX_PORT;
	
	static {
		InputStream ins = SolrSearchService.class.getResourceAsStream(ConstantDictionary.DEFAULT_SOLR_CONFIG);
		Properties prop = new Properties();
		try {
			prop.load(ins);
			SOLR_DATABASE_URL = prop.getProperty("SOLR_DATABASE_URL");
			USERNAME = prop.getProperty("USERNAME");
			PASSWORD = prop.getProperty("PASSWORD");
			REMOTE_SOLR_LINUX_IP = prop.getProperty("SOLR_LINUX_IP");
			SOLR_LINUX_USER = prop.getProperty("SOLR_LINUX_USER");
			SOLR_LINUX_PASSWORD = prop.getProperty("SOLR_LINUX_PASSWORD");
			SOLR_LINUX_BASE_PATH = prop.getProperty("SOLR_LINUX_BASE_PATH");
			SOLR_LINUX_PORT = prop.getProperty("SOLR_LINUX_PORT");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
