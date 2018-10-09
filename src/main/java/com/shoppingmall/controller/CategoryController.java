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
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/category")
public class CategoryController {

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

	
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getCategory", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getCategory(HttpServletRequest request) throws UnsupportedEncodingException {
		Category object = new Category();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Category> objectList = this.categoryService.selectList(object);
		List<Category> objectListTotal = this.categoryService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getCategorybyid", method = RequestMethod.POST)
	@ResponseBody
	public Category getCategorybyid(@RequestBody Category object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Category resObject = this.categoryService.getObjectById(object.getCateid());
		return resObject;
	}

	@RequestMapping(value = "/deleteCategorybyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteCategorybyid(@RequestBody Category object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.categoryService.deletebyid(object.getCateid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateCategory", method = RequestMethod.POST)
	@ResponseBody
	public Message updateCategory(@RequestBody Category object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Category resObject=this.categoryService.getObjectById(object.getCateid());
			resObject.setCatename(object.getCatename());
			resObject.setBannerurl(object.getBannerurl());
			resObject.setParentcateid(object.getParentcateid());
			resObject.setIssy(object.getIssy());
			resObject.setOrdernum(object.getOrdernum());
			this.categoryService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addCategory", method = RequestMethod.POST)
	@ResponseBody
	public Message addCategory(@RequestBody Category object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setCateid(UUID.randomUUID().toString().toLowerCase());
			this.categoryService.insert(object);
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
	
	
	public List<Map> getOption(List<Map> maplist,String parentcateid,int i) {
		i++;
		List<Category> list=this.categoryService.selectOption(parentcateid);
	
		
		for(int j=0;j<list.size();j++) {
			Category item=list.get(j);
			Map map=new HashMap();
			map.put("text",item.getCatename());
			map.put("value",item.getCateid());
			map.put("level",i);
			maplist.add(map);
			maplist=getOption(maplist,item.getCateid(),i);
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
	
	
	@RequestMapping(value = "/getcategorybypid", method = RequestMethod.POST)
	@ResponseBody
	public List<Category> getcategorybypid(@RequestBody Category object,HttpServletRequest request)
			throws UnsupportedEncodingException {
		
		return this.categoryService.selectOption(object.getParentcateid());
	}
	

}
