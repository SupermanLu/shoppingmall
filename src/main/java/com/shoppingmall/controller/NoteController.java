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
@RequestMapping("/note")
public class NoteController {

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
	 * Note
	 */
	@RequestMapping(value = "/getNote", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getNote(HttpServletRequest request) throws UnsupportedEncodingException {
		Note object = new Note();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Note> objectList = this.noteService.selectList(object);
		List<Note> objectListTotal = this.noteService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getNotebyid", method = RequestMethod.POST)
	@ResponseBody
	public Note getNotebyid(@RequestBody Note object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Note resObject = this.noteService.getObjectById(object.getNoteid());
		return resObject;
	}

	@RequestMapping(value = "/deleteNotebyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteNotebyid(@RequestBody Note object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.noteService.deletebyid(object.getNoteid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateNote", method = RequestMethod.POST)
	@ResponseBody
	public Message updateNote(@RequestBody Note object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Note resObject=this.noteService.getObjectById(object.getNoteid());
			resObject.setTitle(object.getTitle());
			resObject.setContent(object.getContent());
			resObject.setIstop(object.getIstop());
			this.noteService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addNote", method = RequestMethod.POST)
	@ResponseBody
	public Message addNote(@RequestBody Note object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setNoteid(UUID.randomUUID().toString().toLowerCase());
			this.noteService.insert(object);
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
