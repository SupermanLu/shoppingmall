package com.shoppingmall.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import com.shoppingmall.model.CommonList;
import com.shoppingmall.model.Custom;
import com.shoppingmall.model.Friendlink;
import com.shoppingmall.model.Message;
import com.shoppingmall.model.Note;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/friendlink")
public class FriendlinkController {

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
	 * FriendLink
	 */
	@RequestMapping(value = "/getFriendlink", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getFriendlink(HttpServletRequest request) throws UnsupportedEncodingException {
		Friendlink object = new Friendlink();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Friendlink> objectList = this.friendlinkService.selectList(object);
		List<Friendlink> objectListTotal = this.friendlinkService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getFriendlinkbyid", method = RequestMethod.POST)
	@ResponseBody
	public Friendlink getFriendlinkbyid(@RequestBody Friendlink object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Friendlink resObject = this.friendlinkService.getObjectById(object.getLinkid());
		return resObject;
	}

	@RequestMapping(value = "/deleteFriendlinkbyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteFriendlinkbyid(@RequestBody Friendlink object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.friendlinkService.deletebyid(object.getLinkid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateFriendlink", method = RequestMethod.POST)
	@ResponseBody
	public Message updateFriendlink(@RequestBody Friendlink object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Friendlink resObject=this.friendlinkService.getObjectById(object.getLinkid());
			resObject.setLinkname(object.getLinkname());
			resObject.setLinkurl(object.getLinkurl());
			resObject.setOrdernum(object.getOrdernum());
			this.friendlinkService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/getall", method = RequestMethod.POST)
	@ResponseBody
	public List<Friendlink> getall(HttpServletRequest request)
			throws UnsupportedEncodingException {
		
		return this.friendlinkService.selectAll();
	}
	
	@RequestMapping(value = "/addFriendlink", method = RequestMethod.POST)
	@ResponseBody
	public Message addFriendlink(@RequestBody Friendlink object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setLinkid(UUID.randomUUID().toString().toLowerCase());
			this.friendlinkService.insert(object);
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
