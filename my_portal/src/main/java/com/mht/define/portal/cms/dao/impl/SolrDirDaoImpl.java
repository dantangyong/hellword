package com.mht.define.portal.cms.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mht.define.portal.cms.dao.SolrDirDao;
import static com.mht.define.portal.cms.utils.ConstantDictionary.*;
@Repository("solrDirDao")
public class SolrDirDaoImpl implements SolrDirDao {
	private Connection conn = null;
    private String url = SOLR_DATABASE_URL;
    private String userName = USERNAME;
    private String password = PASSWORD;
    private String sql = SOLR_SQL_BASE;
	
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public List<Map<String,String>> getFieldList(String tabName) {
		try {
			conn = DriverManager.getConnection(url,userName,password);
			PreparedStatement pstmt = conn.prepareStatement(sql+tabName);
			ResultSet resultSet = pstmt.executeQuery();
			//获取表元数据
			ResultSetMetaData metaData = resultSet.getMetaData();
			List<Map<String,String>> fieldList = new ArrayList<>();
			for(int i = 1;i<=metaData.getColumnCount();i++) {
				Map<String,String> fieldMap = new HashMap<>();
				//存入字段名和字段类型
				fieldMap.put(metaData.getColumnName(i), metaData.getColumnClassName(i));
				fieldList.add(fieldMap);
			}
			conn.close();
			return fieldList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

}
