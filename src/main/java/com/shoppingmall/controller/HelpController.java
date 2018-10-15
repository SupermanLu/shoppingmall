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
import com.shoppingmall.model.Help;
import com.shoppingmall.model.CommonList;
import com.shoppingmall.model.Custom;
import com.shoppingmall.model.Friendlink;
import com.shoppingmall.model.Message;
import com.shoppingmall.model.Note;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.HelpService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/help")
public class HelpController {

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
	private HelpService helpService;

	
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getHelp", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getHelp(HttpServletRequest request) throws UnsupportedEncodingException {
		Help object = new Help();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Help> objectList = this.helpService.selectList(object);
		List<Help> objectListTotal = this.helpService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getHelpbyid", method = RequestMethod.POST)
	@ResponseBody
	public Help getHelpbyid(@RequestBody Help object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Help resObject = this.helpService.getObjectById(object.getHelpid());
		return resObject;
	}

	@RequestMapping(value = "/deleteHelpbyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteHelpbyid(@RequestBody Help object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.helpService.deletebyid(object.getHelpid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateHelp", method = RequestMethod.POST)
	@ResponseBody
	public Message updateHelp(@RequestBody Help object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Help resObject=this.helpService.getObjectById(object.getHelpid());
			resObject.setHelpname(object.getHelpname());
			resObject.setHelpcontent(object.getHelpcontent());
			resObject.setHelppid(object.getHelppid());
			this.helpService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addHelp", method = RequestMethod.POST)
	@ResponseBody
	public Message addHelp(@RequestBody Help object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setHelpid(UUID.randomUUID().toString().toLowerCase());
			this.helpService.insert(object);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	@RequestMapping(value = "/selectOption", method = RequestMethod.POST)
	@ResponseBody
	public List<Map> selectOption(HttpServletRequest request)
			throws UnsupportedEncodingException {
		List<Map> mapList=new ArrayList<Map>();
		try {			
			mapList=getOption(mapList,"",0);
		} catch (Exception e) {
			
		}
		return mapList;
	}
	
	@RequestMapping(value = "/selectOptionList", method = RequestMethod.POST)
	@ResponseBody
	public List<Map> selectOptionList(HttpServletRequest request)
			throws UnsupportedEncodingException {
		List<Map> mapList=new ArrayList<Map>();
		try {			
			mapList=getOptionList(mapList,"");
		} catch (Exception e) {
			
		}
		return mapList;
	}
	
	public List<Map> getOptionList(List<Map> maplist,String parentcateid) {

		List<Help> list=this.helpService.selectOption(parentcateid);
	
		
		for(int j=0;j<list.size();j++) {
			Help item=list.get(j);
			Map map=new HashMap();
			map.put("text",item.getHelpname());
			map.put("value",item.getHelpid());
			map.put("helplist", this.helpService.selectOption(item.getHelpid()));
			maplist.add(map);
		}
		
		return maplist;
	}
	
	
	public List<Map> getOption(List<Map> maplist,String parentcateid,int i) {
		i++;
		List<Help> list=this.helpService.selectOption(parentcateid);
	
		
		for(int j=0;j<list.size();j++) {
			Help item=list.get(j);
			Map map=new HashMap();
			map.put("text",item.getHelpname());
			map.put("value",item.getHelpid());
			map.put("level",i);
			maplist.add(map);
			maplist=getOption(maplist,item.getHelpid(),i);
		}
		
		return maplist;
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
	
	
	@RequestMapping(value = "/getHelpbypid", method = RequestMethod.POST)
	@ResponseBody
	public List<Help> getHelpbypid(@RequestBody Help object,HttpServletRequest request)
			throws UnsupportedEncodingException {
		
		return this.helpService.selectOption(object.getHelppid());
	}
	

}
