package com.system.login.service.impl;

import com.system.login.dao.UserDao;
import com.system.login.entity.User;
import com.system.login.service.UserService;
import com.system.util.PagingVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 用户服务实现类
 *
 * @author wangn
 * @date 2017/5/19
 */
@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    @Override
    public String getPasswd(String username) {
        return userDao.getPasswd(username);
    }

    @Override
    public String getPasswdById(int uid) {
        return userDao.getPasswdById(uid);
    }

    @Override
    public boolean isFirstLogin(int uid) {
        return userDao.isFirstLogin(uid);
    }

    @Override
    public User getUserEntity(String username) {
        return userDao.getUserEntity(username);
    }

    @Override
    public void setUserPasswd(Map<String, Object> map) {
        userDao.setUserPasswd(map);
    }

    @Override
    public void setFirstLogin(Map<String, Object> firstLogin) {
        userDao.setFirstLogin(firstLogin);
    }

    @Override
    public User getUserEntityByID(int uid) {
        return userDao.getUserEntityByID(uid);
    }

    @Override
    public List<User> getUserList() {
        return userDao.getUserList();
    }

    @Override
    public User getUserEntityByHid(int hid) {
        return userDao.getUserEntityByHid(hid);
    }

    @Override
    public void upStudent(User user){userDao.upStudent(user);}

    @Override
    public void delStudentByUID(Integer uid) {
        userDao.delStudentByUID(uid);
    }

    @Override
    public void addStudent(User user) throws Exception {
   //     user.setUid(UUID.randomUUID().toString().replace("-", ""));
        user.setUid(getCountStudent()+1);
        userDao.addStudent(user);
    }

    public  List<User> findByPaging(Integer toPageNo) throws Exception {
        PagingVO pagingVO = new PagingVO();
        pagingVO.setToPageNo(toPageNo);
        List<User> list = userDao.findByPaging(pagingVO);
        return list;
    }
    public int getCountStudent() throws Exception {
        //自定义查询对象
        return  this.userDao.getCount();
    }


}
