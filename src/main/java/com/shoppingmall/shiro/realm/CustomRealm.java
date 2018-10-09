package com.shoppingmall.shiro.realm;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

public class CustomRealm extends AuthorizingRealm{
	
	Map<String,String> userMap=new HashMap<String, String>(16);
	{
		userMap.put("Mark", "123456");
		
		super.setName("customRealm");
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		
		//1.从主体传过来的认证信息中，获得用户名
		String userName=(String)token.getPrincipal();
		
		//2.通过用户名到数据库中获取凭证
		String password=getPasswordByUserName(userName);
		if(password==null) {
			return null;
		}
		
		SimpleAuthenticationInfo authenticationInfo=new SimpleAuthenticationInfo("Mark","123456","customRealm");
		
		// TODO Auto-generated method stub
		return authenticationInfo;
	}
	
	/*
	 * 模拟数据库查询
	 */
	private String getPasswordByUserName(String userName) {
		return userMap.get(userName);
	}

}
