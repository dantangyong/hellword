package com.mht.define.portal.cms.dao;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.TagManage;

/**
 * 
 * @ClassName: TagManageDao
 * @Description: 标签管理接口Dao层
 * @author wangjie
 * @date 2017年8月6日 下午3:36:12 
 * @version 1.0.0
 */
@MyBatisDao
public interface TagManageDao extends CrudDao<TagManage>{

}
