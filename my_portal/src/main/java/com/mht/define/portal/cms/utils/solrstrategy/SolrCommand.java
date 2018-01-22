package com.mht.define.portal.cms.utils.solrstrategy;

import java.util.List;
import java.util.Map;

import com.mht.define.portal.cms.entity.SolrDir;
/**
 * Solr命令接口
 * @author admin
 *
 */
public interface SolrCommand {
	/**
	 * 
	 * @Title: createSolrCore 
	 * @Description: 创建solr索引库
	 * @param solrDir void
	 * @author yuanyue
	 */
	public void createSolrCore(SolrDir solrDir);
	/**
	 * 
	 * @Title: createDataConfig 
	 * @Description: 创建Solr索引库-数据库映射配置文件
	 * @param solrDir
	 * @param fieldList void
	 * @author yuanyue
	 */
	public void createDataConfig(SolrDir solrDir, List<Map<String, String>> fieldList);
	/**
	 * 
	 * @Title: restartSolrService 
	 * @Description: 重启solr服务
	 * @author yuanyue
	 */
	public void restartSolrService();
	/**
	 * 
	 * @Title: createSolrIndex 
	 * @Description: 从数据库数据初始化索引
	 * @param solrDir void
	 * @author yuanyue
	 */
	public void createSolrIndex(SolrDir solrDir);
	
}
