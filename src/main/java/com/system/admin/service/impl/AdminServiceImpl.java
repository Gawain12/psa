package com.system.admin.service.impl;

import com.system.admin.service.AdminService;
import com.system.file.dao.HistoryDao;
import com.system.file.dao.OrderInfoDao;
import com.system.file.entity.History;
import com.system.file.entity.OrderInfo;
import com.system.file.service.FileService;
import com.system.login.dao.UserDao;
import com.system.login.entity.User;
import com.system.login.service.UserService;
import com.system.util.PagingVO;
import com.system.util.properties.PropertiesUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 管理员服务接口实现
 *
 * @author wangn
 * @date 2017/5/24
 */
@Service
public class AdminServiceImpl implements AdminService {
    @Resource
    private HistoryDao historyDao;

    @Resource
    private OrderInfoDao orderInfoDao;

    @Resource
    private UserDao userDao;

    @Resource
    private UserService userService;

    @Resource
    private FileService fileService;


    @Override
    public List<History> findFileListByHoid(Integer hoid) {
        return historyDao.findFileListByHoid(hoid);
    }

    @Override
    public List<OrderInfo> getOrderInfoEntity(Integer toPageNo)throws Exception {
        PagingVO pagingVO = new PagingVO();
        pagingVO.setToPageNo(toPageNo);
        List<OrderInfo> list = orderInfoDao.getOrderInfoEntity(pagingVO);
        return list;
    }

    public int getCountOrder() throws Exception {
        //自定义查询对象
        return  this.orderInfoDao.getOrderCount();
    }
    @Override
    public void addOrderInfo(OrderInfo orderInfo){
        orderInfoDao.addOrderInfo(orderInfo);
    }

    @Override
    public void delOrderinfoByOID(Integer oid) {
        orderInfoDao.delOrderinfoByOID(oid);
    }

    @Override
    public void delStudentByUID(Integer uid) {
        userDao.delStudentByUID(uid);
    }

    @Override
    public List<History> getAllUploadedByHoid(int hoid) {
        //所有的已上传文件实体集合
        List<History> fileListByHoid = this.findFileListByHoid(hoid);
        //所有的学生实体集合
        List<User> users = userService.getUserList();
        //该集合用于存储所有用户上传实体信息，包括未上传文件的用户
        List<History> list = new ArrayList<>(users.size());
        for (User alluser : users) {
            //历史记录实体
            History history = new History();
            //将学号和姓名存入
            history.setOname(alluser.getName());
            history.setOsubject(alluser.getUsername());
            for (History historys : fileListByHoid) {
                User user = userService.getUserEntityByID(historys.getHuid());
                //如果数据库中已上传过文件的用户ID和用户列表中的ID相等
                if (user.getUid()==(alluser.getUid())) {
                    //将数据库中信息存入历史记录实体
                    history.setFilesize(historys.getFilesize());
                    history.setHid(historys.getHid());
                    history.setUptime(historys.getUptime());
                    history.setScore(historys.getScore());
                }
            }
            list.add(history);
        }
        return list;
    }

    @SuppressWarnings("ResultOfMethodCallIgnored")
    @Override
    public void delOrderInfosAndFilesByOID(int oid) throws Exception {
        List<History> historyList = this.findFileListByHoid(oid);
        String upLoadFilePath = PropertiesUtil.getUpLoadFilePath();
        for (History history : historyList) {
            File file = new File(upLoadFilePath + history.getFilepath());
            if (file.exists()) {
                file.delete();
            }
        }
        //删除历史记录
        fileService.delEntityByHOID(oid);
        //删除科目
        this.delOrderinfoByOID(oid);
    }
}
