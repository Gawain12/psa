package com.system.login.action;

import com.system.exception.login.LoginException;
import com.system.login.entity.User;
import com.system.login.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 登陆
 *
 * @author wangn
 * @date 2017/5/19
 */
@Controller
public class Login {
    @Resource
    private UserService userService;

    /**
     * 用户登陆
     *
     * @param model   {@link Model}
     * @param request {@link HttpServletRequest}
     * @return jsp/login.jsp
     * @throws LoginException LoginException
     */
    @RequestMapping("login")
    public String userLogin(Model model, HttpServletRequest request) throws LoginException {
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        if (user != null ) {
            return "redirect:index.jsp";
        }
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
        if (exceptionClassName != null) {
            if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
                model.addAttribute("returninfo", "账号不存在");
            } else if (IncorrectCredentialsException.class.getName().equals(
                    exceptionClassName) || AuthenticationException.class.getName().equals(exceptionClassName)) {
                model.addAttribute("returninfo", "用户名/密码错误");
            } else {
                throw new LoginException(exceptionClassName);
            }
        }
        return "jsp/login.jsp";
    }
}
