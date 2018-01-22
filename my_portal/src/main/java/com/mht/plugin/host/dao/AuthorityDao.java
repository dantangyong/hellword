package com.mht.plugin.host.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.plugin.common.pluginfo.PluginAuthority;
import com.mht.plugin.host.entity.LicenseInfo;

@MyBatisDao
public interface AuthorityDao {

    /**
     * @Title: deleteByRole
     * @Description: TODO 通过角色id，删除角色拥有的权限
     * @param id
     * @author com.mhout.sx
     */
    @Delete("delete from mht_plugin.plugin_auth_role where role_id=#{0}")
    void deleteByRole(String id);

    /**
     * @Title: save 保存角色与权限的对应关系
     * @Description: TODO
     * @param id
     * @param code
     * @param name
     * @param page
     * @param plugin
     * @param type
     * @author com.mhout.sx
     */
    @Insert("insert into mht_plugin.plugin_auth_role(role_id,code,name,page,plugin,type) VALUES (#{0},#{1},#{2},#{3},#{4},#{5})")
    void save(String id, String code, String name, String page, String plugin, int type);

    /**
     * @Title: getUserAuth
     * @Description: TODO 通过用户id，获取用户拥有的权限
     * @param id
     * @return
     * @author com.mhout.sx
     */
    @Select("select distinct par.`code`,par.name,par.page,par.`plugin`,par.type "
            + "from mht_base.sys_user su,mht_base.sys_user_role sur,mht_base.sys_role sr,mht_plugin.plugin_auth_role par "
            + "where su.id=sur.user_id and su.id=#{0} and sr.del_flag='0' and sr.id=sur.role_id and par.role_id=sur.role_id")
    List<PluginAuthority> getUserAuth(String id);

    /**
     * @Title: getRoleAuth
     * @Description: TODO 通过角色id查询角色拥有的权限
     * @param id
     * @return
     * @author com.mhout.sx
     */
    @Select("select par.`code`,par.name,par.page,par.`plugin`,par.type "
            + "from mht_plugin.plugin_auth_role par where par.role_id=#{0}")
    List<PluginAuthority> getRoleAuth(String id);

    /**
     * @Title: getUserPlugins
     * @Description: TODO 通过用户id获取用户拥有的插件
     * @param id
     * @return
     * @author com.mhout.sx
     */
    @Select("select distinct par.`code`,par.name,par.page,par.`plugin`,par.type "
            + "from mht_base.sys_user su,mht_base.sys_user_role sur,mht_base.sys_role sr,mht_plugin.plugin_auth_role par "
            + "where su.id=sur.user_id and su.id=#{0} and sr.del_flag='0' and sr.id=sur.role_id and par.role_id=sur.role_id and par.type=0")
    List<PluginAuthority> getUserPlugins(String id);

    /**
     * @Title: getUserAuthByPlugin
     * @Description: TODO 获取用户拥有某个插件的权限
     * @param id：用户id
     * @param code：插件编码
     * @return
     * @author com.mhout.sx
     */
    @Select("select distinct par.`code`,par.name,par.page,par.`plugin`,par.type "
            + "from mht_base.sys_user su,mht_base.sys_user_role sur,mht_base.sys_role sr,mht_plugin.plugin_auth_role par "
            + "where su.id=sur.user_id and su.id=#{0} and sr.del_flag='0' and sr.id=sur.role_id and par.role_id=sur.role_id and par.plugin=#{1}")
    List<PluginAuthority> getUserAuthByPlugin(String id, String code);

    /**
     * @Title: getLicenseByCode
     * @Description: TODO 通过插件编号获取证书
     * @return
     * @author com.mhout.sx
     */
    @Select("select license from mht_plugin.plugin_license where plugin_code=#{0} and enable='1'")
    String getLicenseByCode(String code);

    /**
     * @Title: disableLicense
     * @Description: TODO 禁用之前证书
     * @param code
     * @author com.mhout.sx
     */
    @Update("update mht_plugin.plugin_license set enable='0' where plugin_code=#{0} and enable='1'")
    void disableLicense(String code);

    /**
     * @Title: saveLicense
     * @Description: TODO 保存证书
     * @param id
     * @param code
     * @param license
     * @param userId
     * @param date
     * @author com.mhout.sx
     */
    @Insert("insert into mht_plugin.plugin_license(id,plugin_code,license,create_by,create_date,enable) VALUES (#{0},#{1},#{2},#{3},#{4},'1')")
    void saveLicense(String id, String code, String license, String userId, Date date);

    /**
     * @Title: findList
     * @Description: TODO 分页查询证书
     * @param licenseInfo
     * @return
     * @author com.mhout.sx
     */
    List<LicenseInfo> findList(LicenseInfo licenseInfo);

    /**
     * @Title: getLicenseNum
     * @Description: TODO 查询证书是否存在
     * @param license
     * @param code
     * @return
     * @author com.mhout.sx
     */
    @Select("select count(*) from mht_plugin.plugin_license where plugin_code=#{1} and license=#{0} ")
    int getLicenseNum(String license, String code);
}
