package com.mht.define.portal.cms.dao;

import java.util.Set;
import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.SensitiveWord;
/**
 * 敏感DAO接口
 * @author dty
 * @version 2017-12-18
 */
@MyBatisDao
public interface SensitiveWordDao extends CrudDao<SensitiveWord>  {
	
	Set<SensitiveWord> findAll();
}