package com.system.login.entity;

import java.io.Serializable;

/**
 * 用户实体类
 *
 * @author wangn
 * @date 2017/5/19
 */
public class User implements Serializable {
    /**
     * 用户唯一ID
     */
    private int uid;

    private String username;
    /**
     * 密码
     */
    private String password;

    /**
     * 是否是第一次登陆
     */
    private Boolean firstlogin;
    /**
     * 姓名
     */
    private String name;
    /**
     *
     */
    private Integer userSelectOid;
    /**
     * 角色
     */
    private String percode;

    public String getPercode() {
        return percode;
    }

    public void setPercode(String percode) {
        this.percode = percode;
    }

    public Integer getUserSelectOid() {
        return userSelectOid;
    }

    public void setUserSelectOid(Integer userSelectOid) {
        this.userSelectOid = userSelectOid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) { this.uid = uid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getFirstlogin() {
        return firstlogin;
    }

    public void setFirstlogin(Boolean firstlogin) {
        this.firstlogin = firstlogin;
    }

}
