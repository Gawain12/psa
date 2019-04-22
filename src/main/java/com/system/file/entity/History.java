package com.system.file.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 上传历史记录
 *
 * @author wangn
 * @date 2017/5/22
 */
public class History implements Serializable {
    /**
     * 唯一ID
     */
    private int hid;
    /**
     * 对应的用户ID
     */
    private int huid;
    /**
     * 科目ID
     */
    private Integer hoid;
    /**
     * 上传的文件MIME类型
     */
    private String type;
    /**
     * 文件名
     */
    private String filepath;
    /**
     * 上传时间
     */
    private Date uptime;
    /**
     * 文件大小
     */
    private Double filesize;
    /**
     * 作业名
     */
    private String osubject;
    /**
     * 科目名
     */
    private String oname;

    private String score;

    private String osid;

    public String getOsubject() {
        return osubject;
    }

    public void setOsubject(String osubject) {
        this.osubject = osubject;
    }

    public String getOname() {
        return oname;
    }

    public void setOname(String oname) {
        this.oname = oname;
    }

    public int getHid() {
        return hid;
    }

    public void setHid(int hid) {
        this.hid = hid;
    }

    public int getHuid() {
        return huid;
    }

    public void setHuid(int huid) {
        this.huid = huid;
    }

    public Integer getHoid() {
        return hoid;
    }

    public void setHoid(Integer hoid) {
        this.hoid = hoid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFilepath() {
        return filepath;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath;
    }

    public Date getUptime() {
        return uptime;
    }

    public void setUptime(Date uptime) {
        this.uptime = uptime;
    }

    public Double getFilesize() {
        return filesize;
    }

    public void setFilesize(Double filesize) {
        this.filesize = filesize;
    }

    public String getScore() { return score; }

    public void setScore(String score) { this.score = score; }

    public String getOsid() {
        return osid;
    }

    public void setOsid(String osid) {
        this.osid = osid;
    }
}

