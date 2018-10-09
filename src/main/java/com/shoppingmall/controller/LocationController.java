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
import com.shoppingmall.model.Location;
import com.shoppingmall.model.Message;
import com.shoppingmall.model.Note;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.LocationService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/location")
public class LocationController {

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
	private LocationService locationService;
	
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getLocation", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getLocation(HttpServletRequest request) throws UnsupportedEncodingException {
		Location object = new Location();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Location> objectList = this.locationService.selectList(object);
		List<Location> objectListTotal = this.locationService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getLocationbyid", method = RequestMethod.POST)
	@ResponseBody
	public Location getLocationbyid(@RequestBody Location object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Location resObject = this.locationService.getObjectById(object.getLocationid());
		return resObject;
	}

	@RequestMapping(value = "/deleteLocationbyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteLocationbyid(@RequestBody Location object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.locationService.deletebyid(object.getLocationid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateLocation", method = RequestMethod.POST)
	@ResponseBody
	public Message updateLocation(@RequestBody Location object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Location resObject=this.locationService.getObjectById(object.getLocationid());
			resObject.setLocationname(object.getLocationname());
			resObject.setLocationno(object.getLocationno());
			this.locationService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addLocation", method = RequestMethod.POST)
	@ResponseBody
	public Message addLocation(@RequestBody Location object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setLocationid(UUID.randomUUID().toString().toLowerCase());
			this.locationService.insert(object);
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
