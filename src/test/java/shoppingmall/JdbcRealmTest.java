package shoppingmall;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.realm.text.IniRealm;
import org.apache.shiro.subject.Subject;
import org.junit.Test;

import com.alibaba.druid.pool.DruidDataSource;

public class JdbcRealmTest {
	
	DruidDataSource dataSource=new DruidDataSource();
	
	{
		dataSource.setUrl("jdbc:mysql://localhost:3306/shoppingmall");
		dataSource.setUsername("root");
		dataSource.setPassword("11111");
	}
	
	@Test
	public void testAuthentication() {	
		
		JdbcRealm jdbcRealm=new JdbcRealm();
		
		jdbcRealm.setDataSource(dataSource);
		//默认为false，只有设置为true才能查询权限
		jdbcRealm.setPermissionsLookupEnabled(true);
		
		
		String sql="select password from users where username=?";
		jdbcRealm.setAuthenticationQuery(sql);
		
		//1.构建SecurityManage环境
		DefaultSecurityManager defaultSecurityManager=new DefaultSecurityManager();
		defaultSecurityManager.setRealm(jdbcRealm);
		
		HashedCredentialsMatcher matcher=new HashedCredentialsMatcher();
		matcher.setHashAlgorithmName("sha1");
		matcher.setHashIterations(1);
		jdbcRealm.setCredentialsMatcher(matcher);
		
		//2.主体提交认证请求
		SecurityUtils.setSecurityManager(defaultSecurityManager);
		Subject subject=SecurityUtils.getSubject();
		
		UsernamePasswordToken token=new UsernamePasswordToken("admin","11111");
		System.out.println(token);
		subject.login(token);
		
		System.out.println("isAuthenticated:"+subject.isAuthenticated());
		
		//subject.checkRole("admin");
		
		//subject.checkPermission("user:delete");
		
		subject.logout();
		
		System.out.println("isAuthenticated:"+subject.isAuthenticated());
	}
}
