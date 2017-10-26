package com.liu.Realm;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.liu.pojo.User;
import com.liu.service.impl.UserServiceImpl;

public class myrealm extends AuthorizingRealm{
	@Resource
	private UserServiceImpl userServiceImpl;

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		// TODO Auto-generated method stub
		return null;
	}

	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username=(String) token.getPrincipal();
		System.out.println("userid:"+username);
		User user=userServiceImpl.selectUserByUserId(username);
		if(user!=null)
		{
			SecurityUtils.getSubject().getSession().setAttribute("currentUser", user);
			AuthenticationInfo authenticationInfo=new SimpleAuthenticationInfo(user.getUserid(),user.getPassword(),"myRealm");
			return authenticationInfo;
		}
		return null;
	}



}
