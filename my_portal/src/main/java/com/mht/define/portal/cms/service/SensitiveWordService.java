package com.mht.define.portal.cms.service;

import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.SensitiveWordDao;
import com.mht.define.portal.cms.entity.SensitiveWord;

/**
 * 敏感Service
 * @author dty
 * @version 2017-12-18
 */
@Transactional(readOnly = true)
@Service
public class SensitiveWordService extends CrudService<SensitiveWordDao, SensitiveWord>  {
	 
	 public Set<SensitiveWord> findAll(){
		 return dao.findAll();
	 }
}
