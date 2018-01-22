package com.mht.define.portal.cms.web;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mht.common.json.AjaxJson;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.AppBlocksUserRecordData;
import com.mht.define.portal.cms.entity.AppBlocksUserRecordList;
import com.mht.define.portal.cms.entity.FrontApp;
import com.mht.define.portal.cms.service.AppBlocksUserRecordService;
import com.mht.define.portal.cms.service.AppBlocksVisitService;
import com.mht.define.portal.cms.service.FrontAppService;
import com.mht.modules.ident.entity.Application;
import com.mht.modules.sys.entity.Office;

/**
 * @ClassName: PortalBlocksVisitController
 * @Description: 门户版块访问统计
 * @author com.mhout.dty
 * @date 2017年12月18日 上午15:08:46
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/portalapp/blocksvisit")
public class AppBlocksVisitController extends BaseController {
    
	@Autowired
	AppBlocksVisitService appBlocksVisitService;
	
	@Autowired
	private AppBlocksUserRecordService appBlocksUserRecordService;
	
	@Autowired
	private FrontAppService frontAppService;
	/**
	 * @Title: getVisitStatistics 
	 * @Description: 访问统计图
	 * @param appUserRecord
	 * @return
	 * @author com.mhout.dty
	 */
	@ResponseBody
//	@RequiresPermissions("portal:appvisit:list")
	@RequestMapping(value = { "getVisitStatistics"})
	public AppBlocksUserRecordList getVisitStatistics(String type, String grade) {
		Office office = new Office();
		if (StringUtils.isNotBlank(grade)) {
			office.setGrade(grade);
		} else {
			office = null;
		}
		return this.appBlocksVisitService.findVisitStatistics(type, office);
	}
	
	/**
	 * @Title: getVisitAmount 
	 * @Description: 访问量TOP10
	 * @return
	 * @author com.mhout.dty
	 */
	@ResponseBody
//	@RequiresPermissions("audit:appvisit:list")
	@RequestMapping(value = { "getVisitAmount"})
	public List<AppBlocksUserRecordData> getVisitAmount(String grade) {
		return this.appBlocksVisitService.findVisitAmount(grade);
	}
	
	/**
	 * @Title: getVisitUser 
	 * @Description: 用户占比TOP10
	 * @return
	 * @author com.mhout.dty
	 */
	@ResponseBody
//	@RequiresPermissions("audit:appvisit:list")
	@RequestMapping(value = { "getVisitUser"})
	public List<AppBlocksUserRecordData> getVisitUser(String grade) {
		return this.appBlocksVisitService.findVisitUser(grade);
	}
	
	/**
	 * @Title: getVisitTrend 
	 * @Description: 应用访问趋势TOP10
	 * @return
	 * @author com.mhout.dty
	 */
	@ResponseBody
//	@RequiresPermissions("audit:appvisit:list")
	@RequestMapping(value = { "getVisitTrend"})
	public List<AppBlocksUserRecordData> getVisitTrend(String grade) {
		return this.appBlocksVisitService.findVisitTrend(grade);
	}
	
	/**
	 * @Title: getVisitHistory 
	 * @Description: 访问历史总览
	 * @return
	 * @author com.mhout.dty
	 */
	@ResponseBody
//	@RequiresPermissions("audit:appvisit:list")
	@RequestMapping(value = { "getVisitHistory"})
	public List<AppBlocksUserRecordData> getVisitHistory() {
		return this.appBlocksVisitService.findVisitHistory();
	}
	
	 /**
     * @Title: record 
     * @Description: 访问记录
     * @param id
     * @author com.mhout.dty
     */
    @ResponseBody
//    @RequiresPermissions("ident:userapplication:card")
  	@RequestMapping(value = "record")
    public AjaxJson record(FrontApp frontApp) {
    	AjaxJson json = new AjaxJson();
    	json.setSuccess(false);
    	json.setCode("0");
    	json.setMsg("操作失败");
    	FrontApp fa = frontAppService.getByAPPName(frontApp.getAppName());
    	if(fa != null){
    		logger.info("==================start");
    		appBlocksUserRecordService.record(fa);
    		logger.info("==================end");
    		json.setSuccess(true);
        	json.setMsg("操作成功");
    	}
		return json;
    }
	
}
