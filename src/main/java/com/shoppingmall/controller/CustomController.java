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
@RequestMapping("/custom")
public class CustomController {

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
	 * Custom
	 */
	@RequestMapping(value = "/getCustom", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getCustom(HttpServletRequest request) throws UnsupportedEncodingException {
		Custom object = new Custom();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Custom> objectList = this.customService.selectList(object);
		List<Custom> objectListTotal = this.customService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getCustombyid", method = RequestMethod.POST)
	@ResponseBody
	public Custom getCustombyid(@RequestBody Custom object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Custom resCustom = this.customService.getObjectById(object.getCustomid());
		return resCustom;
	}

	@RequestMapping(value = "/updateCustom", method = RequestMethod.POST)
	@ResponseBody
	public Message updateCustom(@RequestBody Custom object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			List<Custom> list = this.customService.selectByCustomName(object);
			Custom custom = this.customService.getObjectById(object.getCustomid());
			custom.setPassword(SHA1.encode(object.getPassword()));
			custom.setStatus(object.getStatus());
			if (custom.getCustomname().equals(object.getCustomname())) {
				this.customService.update(custom);
			} else {
				if (list.size() > 0) {
					status = "fail";
					msg = "用户名重复";
				} else {
					custom.setCustomname(object.getCustomname());
					this.customService.update(custom);
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

	@RequestMapping(value = "/updateScore", method = RequestMethod.POST)
	@ResponseBody
	public Message updateScore(@RequestBody Custom object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {

			Custom custom = this.customService.getObjectById(object.getCustomid());

			custom.setScore(object.getScore());

			this.customService.update(custom);

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/importCustom", method = RequestMethod.POST)
	@ResponseBody
	public Message importCustom(@RequestParam("myfile") MultipartFile myFile) {
		String status = "success";
		String msg = "";
		try {
			// TODO Auto-generated method stub
			Workbook workbook = null;
			String fileName = myFile.getOriginalFilename();
			if (fileName.endsWith(XLS)) {
				// 2003
				workbook = new HSSFWorkbook(myFile.getInputStream());
			} else if (fileName.endsWith(XLSX)) {
				// 2007
				workbook = new XSSFWorkbook(myFile.getInputStream());
			} else {
				throw new Exception("文件不是Excel文件");
			}

			Sheet sheet = workbook.getSheet("Sheet1");
			int rows = sheet.getLastRowNum();
			if (rows == 0) {
				throw new Exception("请填写数据");
			}

			for (int i = 1; i <= rows + 1; i++) {
				Row row = sheet.getRow(i);
				if (row != null && !isRowEmpty(row) && !getCellValue(row.getCell(0)).equals("")) {
					Custom object = new Custom();
					String customname = getCellValue(row.getCell(0));
					object.setCustomname(customname);
					String mobile = getCellValue(row.getCell(1));
					String truename = getCellValue(row.getCell(2));
					String bankno = getCellValue(row.getCell(3));
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

					List<Custom> list = this.customService.selectByCustomName(object);

					if (list.size() <= 0) {
						object.setCustomid(UUID.randomUUID().toString().toLowerCase());
						object.setMobile(mobile);
						object.setTruename(truename);
						object.setBankno(bankno);
						object.setWritedate(sdf.format(new Date()));
						object.setPassword(SHA1.encode("11111"));
						object.setStatus("0"); // 客户状态 0 正常 1 冻结
						object.setScore(BigDecimal.valueOf(0));
						this.customService.insert(object);
					} else {
						Custom customfg = list.get(0);
						customfg.setMobile(mobile);
						customfg.setTruename(truename);
						customfg.setBankno(bankno);
						customfg.setWritedate(sdf.format(new Date()));
						this.customService.update(customfg);
					}
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

	@RequestMapping(value = "/importScore", method = RequestMethod.POST)
	@ResponseBody
	public Message importScore(@RequestParam("myfile") MultipartFile myFile) {
		String status = "success";
		String msg = "";
		try {
			// TODO Auto-generated method stub
			Workbook workbook = null;
			String fileName = myFile.getOriginalFilename();
			if (fileName.endsWith(XLS)) {
				// 2003
				workbook = new HSSFWorkbook(myFile.getInputStream());
			} else if (fileName.endsWith(XLSX)) {
				// 2007
				workbook = new XSSFWorkbook(myFile.getInputStream());
			} else {
				throw new Exception("文件不是Excel文件");
			}

			Sheet sheet = workbook.getSheet("Sheet1");
			int rows = sheet.getLastRowNum();
			if (rows == 0) {
				throw new Exception("请填写数据");
			}

			for (int i = 1; i <= rows + 1; i++) {
				Row row = sheet.getRow(i);
				if (row != null && !isRowEmpty(row) && !getCellValue(row.getCell(0)).equals("")) {
					Custom object = new Custom();
					String customname = getCellValue(row.getCell(0));
					object.setCustomname(customname);
					String scoreStr = getCellValue(row.getCell(1));
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					BigDecimal score;
					if (!scoreStr.equals("")) {
						score = new BigDecimal(scoreStr);
					} else {
						score = BigDecimal.valueOf(0);
					}

					List<Custom> list = this.customService.selectByCustomName(object);

					if (list.size() <= 0) {
						object.setCustomid(UUID.randomUUID().toString().toLowerCase());
						object.setWritedate(sdf.format(new Date()));
						object.setPassword(SHA1.encode("11111"));
						object.setStatus("0"); // 客户状态 0 正常 1 冻结
						object.setScore(score);
						this.customService.insert(object);
					} else {
						Custom customfg = list.get(0);
						BigDecimal scoreOrigin = customfg.getScore();
						customfg.setScore(scoreOrigin.add(score));
						this.customService.update(customfg);
					}
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

	@RequestMapping(value = "/deletebyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deletebyid(@RequestBody Custom object, HttpServletRequest request) {
		String status = "success";
		String msg = "";
		try {
			int num = this.customService.deletebyid(object.getCustomid());
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/deletecustombyids", method = RequestMethod.POST)
	@ResponseBody
	public Message deletecustombyids(@RequestParam("ids") String ids, HttpServletRequest request) {
		String status = "success";
		String msg = "";
		String[] idArray = ids.split(",");
		for (int i = 0; i < idArray.length; i++) {
			try {
				int num = this.customService.deletebyid(idArray[i]);
			} catch (Exception e) {
				status = "fail";
				msg = e.getMessage();
			}
		}

		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/deleteallcustom", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteallcustom(HttpServletRequest request) {
		String status = "success";
		String msg = "";

		try {
			int num = this.customService.deleteAll();
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}

		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	public static boolean isRowEmpty(Row row) {

		for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {

			Cell cell = row.getCell(c);

			if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK)

				return false;

		}

		return true;

	}

	public String getCellValue(Cell cell) {
		String value = "";
		if (cell != null) {
			// 以下是判断数据的类型
			switch (cell.getCellType()) {
			case HSSFCell.CELL_TYPE_NUMERIC:
				value = cell.getNumericCellValue() + "";
				if (HSSFDateUtil.isCellDateFormatted(cell)) {
					Date date = cell.getDateCellValue();
					if (date != null) {
						value = new SimpleDateFormat("yyyy-MM-dd").format(date);
					} else {
						value = "";
					}
				} else {
					value = new DecimalFormat("0").format(cell.getNumericCellValue());
				}
				break;
			case HSSFCell.CELL_TYPE_STRING:
				value = cell.getStringCellValue();
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				value = cell.getBooleanCellValue() + "";
				break;
			case HSSFCell.CELL_TYPE_FORMULA:
				value = cell.getCellFormula() + "";
				break;
			case HSSFCell.CELL_TYPE_BLANK:
				value = "";
				break;
			case HSSFCell.CELL_TYPE_ERROR:
				value = "非法字符";
				break;
			default:
				value = "未知类型";
				break;

			}
		}
		return value.trim();
	}

	/*
	 * Users
	 */

	@RequestMapping(value = "/customlogin", method = RequestMethod.POST)
	@ResponseBody
	public Message loginForward(@RequestBody Custom object, HttpSession session, HttpServletResponse response,
			HttpServletRequest request) throws IOException {
		Message message = new Message();
		String msg = "";
		String status = "success";
		String password = SHA1.encode(object.getPassword());
		List<Custom> resObjects = this.customService.selectByCustomName(object);
		if (resObjects.size() > 0) {
			if(resObjects.get(0).getStatus().equals("0")) {
				if (resObjects.get(0).getPassword().equals(password)) {
					status = "success";
					msg = "成功登录";
					session.setAttribute("custom", resObjects.get(0));
				} else {
					status = "fail";
					msg = "密码错误";
				}
			}
			else {
				status = "fail";
				msg = "账户冻结";
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
		session.removeAttribute("custom");
		Message message = new Message();
		String msg = "";
		String status = "success";
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

}
