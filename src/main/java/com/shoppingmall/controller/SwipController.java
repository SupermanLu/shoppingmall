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
import com.shoppingmall.model.Swip;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.SwipService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/swip")
public class SwipController {

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
	private SwipService swipService;
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getSwip", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getSwip(HttpServletRequest request) throws UnsupportedEncodingException {
		Swip object = new Swip();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Swip> objectList = this.swipService.selectList(object);
		List<Swip> objectListTotal = this.swipService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getSwipbyid", method = RequestMethod.POST)
	@ResponseBody
	public Swip getSwipbyid(@RequestBody Swip object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Swip resObject = this.swipService.getObjectById(object.getSwipid());
		return resObject;
	}

	@RequestMapping(value = "/deleteSwipbyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteSwipbyid(@RequestBody Swip object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.swipService.deletebyid(object.getSwipid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateSwip", method = RequestMethod.POST)
	@ResponseBody
	public Message updateSwip(@RequestBody Swip object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Swip resObject=this.swipService.getObjectById(object.getSwipid());
			resObject.setSwiplink(object.getSwiplink());
			resObject.setSwipimgurl(object.getSwipimgurl());
			resObject.setAddtime(sdf.format(new Date()));
			resObject.setOrdernum(object.getOrdernum());
			this.swipService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addSwip", method = RequestMethod.POST)
	@ResponseBody
	public Message addSwip(@RequestBody Swip object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			object.setSwipid(UUID.randomUUID().toString().toLowerCase());
			object.setAddtime(sdf.format(new Date()));
			this.swipService.insert(object);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
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
	
	
	@RequestMapping(value = "/getall", method = RequestMethod.POST)
	@ResponseBody
	public List<Swip> getall(HttpServletRequest request)
			throws UnsupportedEncodingException {
		
		return this.swipService.selectAll();
	}
	

}
