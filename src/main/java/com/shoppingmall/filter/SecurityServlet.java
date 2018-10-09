package com.shoppingmall.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoppingmall.model.Users;

public class SecurityServlet extends HttpServlet implements Filter {
	private static final long serialVersionUID = 1L;

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		Users acount = (Users) request.getSession().getAttribute("account");
		String url = request.getRequestURI();
		System.out.println(url);
		if (url.indexOf("sys") < 0) {
			arg2.doFilter(arg0, arg1);
		} else {
			if (url.indexOf("login.jsp") < 0) {
				if (acount == null) {
					response.sendRedirect(request.getContextPath() + "/jsp/sys/login.jsp");
				} else {
					arg2.doFilter(arg0, arg1);
				}
			} else {
				if (acount == null) {
					arg2.doFilter(arg0, arg1);
				} else {
					response.sendRedirect(request.getContextPath() + "/jsp/sys/master.jsp");
				}
			}
		}

		// css,js,png不在filter里面
		// if (url.contains(".css") || url.contains(".js") || url.contains(".png")) {
		// arg2.doFilter(arg0, arg1);
		// }

	}

	public void init(FilterConfig arg0) throws ServletException {
	}

}
