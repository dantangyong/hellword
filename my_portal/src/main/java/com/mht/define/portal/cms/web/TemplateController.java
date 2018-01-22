package com.mht.define.portal.cms.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.Site;
import com.mht.define.portal.cms.service.FileTplService;
import com.mht.define.portal.cms.service.SiteService;

/**
 * 站点Controller
 * @author SongLai
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/template")
public class TemplateController extends BaseController {

    @Autowired
   	private FileTplService fileTplService;
    @Autowired
   	private SiteService siteService;

//    @RequiresPermissions("cms:template:edit")
   	@RequestMapping(value = "")
   	public String index() {
   		return "/define/portal/cms/tplIndex";
   	}

    @RequiresPermissions("cms:template:edit")
   	@RequestMapping(value = "tree")
   	public String tree(Model model) {
        Site site = siteService.get(Site.getCurrentSiteId());
   		model.addAttribute("templateList", fileTplService.getListForEdit(site.getSolutionPath()));
   		return "/define/portal/cms/tplTree";
   	}

//    @RequiresPermissions("cms:template:edit")
   	@RequestMapping(value = "form")
   	public String form(String name, Model model) {
        model.addAttribute("template", fileTplService.getFileTpl(name));
   		return "/define/portal/cms/tplForm";
   	}

//    @RequiresPermissions("cms:template:edit")
   	@RequestMapping(value = "help")
   	public String help() {
   		return "/define/portal/cms/tplHelp";
   	}
}
