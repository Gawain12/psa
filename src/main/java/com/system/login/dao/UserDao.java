package com.system.login.dao;

import com.system.file.entity.History;
import com.system.file.entity.OrderInfo;
import com.system.login.entity.User;
import com.system.util.PagingVO;

import java.util.List;
import java.util.Map;

/**
 * 用户DAO
 *
 * @author wangn
 * @date 2017/5/19
 */
public interface UserDao {
    /**
     * 根据用户名获取密码
     *
     * @param username 用户名
     * @return 密码
     */
    String getPasswd(String username);

    /**
     * 根据ID获取密码
     *
     * @param uid 用户ID
     * @return 密码
     */
    String getPasswdById(int uid);

    /**
     * 获取是否为第一次登陆
     *
     * @param uid 用户ID
     * @return 第一次登陆返回<code>true</code>，否则返回<code>false</code>
     */
    boolean isFirstLogin(int uid);

    /**
     * 根据用户名获取用户信息
     *
     * @param username 用户名
     * @return 用户信息
     */
    User getUserEntity(String username);

    /**
     * 根据用户ID修改密码
     *
     * @param map 用户ID，新密码
     */
    void setUserPasswd(Map<String, Object> map);

    /**
     * 根据用户ID设置登陆标记
     *
     * @param firstLogin 是第一次登陆
     */
    void setFirstLogin(Map<String, Object> firstLogin);

    /**
     * 根据用户ID返回用户信息
     *
     * @param uid 用户ID
     * @return 用户信息
     */
    User getUserEntityByID(int uid);

    /**
     * 获取所有用户
     *
     * @return 用户集合
     */
    List<User> getUserList();

    /**
     * 根据OPEN ID获取用户
     *
     * @param userOpenID OPEN ID
     * @return 用户信息
     */
    User getUserEntityByOpenID(String userOpenID);

    /**
     * 根据用户ID插入用户OPEN ID
     *
     * @param  {@link User}
     */

    User getUserEntityByHid(int hid);

    List<User> findByPaging(PagingVO pagingVO) throws Exception;

    /**
     * 添加用户
     * @param user
     */
    void addStudent(User user);

    /**
     * 获取学生数
     * @return
     * @throws Exception
     */
    int getCount() throws Exception;

    /**
     * 删除学生
     * @param uid
     */
    void delStudentByUID(Integer uid);
    /**
     * change the information of the students
     */
    void upStudent(User user);
     }
