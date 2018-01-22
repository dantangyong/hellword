package com.mht.plugin.host.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mht.common.json.AjaxJson;
import com.mht.common.persistence.Page;
import com.mht.common.web.BaseController;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.utils.UserUtils;
import com.mht.plugin.common.license.LicenseUtil;
import com.mht.plugin.common.license.PluginLicense;
import com.mht.plugin.common.pluginfo.PluginInfo;
import com.mht.plugin.common.pluginfo.PluginManager;
import com.mht.plugin.host.entity.LicenseInfo;
import com.mht.plugin.host.service.AuthorityService;

/**
 * @ClassName: PluginsLicenseController
 * @Description: 证书生成页面，不需要菜单，只供公司内部人员使用
 * @author com.mhout.sx
 * @date 2017年9月29日 下午4:39:20
 * @version 1.0.0
 */
@Controller
@RequestMapping("${adminPath}/pluginjsp/host/license")
public class PluginsLicenseController extends BaseController {

    @Autowired
    private AuthorityService authorityService;

    /**
     * @Title: list
     * @Description: TODO 需要证书的插件列表
     * @param model
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/list")
    public String list(Model model) {
        List<PluginInfo> list = PluginManager.getPluginInfoByLicense(true);
        model.addAttribute("list", list);
        return "define/host/pluginsLicenseList";
    }

    /**
     * @Title: createLicense
     * @Description: TODO 创建证书的页面
     * @param code
     * @param model
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/createLicense")
    public String createLicense(@RequestParam(required = true) String code, Model model) {
        PluginInfo pi = PluginManager.getPluginInfoByCode(code);
        model.addAttribute("pi", pi);

        return "define/host/createLicense";
    }

    /**
     * @Title: saveLicenseView
     * @Description: TODO保存证书页面
     * @param code
     * @param model
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/saveLicenseView")
    public String saveLicenseView(@RequestParam(required = true) String code, Model model) {
        PluginInfo pi = PluginManager.getPluginInfoByCode(code);
        model.addAttribute("pi", pi);

        return "define/host/saveLicense";
    }

    /**
     * @Title: getLicense
     * @Description: TODO 生成证书
     * @param code
     * @param month
     * @return
     * @author com.mhout.sx
     */
    @ResponseBody
    @RequestMapping(value = "/getLicense")
    public AjaxJson getLicense(@RequestParam(required = true) String code, @RequestParam(required = true) int month) {
        AjaxJson aj = new AjaxJson();
        User currentUser = UserUtils.getUser();
        try {
            PluginLicense pl = new PluginLicense();
            pl.setUserId(currentUser.getId());
            pl.setCreateDate(new Date());
            pl.setPluginCode(code);
            pl.setEndDate(LicenseUtil.getEndDate(new Date(), month));
            String license = LicenseUtil.getLicense(pl);
            license = license.replaceAll("[\\t\\n\\r]", "");
            license = license.replace(" ", "");
            aj.setCode("0");
            aj.setMsg(license);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            aj.setCode("-1");
            aj.setMsg("生成证书失败:" + e.getMessage());
        }
        return aj;
    }

    /**
     * @Title: saveLicense
     * @Description: TODO 保存插件证书
     * @param code
     * @param license
     * @param redirectAttributes
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/saveLicense")
    public String saveLicense(@RequestParam(required = true) String code, @RequestParam(required = true) String license,
            RedirectAttributes redirectAttributes) {
        PluginInfo pi = PluginManager.getPluginInfoByCode(code);
        license = license.replaceAll("[\\t\\n\\r]", "");
        license = license.replace(" ", "");
        // System.out.println(license);
        if (pi.isLicense()) {
            // 判断相同证书是否存在
            if (authorityService.getLicenseNum(license, code) > 0) {
                addMessage(redirectAttributes, "该证书已存在，不允许重复上传！");
            } else {
                AjaxJson aj = LicenseUtil.verifyLicense(license, code);
                if ("0".equals(aj.getCode())) {
                    authorityService.saveLicense(code, license);
                    addMessage(redirectAttributes, "保存证书成功");
                } else {
                    addMessage(redirectAttributes, aj.getMsg());
                }
            }
        } else {
            addMessage(redirectAttributes, "该插件不需要证书！");
        }
        return "redirect:" + adminPath + "/pluginjsp/host/plugins/list";
    }

    /**
     * @Title: myLicense
     * @Description: TODO 插件证书分页
     * @param licenseInfo
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     * @author com.mhout.sx
     */
    @RequiresPermissions("plugin:host:license:myLicense")
    @RequestMapping(value = "/myLicense")
    public String myLicense(LicenseInfo licenseInfo, HttpServletRequest request, HttpServletResponse response,
            Model model) throws Exception {
        Page<LicenseInfo> page = authorityService.findLicense(new Page<LicenseInfo>(request, response), licenseInfo);
        model.addAttribute("page", page);
        List<PluginInfo> plugins = PluginManager.getPluginInfoByLicense(true);
        model.addAttribute("plugins", plugins);
        model.addAttribute("licenseInfo", licenseInfo);
        return "define/host/myLicenseList";
    }
}
