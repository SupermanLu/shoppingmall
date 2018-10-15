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
import com.shoppingmall.model.Bbs;
import com.shoppingmall.model.CommonList;
import com.shoppingmall.model.Custom;
import com.shoppingmall.model.Friendlink;
import com.shoppingmall.model.Message;
import com.shoppingmall.model.Note;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.BbsService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/bbs")
public class BbsController {

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
	private BbsService bbsService;

	
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getBbs", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getBbs(HttpServletRequest request) throws UnsupportedEncodingException {
		Bbs object = new Bbs();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Bbs> objectList = this.bbsService.selectList(object);
		List<Bbs> objectListTotal = this.bbsService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getBbsbyid", method = RequestMethod.POST)
	@ResponseBody
	public Bbs getBbsbyid(@RequestBody Bbs object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Bbs resObject = this.bbsService.getObjectById(object.getBbsid());
		return resObject;
	}

	@RequestMapping(value = "/deleteBbsbyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteBbsbyid(@RequestBody Bbs object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.bbsService.deletebyid(object.getBbsid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateBbs", method = RequestMethod.POST)
	@ResponseBody
	public Message updateBbs(@RequestBody Bbs object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Bbs resObject=this.bbsService.getObjectById(object.getBbsid());
			resObject.setStatus(object.getStatus());
			this.bbsService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addBbs", method = RequestMethod.POST)
	@ResponseBody
	public Message addBbs(@RequestBody Bbs object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setBbsid(UUID.randomUUID().toString().toLowerCase());
			object.setStatus("0");
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			object.setBbstime(sdf.format(new Date()));
			this.bbsService.insert(object);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/deleteallbbs", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteallbbs(HttpServletRequest request) {
		String status = "success";
		String msg = "";

		try {
			int num = this.bbsService.deleteAll();
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
