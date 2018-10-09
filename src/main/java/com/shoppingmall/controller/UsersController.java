package com.shoppingmall.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.shoppingmall.bizlogic.SHA1;
import com.shoppingmall.model.Users;
import com.shoppingmall.model.CommonList;
import com.shoppingmall.model.Custom;
import com.shoppingmall.model.Friendlink;
import com.shoppingmall.model.Message;
import com.shoppingmall.model.Note;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.UsersService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/users")
public class UsersController {

	private final static String XLS = "xls";

	private final static String XLSX = "xlsx";

	@Resource
	private CustomService customService;

	@Resource
	private UsersService usersService;

	@Resource
	private FriendlinkService friendlinkService;
	
	@Resource
	private NoteService noteService;

	/*
	 * Users
	 */

	@RequestMapping(value = "/adminlogin", method = RequestMethod.POST)
	@ResponseBody
	public Message loginForward(@RequestBody Users object, HttpSession session, HttpServletResponse response,
			HttpServletRequest request) throws IOException {
		Message message = new Message();
		String msg = "";
		String status = "success";
		String password = SHA1.encode(object.getPassword());
		List<Users> resUsers = this.usersService.selectByUserName(object);
		if (resUsers.size() > 0) {
			if(resUsers.get(0).getStatus().equals("1")) {
				if (resUsers.get(0).getPassword().equals(password)) {
					status = "success";
					msg = "成功登录";
					session.setAttribute("account", resUsers.get(0));
				} else {
					status = "fail";
					msg = "密码错误";
				}
			}
			else {
				status = "fail";
				msg = "用户失效";
			}
		} else {
			status = "fail";
			msg = "用户名不存在";
		}

		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping("/logout")
	@ResponseBody
	public Message logout(HttpSession session, HttpServletResponse response, HttpServletRequest request)
			throws IOException {
		session.removeAttribute("account");
		Message message = new Message();
		String msg = "";
		String status = "success";
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	

	@RequestMapping(value = "/getUsers", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getUsers(HttpServletRequest request) throws UnsupportedEncodingException {
		Users object = new Users();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Users> objectList = this.usersService.selectList(object);
		List<Users> objectListTotal = this.usersService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getUsersbyid", method = RequestMethod.POST)
	@ResponseBody
	public Users getUsersbyid(@RequestBody Users object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Users resObject = this.usersService.getObjectById(object.getUserid());
		return resObject;
	}

	@RequestMapping(value = "/deleteUsersbyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteUsersbyid(@RequestBody Users object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.usersService.deletebyid(object.getUserid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateUsers", method = RequestMethod.POST)
	@ResponseBody
	public Message updateUsers(@RequestBody Users object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Users resObject=this.usersService.getObjectById(object.getUserid());
			if(resObject.getUsername().equals(object.getUsername())) {
				resObject.setUsername(object.getUsername());
				resObject.setPassword(SHA1.encode(object.getPassword()));
				resObject.setStatus(object.getStatus());
				resObject.setRoleid(object.getRoleid());
				this.usersService.update(resObject);
			}
			else {
				List<Users> users=this.usersService.selectByUserName(object);
				if(users.size()>0) {
					status="fail";
					msg="用户名重复";
				}
				else {
					resObject.setUsername(object.getUsername());
					resObject.setPassword(SHA1.encode(object.getPassword()));
					resObject.setStatus(object.getStatus());
					resObject.setRoleid(object.getRoleid());
					this.usersService.update(resObject);
				}
			}
			
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addUsers", method = RequestMethod.POST)
	@ResponseBody
	public Message addUsers(@RequestBody Users object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setUserid(UUID.randomUUID().toString().toLowerCase());
			object.setPassword(SHA1.encode(object.getPassword()));
			this.usersService.insert(object);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	

}
