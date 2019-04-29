package com.system.admin.action;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.system.admin.service.AdminService;
import com.system.exception.file.FileException;
import com.system.file.entity.History;
import com.system.file.entity.OrderInfo;
import com.system.file.service.FileService;
//import com.system.info.dao.StudentCustom;
import com.system.login.dao.UserDao;
import com.system.login.entity.User;
import com.system.login.service.UserService;
import com.system.util.PagingVO;
import com.system.util.properties.PropertiesUtil;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 管理员Action
 *
 * @author wangn
 * @date 2017/5/23
 */
@Controller
public class AdminAction {
    /**
     * 科目批次状态名
     */


    /**
     *  @Resource(name = "studentServiceImpl")
     *     private StudentService studentService;*/
         private static final String O_STATE = "ostate";



    @Resource
    private FileService fileService;

    @Resource
    private AdminService adminService;

  //  @Resource
 //   private CollegeService collegeService;
    @Resource
    private UserService userService;


    /**
     * 后台入口方法
     * 管理员权限访问
     *
     * @param model 模型
     * @return jsp/admin.jsp
     */
    @RequestMapping("admin")
    @RequiresPermissions("admin")
    public String admin(Model model) {
        //下拉框数据
        model.addAttribute("orderInfoList", fileService.getOrderInfoEntityOfAll());
        //登录用户信息实体（User）
        model.addAttribute("user", SecurityUtils.getSubject().getPrincipal());
        return "jsp/admin.jsp";
    }

    /**
     * 根据科目名查找所有科目信息
     *
     * @param subject 科目名
     * @return 所有科目信息集合
     * @throws Exception Exception
     */
    @RequestMapping("getOnameBysubjectOfAll")
    public @ResponseBody
    List<OrderInfo> getOnameBysubjectOfAll(String subject) throws Exception {
        if (subject == null || "".equals(subject)) {
            throw new FileException("获取失败：参数错误");
        }
        return fileService.getOnameBysubjectOfAll(subject);
    }

    /**
     * app信息的获取，用echarts显示
     * @return
     */
    @RequestMapping("/getAllecharts")
    public void getAllecharts( HttpServletResponse response,int uid)throws Exception{
    JSONArray jsons = new JSONArray();
        List<History> list = fileService.getUserHistoryByUserId(uid);
    for(int j=0;j<list.size();j++){
        JSONObject jsonObject =new JSONObject();
        jsonObject.put("user",list.get(j));
        jsons.add(jsonObject);
    }
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(jsons);
    }

    /**
     * Get the Lastweek history
     * @param response
     * @param uid
     * @throws Exception
     */
    @RequestMapping("/getlastweek")
    public void getlastweek( HttpServletResponse response,int uid)throws Exception{
        JSONArray jsons = new JSONArray();
        List<History> list = fileService.getUserHistoryByWeek(uid);
        for(int j=0;j<list.size();j++){
            JSONObject jsonObject =new JSONObject();
            jsonObject.put("user",list.get(j));
            jsons.add(jsonObject);
        }
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(jsons);
    }

    /**
     * Last month
     * @param response
     * @param uid
     * @throws Exception
     */
    @RequestMapping("/getlastmonth")
    public void getlastmonth( HttpServletResponse response,int uid)throws Exception{
        JSONArray jsons = new JSONArray();
        List<History> list = fileService.getUserHistoryByMonth(uid);
        for(int j=0;j<list.size();j++){
            JSONObject jsonObject =new JSONObject();
            jsonObject.put("user",list.get(j));
            jsons.add(jsonObject);
        }
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(jsons);
    }
    /**
     * 后台入口方法
     * 管理员权限访问
     *
     * @param model 模型
     * @return jsp/subjectui.jsp
     */
    @RequestMapping("/subjectui")
    @RequiresPermissions("admin")
    public String subjectui(Model model,Integer page) throws Exception {
        //OrderInfo实体集合
        List<OrderInfo> list = null;
        //页码对象
        PagingVO pagingVO = new PagingVO();
        //设置总页数
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        pagingVO.setTotalCount(adminService.getCountOrder());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = adminService.getOrderInfoEntity(1);
        } else {
            pagingVO.setToPageNo(page);
            list = adminService.getOrderInfoEntity(page);
        }
        model.addAttribute("user", user);
        model.addAttribute("pagingVO", pagingVO);
        model.addAttribute("allOrderInfo", list);
//      model.addAttribute("allOrderInfo", adminService.getOrderInfoEntity(page));
        return "jsp/subjectui.jsp";
    }

    /**
     * 获取已上传文件列表方法
     * 管理员权限访问
     *
     * @param hoid    作业批次ID
     * @param model   模型
     * @param session HttpSession
     * @return jsp/downfileui.jsp
     * @throws Exception Exception
     */
    @RequestMapping("getFileList")
    @RequiresPermissions("admin")
    public String getFileList(Integer hoid, Model model, HttpSession session) throws Exception {
        if (hoid == null) {
            throw new FileException("参数错误：hoid为空！");
        }
        //在Session中存储用户当前查看的文件列表
        session.setAttribute("hoid", hoid);
        List<History> list = adminService.getAllUploadedByHoid(hoid);
        model.addAttribute("fileListByHoid", list);
        return "jsp/downfileui.jsp";
    }

    /**
     *
     * 下载所有已上传的文件
     * 该方法需要管理员权限
     *
     * @param response HttpServletResponse
     * @param session  HttpSession
     * @throws Exception Exception
     */
    @RequestMapping("downAllFile")
    @RequiresPermissions("admin")
    public void downAllFile(HttpServletResponse response, HttpSession session) throws Exception {
        //所有的已上传文件实体集合
        List<History> fileListByHoid = adminService.findFileListByHoid((Integer) session.getAttribute("hoid"));
        if (fileListByHoid == null) {
            throw new FileException("下载失败：未找到数据！");
        }
        OrderInfo orderInfo = fileService.getOrderInfoEntityByOID(fileListByHoid.get(0).getHoid());
        String zipfilename = orderInfo.getOsubject() + orderInfo.getOname();
        List<String> filesname = new ArrayList<>(fileListByHoid.size());
        for (History history : fileListByHoid) {
            filesname.add(history.getFilepath());
        }
        response.setHeader("Content-Disposition", "attachment;filename=" + new String((zipfilename + ".zip").getBytes(), StandardCharsets.ISO_8859_1));
        response.setContentType("application/octet-stream");
        ZipOutputStream zipOut = new ZipOutputStream(response.getOutputStream());
        for (String filename : filesname) {
            File file = new File(PropertiesUtil.getUpLoadFilePath() + filename);
            InputStream input = new FileInputStream(file);
            zipOut.putNextEntry(new ZipEntry(file.getName()));
            IOUtils.copy(input, zipOut);
            input.close();
        }
        zipOut.close();
    }
    @RequestMapping("addStudent")
    @RequiresPermissions("admin")
    public @ResponseBody
    Boolean addStudent(User user, String aa) throws Exception {
        if (user == null) {
            throw new FileException("添加失败：参数为空");
        }
        if (user.getUsername() == null || "".equals(user.getUsername())) {
            return false;
        }
        if (user.getName() == null) {
            return false;
        }
        boolean firstlogin = true;
        String password = user.getUsername();
        String headimg = aa;
        String name = user.getName();
        String percode = user.getPercode();
        String username = user.getUsername();
      //  String userid = user.getUserid();
     //   String uid = user.getName();

     //   user.setUid(userDao.getCountStudent()+1);
    //    user.setUid(UUID.randomUUID().toString().replace("-", ""));
        user.setFirstlogin(firstlogin);
        user.setPassword(password);
       // user.setHeadimg(headimg);
        user.setName(name);
        user.setPercode(percode);
        user.setUsername(username);
   //     user.setUserid(userid);
     // user.setOtime(new Date());
        userService.addStudent(user);
        return true;
    }

    @RequestMapping("delOrderinfoByOID")
    @RequiresPermissions("admin")
    public @ResponseBody
    Boolean delOrderinfoByOID(Integer oid) throws Exception {
        if (oid == null) {
            throw new FileException("删除失败：参数不正确");
        }
        adminService.delOrderInfosAndFilesByOID(oid);
        return true;
    }

    @RequestMapping("delStudentByUID")
    @RequiresPermissions("admin")
    public @ResponseBody
    Boolean delStudentByUID(Integer uid) throws Exception {
        if (uid == null) {
            throw new FileException("删除失败：参数不正确");
        }
        userService.delStudentByUID(uid);
        return true;
    }
    /**
     * 添加科目批次信息
     * 该方法需要管理员权限
     *
     * @param orderInfo 科目批次实体
     * @return 是否添加成功
     * @throws Exception Exception
     */
    @RequestMapping("addOrderInfo")
    @RequiresPermissions("admin")
    public @ResponseBody
    Boolean addOrderInfo(OrderInfo orderInfo) throws Exception {
        if (orderInfo == null) {
            throw new FileException("添加失败：参数为空");
        }
        if (orderInfo.getOsubject() == null || "".equals(orderInfo.getOsubject())) {
            return false;
        }
        if (orderInfo.getOname() == null) {
            return false;
        }
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        String Ouid= user.getName();
        orderInfo.setOuid(Ouid);
      //int oid = (orderInfo.getOname().hashCode()) + (orderInfo.getOsubject().hashCode());
     // orderInfo.setOid(oid);
        orderInfo.setOtime(new Date());
        adminService.addOrderInfo(orderInfo);
        return true;

    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }


    @RequestMapping("/mStudent")
    public String mStudent(Model model, Integer page) throws Exception {

        User user = (User) SecurityUtils.getSubject().getPrincipal();
        List<User> list = null;
        //页码对象
        PagingVO pagingVO = new PagingVO();
        //设置总页数
        model.addAttribute("user", user);
        pagingVO.setTotalCount(userService.getCountStudent());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = userService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = userService.findByPaging(page);
        }

        model.addAttribute("studentList", list);
        model.addAttribute("pagingVO", pagingVO);

        return "jsp/mStudent.jsp";

    }
    @RequestMapping("editStudent")
    public String editStudent(int uid,Model model) {
        User user = userService.getUserEntityByID(uid);
        model.addAttribute("user", user);
        return "jsp/editStudent.jsp";
    }

    @RequestMapping(value = "editStudent2", method = RequestMethod.POST)
    public String editStudent2(Model model,int uid,User user) throws Exception {

        // 条件判断 开始
        User u = userService.getUserEntityByID(uid);
        model.addAttribute("user", u);
        u.setUsername(user.getUsername());
        u.setName(user.getName());
        u.setPassword(user.getPassword());
        userService.upStudent(u);
        return "mStudent";
    }
/**
 * Update OrderName
 */
@RequestMapping(value="/updateName")
public String goUpdate(OrderInfo oi){
    User user = (User) SecurityUtils.getSubject().getPrincipal();
    String Ouid= user.getName();
    oi.setOuid(Ouid);   // System.out.println("id:"+at.getOd()+",type:"+at.getType());
    fileService.updateOn(oi);
    return "subjectui";
}
}
