package com.mht.define.portal.cms.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.mht.common.config.Global;
import com.mht.common.persistence.Page;
import com.mht.common.service.CrudService;
import com.mht.common.utils.FileUtils;
import com.mht.define.portal.cms.dao.DashboardDao;
import com.mht.define.portal.cms.dao.FrontAppDao;
import com.mht.define.portal.cms.entity.BiDto;
import com.mht.define.portal.cms.entity.DashboardBoard;
import com.mht.define.portal.cms.entity.FrontApp;

/**
 * 排版服务层
 * @ClassName: FrontAppService
 * @Description: 
 * @author wangjie
 * @date 2017年5月22日 下午5:18:06 
 * @version 1.0.0
 */
@Service
@Transactional(readOnly = true)
public class FrontAppService extends CrudService<FrontAppDao, FrontApp>{

	@Autowired
	private FrontAppDao dao;
	
	@Autowired
	private DashboardDao biDao;
	
	@Transactional(readOnly = false)
	public void save(HttpServletRequest request, MultipartFile file, FrontApp app) throws IOException {
		String fileName = file.getOriginalFilename();
		boolean message = file != null && file.getInputStream() != null 
				&& StringUtils.isNotBlank(fileName);
		if (message) {
			//修改文件名
			String uuid = UUID.randomUUID().toString();
			fileName = uuid + fileName.substring(fileName.lastIndexOf("."), fileName.length());
			String webPath = request.getSession().getServletContext().getRealPath("/");
			String frontAppUrl = webPath +"/upload"+ Global.PORTAL_APPICON_URL;
			// 转存文件
			File document = new File(frontAppUrl);
			if(!document.exists()){
				FileUtils.createDirectory(frontAppUrl);
			}
			file.transferTo(new File(frontAppUrl + fileName));
			String iconUrl = request.getContextPath()+"/upload"+ Global.PORTAL_APPICON_URL + fileName;
			app.setAppImg(iconUrl);
		}
		super.save(app);
	}

	public Page<FrontApp> findPage(Page<FrontApp> page, FrontApp app) {
		return super.findPage(page, app);
	}
	
	public List<BiDto> biList(){
		List<DashboardBoard> boards = biDao.findList();
		List<BiDto> biDtos = new ArrayList<>();
 		
		List<DashboardBoard> sel = new ArrayList<>();
		DashboardBoard first = boards.get(0);
		String name = first.getCategoryName();
		for (int i=0; i<boards.size(); i++) {
			if(first.getCategoryId() == boards.get(i).getCategoryId()){
				sel.add(boards.get(i));
				if( i==boards.size()-1 ){
					BiDto dto = new BiDto(name, sel);
					biDtos.add(dto);
				}
			} else {
				BiDto dto = new BiDto(name, sel);
				biDtos.add(dto);
				
				sel = new ArrayList<>();
				sel.add(boards.get(i));
				first = boards.get(i);
				name = first.getCategoryName();
				if( i==boards.size()-1 ){
					BiDto dtoNew = new BiDto(name, sel);
					biDtos.add(dtoNew);
				}
			}
		}
		return biDtos;
	}

	@Transactional(readOnly = false)
	public FrontApp disable(String id) {
		FrontApp app = get(id);
		if(Global.ENABLE.equals(app.getDisable())){
			app.setDisable(Global.DISABLE);
		} else {
			app.setDisable(Global.ENABLE);
		}
		save(app);
		return get(app.getId());
	}

	@Transactional(readOnly = false)
	public void sort(String sourceId, String destinationId) {
		FrontApp source = dao.get(sourceId);
		FrontApp destination = dao.get(destinationId);
		Integer temp = source.getSort();
		source.setSort(destination.getSort());
		destination.setSort(temp);
		dao.update(destination);
		dao.update(source);
	}

	public List<FrontApp> findShowApps(FrontApp app) {
		return dao.findShowApps(app);
	}

	public FrontApp getByAPPUrl(String appUrl) {
		return  dao.getByAPPUrl(appUrl);
	}
	
	public FrontApp getByAPPName(String appName) {
		return  dao.getByAPPName(appName);
	}

}
