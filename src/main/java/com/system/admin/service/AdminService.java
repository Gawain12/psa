package com.system.admin.service;

import com.system.file.entity.History;
import com.system.file.entity.OrderInfo;
import com.system.login.entity.User;

import java.util.List;
import java.util.Map;

/**
 * 管理员服务接口
 *
 * @author wangn
 * @date 2017/5/24
 */
public interface AdminService {
    /**
     * 获取所有的已上传文件实体集合
     *
     * @param hoid {@link History }实体的ID
     * @return 上传历史集合
     * @see History
     */
    List<History> findFileListByHoid(Integer hoid);

    /**
     * 获取所有科目批次信息
     *
     * @return 所有科目批次信息集合
     */
    List<OrderInfo> getOrderInfoEntity(Integer toPageNo) throws Exception;

    /**
     * 更新状态
     *
     * @param map map
     */
    void changeKeyByOID(Map<String, Object> map);

    /**
     * 添加科目批次
     *
     * @param orderInfo 科目批次实体
     * @param user
     */
    void addOrderInfo(OrderInfo orderInfo, User user) throws Exception;

    /**
     * 删除科目批次
     *
     * @param oid 科目批次ID
     */
    void delOrderinfoByOID(Integer oid);

    /**
     * 根据作业ID查找所有的已上传文件实体集合
     *
     * @param hoid 作业ID
     * @return 上传历史集合
     */
    List<History> getAllUploadedByHoid(int hoid);

    /**
     * 根据批次ID删除批次
     *
     * @param oid 批次ID
     * @throws Exception Exception
     */
    void delOrderInfosAndFilesByOID(int oid) throws Exception;
    /**
     * 获得任务总数
     */
     int getCountOrder() throws Exception;
     /**
      * 删除学生
      */
     void delStudentByUID(Integer oid);
}
