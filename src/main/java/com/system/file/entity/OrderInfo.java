package com.system.file.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 作业批次实体
 *
 * @author wangn
 * @date 2017/5/20
 */
public class OrderInfo implements Serializable {
    /**
     * 作业批次ID
     */
    private int oid;
    /**
     * 创建教师id
     */
    private String ouid;
    /**
     * 科目名
     */
    private String oname;
    /**
     * 作业名
     */
    private String osubject;
    /**
     * 修改时间
     */
    private Date otime;
    
    public Date getOtime() {
        return otime;
    }

    public void setOtime(Date otime) {
        this.otime = otime;
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public String getOname() {
        return oname;
    }

    public void setOname(String oname) {
        this.oname = oname;
    }

    public String getOsubject() {
        return osubject;
    }

    public void setOsubject(String osubject) {
        this.osubject = osubject;
    }

    public String getOuid() {
        return ouid;
    }

    public void setOuid(String ouid) {
        this.ouid = ouid;
    }
}
