package shoppingmall;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.realm.text.IniRealm;
import org.apache.shiro.subject.Subject;
import org.junit.Test;

import com.shoppingmall.shiro.realm.CustomRealm;

public class CustomRealmTest {
	@Test
	public void testAuthentication() {	
		CustomRealm customRealm=new CustomRealm();
		
		//1.����SecurityManage����
		DefaultSecurityManager defaultSecurityManager=new DefaultSecurityManager();
		defaultSecurityManager.setRealm(customRealm);
		
		//2.�����ύ��֤����
		SecurityUtils.setSecurityManager(defaultSecurityManager);
		Subject subject=SecurityUtils.getSubject();
		
		UsernamePasswordToken token=new UsernamePasswordToken("Mark","123456");
		System.out.println(token);
		subject.login(token);
		
		System.out.println("isAuthenticated:"+subject.isAuthenticated());
		
		
		subject.logout();
		
		System.out.println("isAuthenticated:"+subject.isAuthenticated());
	}
}
