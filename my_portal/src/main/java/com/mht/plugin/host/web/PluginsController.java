package com.mht.plugin.host.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mht.common.datasource.DynamicDataSource;
import com.mht.common.persistence.Page;
import com.mht.common.utils.IdGen;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.modules.sys.entity.Role;
import com.mht.modules.sys.service.RoleService;
import com.mht.plugin.common.dao.PluginCommonDao;
import com.mht.plugin.common.pluginfo.DataSourceInfo;
import com.mht.plugin.common.pluginfo.PluginInfo;
import com.mht.plugin.common.pluginfo.PluginManager;

/**
 * @ClassName: PluginsController
 * @Description: 插件管理页面控制器
 * @author com.mhout.sx
 * @date 2017年9月4日 下午4:23:23
 * @version 1.0.0
 */
@Controller
@RequestMapping("${adminPath}/pluginjsp/host/plugins")
public class PluginsController extends BaseController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private PluginCommonDao pluginCommonDao;

    @Autowired
    private DynamicDataSource dynamicDataSource;

    /**
     * @Title: dataSourceView
     * @Description: TODO 插件数据源配置视图
     * @param code
     * @param model
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/dataSourceView")
    public String dataSourceView(@RequestParam(required = true) String code, Model model) {
        PluginInfo pi = PluginManager.getPluginInfoByCode(code);
        model.addAttribute("pi", pi);

        DataSourceInfo dsi = pluginCommonDao.getDataSource(code);
        if (dsi == null) {
            dsi = new DataSourceInfo();
        }
        model.addAttribute("dsi", dsi);
        return "define/host/dataSource";
    }

    /**
     * @Title: saveDataSource
     * @Description: TODO 插件数据源保存
     * @param jdbcUrl
     * @param driverClassName
     * @param username
     * @param password
     * @param code
     * @param redirectAttributes
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/saveDataSource")
    public String saveDataSource(@RequestParam(required = true) String jdbcUrl,
            @RequestParam(required = true) String driverClassName, @RequestParam(required = true) String username,
            @RequestParam(required = true) String password, @RequestParam(required = true) String code,
            RedirectAttributes redirectAttributes) {
        DataSourceInfo dsi = pluginCommonDao.getDataSource(code);
        if (dsi == null) {
            dsi = new DataSourceInfo();
        } else {
            try {
                // 移除原有数据源
                dynamicDataSource.removeDataSourceByKey(code);
            } catch (Exception e) {
                // TODO: handle exception
                // e.printStackTrace(System.out);
            }
        }
        dsi.setPluginCode(code);
        dsi.setDelFlag("0");
        dsi.setJdbcUrl(jdbcUrl);
        dsi.setDriverClassName(driverClassName);
        dsi.setUsername(username);
        dsi.setPassword(password);
        // 先保存到数据库
        if (StringUtils.isBlank(dsi.getId())) {
            dsi.setId(IdGen.uuid());
            pluginCommonDao.insertDataSource(dsi);
        } else {
            // pluginCommonDao.disableDataSource(dsi.getPluginCode());
            pluginCommonDao.updateDataSource(dsi);
        }

        // 再添加到数据源
        Map<String, String> property = new HashMap<String, String>();
        property.put("jdbcUrl", dsi.getJdbcUrl());
        property.put("driverClassName", dsi.getDriverClassName());
        property.put("username", dsi.getUsername());
        property.put("password", dsi.getPassword());
        dynamicDataSource.addDataSource(code, property);
        // dynamicDataSource.modifyDataSource(code, property);

        addMessage(redirectAttributes, "保存数据源信息成功！");
        return "redirect:" + adminPath + "/pluginjsp/host/plugins/list";
    }

    /**
     * @Title: view
     * @Description: TODO 进入插件时先进入jsp 防止cas验证不能用于ajax
     * @param pluginUrl
     * @param model
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/view")
    public String view(@RequestParam(required = true) String pluginUrl, Model model) {
        model.addAttribute("pluginUrl", pluginUrl);
        return "define/host/pluginView";
    }

    /**
     * @Title: list
     * @Description: TODO 插件列表页面
     * @param model
     * @return
     * @author com.mhout.sx
     */
    @RequiresPermissions("plugin:host:plugins:list")
    @RequestMapping(value = "/list")
    public String list(Model model) {
        List<PluginInfo> list = PluginManager.getPluginInfos();
        model.addAttribute("list", list);
        return "define/host/pluginsList";
    }

    /**
     * @Title: authority
     * @Description: TODO 角色授权页面
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/authority")
    public String authority() {
        return "define/host/roleIndex";
    }

    /**
     * @Title: list
     * @Description: TODO 角色列表页面
     * @param role
     * @param request
     * @param response
     * @param model
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = { "roleList" })
    public String list(Role role, HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("page", roleService.findList(new Page<Role>(request, response), role));
        return "define/host/roleList";
    }

    /**
     * @Title: authorityTree
     * @Description: TODO 权限树结构页面
     * @param id
     * @param model
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = { "authorityTree" })
    public String authorityTree(@RequestParam(required = true) String id, Model model) {
        model.addAttribute("id", id);
        return "define/host/authorityTree";
    }
}
