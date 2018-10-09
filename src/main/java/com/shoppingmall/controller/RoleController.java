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
import com.shoppingmall.model.Category;
import com.shoppingmall.model.CommonList;
import com.shoppingmall.model.Custom;
import com.shoppingmall.model.Friendlink;
import com.shoppingmall.model.Message;
import com.shoppingmall.model.Note;
import com.shoppingmall.model.Role;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.RoleService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/role")
public class RoleController {

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
	
	@Resource
	private CategoryService categoryService;

	@Resource
	private RoleService roleService;
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getRole", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getRole(HttpServletRequest request) throws UnsupportedEncodingException {
		Role object = new Role();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Role> objectList = this.roleService.selectList(object);
		List<Role> objectListTotal = this.roleService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getRolebyid", method = RequestMethod.POST)
	@ResponseBody
	public Role getRolebyid(@RequestBody Role object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Role resObject = this.roleService.getObjectById(object.getRoleid());
		return resObject;
	}

	@RequestMapping(value = "/deleteRolebyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteRolebyid(@RequestBody Role object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.roleService.deletebyid(object.getRoleid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateRole", method = RequestMethod.POST)
	@ResponseBody
	public Message updateRole(@RequestBody Role object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Role resObject=this.roleService.getObjectById(object.getRoleid());
			resObject.setRolename(object.getRolename());
			resObject.setDescription(object.getDescription());
			resObject.setMenuid(object.getMenuid());
			resObject.setStatus(object.getStatus());
			this.roleService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addRole", method = RequestMethod.POST)
	@ResponseBody
	public Message addRole(@RequestBody Role object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setRoleid(UUID.randomUUID().toString().toLowerCase());
			this.roleService.insert(object);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	@RequestMapping(value = "/getRoleOption", method = RequestMethod.POST)
	@ResponseBody
	public List<Role> getRoleOption(HttpServletRequest request)
			throws UnsupportedEncodingException {
		
		return this.roleService.selectAll();
	}
	
	
	
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public Message importScore(@RequestParam("myfile") MultipartFile myFile,HttpServletRequest request) {
		String path=request.getSession().getServletContext().getRealPath("/");
		String status = "success";
		String msg = "";
		String fileName = myFile.getOriginalFilename();
	    String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
	    String guid=UUID.randomUUID().toString();
		try {
			System.out.println("OriginalFilename: " + myFile.getOriginalFilename());
			System.out.println("InputStream: " + myFile.getInputStream());

			if(!myFile.isEmpty()){
				myFile.transferTo(new File(path+"uploads\\"+guid+"."+suffix));
			}
			
			msg="uploads/"+guid+"."+suffix;
		
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
