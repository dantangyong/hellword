package com.mht.define.portal.cms.utils.solrstrategy.impl;

import static com.mht.define.portal.cms.utils.ConstantDictionary.PASSWORD;
import static com.mht.define.portal.cms.utils.ConstantDictionary.SOLR_DATABASE_URL;
import static com.mht.define.portal.cms.utils.ConstantDictionary.SOLR_SQL_BASE;
import static com.mht.define.portal.cms.utils.ConstantDictionary.USERNAME;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Map;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import com.mht.define.portal.cms.entity.SolrDir;
import com.mht.define.portal.cms.utils.RemoteExecuteCommand;
import com.mht.define.portal.cms.utils.solrstrategy.SolrCommand;
import static com.mht.define.portal.cms.utils.ConstantDictionary.*;

public class SolrLinuxCommand implements SolrCommand {

	@Override
	public void createSolrCore(SolrDir solrDir) {
		RemoteExecuteCommand rec=new RemoteExecuteCommand(REMOTE_SOLR_LINUX_IP, SOLR_LINUX_USER,SOLR_LINUX_PASSWORD);  
        //执行命令  
		System.out.println(rec.execute(SOLR_LINUX_BASE_PATH+"bin/solr create -c "+solrDir.getCoreName()+" -force"));
	}

	@Override
	public void createDataConfig(SolrDir solrDir, List<Map<String, String>> fieldList) {
		//根节点
		Element dataConfig = DocumentHelper.createElement("dataConfig");
		//创建文档
        Document doc = DocumentHelper.createDocument(dataConfig);
        //创建dataSource节点
        Element dataSource = dataConfig.addElement("dataSource");
        dataSource.addAttribute("name", "source1")
        	.addAttribute("type", "JdbcDataSource")
        	.addAttribute("driver", "com.mysql.jdbc.Driver")
        	.addAttribute("url", SOLR_DATABASE_URL)
        	.addAttribute("user", USERNAME)
        	.addAttribute("password", PASSWORD);
        //创建document节点
        Element document = dataConfig.addElement("document");
        //document下创建entity节点
        Element entity = document.addElement("entity");
        entity.addAttribute("name", solrDir.getCoreName())
        	.addAttribute("transformer", "DateFormatTransformer")
        	.addAttribute("query", SOLR_SQL_BASE+solrDir.getTableName());
        //添加field
        for(Map<String,String> fieldMap : fieldList) {
        	Element field = entity.addElement("field");
        	for(String key : fieldMap.keySet()) {
        		field.addAttribute("column", key)
            	.addAttribute("name", key);
        	}
        }
		
        OutputFormat format = new OutputFormat("    ",true);  
        format.setEncoding("UTF-8");//设置编码格式  
        XMLWriter xmlWriter;
		try {
			//xmlWriter = new XMLWriter(System.out,format);
			//创建数据库映射配置文件db-data-config
			xmlWriter = new XMLWriter(new FileOutputStream(
					new File(SOLR_LINUX_BASE_PATH+"server/solr/"+solrDir.getCoreName()+"/conf/db-data-config.xml")),format);
			xmlWriter.write(doc);
		    xmlWriter.close();
		    //写入配置文件
		    File fileProperties = new File(SOLR_LINUX_BASE_PATH+"server/solr/"+solrDir.getCoreName()+"/conf/dataimport.properties");
		    if(!fileProperties.exists()) {
		    	fileProperties.createNewFile();
		    }
		    //替换solrconfig以支持数据库映射
		    Path destination = Paths.get(SOLR_LINUX_BASE_PATH+"server/solr/"+solrDir.getCoreName()+"/conf/solrconfig.xml");  
		    Path copiedFile = Paths.get(SOLR_LINUX_BASE_PATH+"server/solr/copy-config/solrconfig.xml");
		    Files.copy(copiedFile, destination, StandardCopyOption.REPLACE_EXISTING);//替换
		} catch (Exception e) {
			e.printStackTrace();
		}
		//为schema添加索引字段
		SAXReader reader = new SAXReader();
		Document managedSchema = null;
	    try {
			managedSchema = reader.read(new File(SOLR_LINUX_BASE_PATH+"server/solr/"+solrDir.getCoreName()+"/conf/managed-schema"));
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		//获取schema节点
		Element schema = managedSchema.getRootElement();
		//根据数据库映射添加索引字段
		for(Map<String,String> fieldMap : fieldList) {
			for(String key : fieldMap.keySet()) {
				if(key.equals("id")) {//id是文件默认字段，排除
					break;
				}
				Element field = schema.addElement("field");
				field.addAttribute("name", key);
				if(fieldMap.get(key).toUpperCase().contains("Time".toUpperCase())) {//如果字段类型是时间，设为时间类型
					field.addAttribute("type", "tdate");
				}else {
					field.addAttribute("type", "text_cjk");//如果字段类型不是时间统一设置为cjk分词
				}
				field.addAttribute("docValues", "false");
				field.addAttribute("indexed", "true");
				field.addAttribute("stored", "true");
			}
		}
		
		try {
			//xmlWriter = new XMLWriter(System.out,format);
			xmlWriter = new XMLWriter(new FileOutputStream(
						new File(SOLR_LINUX_BASE_PATH+"server/solr/"+solrDir.getCoreName()+"/conf/managed-schema")),format);
			xmlWriter.write(managedSchema);
		    xmlWriter.close();
		}catch (Exception e) {
			e.printStackTrace();
		}		
	}

	@Override
	public void restartSolrService() {
		RemoteExecuteCommand rec=new RemoteExecuteCommand(REMOTE_SOLR_LINUX_IP, SOLR_LINUX_USER,SOLR_LINUX_PASSWORD);  
        //执行命令  
		System.out.println(rec.execute(SOLR_LINUX_BASE_PATH+"bin/solr stop -all -force"));
		
		System.out.println(rec.execute(SOLR_LINUX_BASE_PATH+"bin/solr start -force"));
	}

	@Override
	public void createSolrIndex(SolrDir solrDir) {
		HttpClient httpCient = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet("http://"+REMOTE_SOLR_LINUX_IP+":"+SOLR_LINUX_PORT+"/solr/#/"+solrDir.getCoreName()+"/dataimport?command=full-import");
		try {
			httpCient.execute(httpGet);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
