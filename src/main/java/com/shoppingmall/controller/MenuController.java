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
import com.shoppingmall.model.Menu;
import com.shoppingmall.model.Message;
import com.shoppingmall.model.Note;
import com.shoppingmall.model.Role;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.MenuService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.RoleService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/menu")
public class MenuController {

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
	private MenuService menuService;

	@Resource
	private RoleService roleService;

	/*
	 * Note
	 */
	@RequestMapping(value = "/getMenu", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getMenu(HttpServletRequest request) throws UnsupportedEncodingException {
		Menu object = new Menu();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Menu> objectList = this.menuService.selectList(object);
		List<Menu> objectListTotal = this.menuService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getMenubyid", method = RequestMethod.POST)
	@ResponseBody
	public Menu getMenubyid(@RequestBody Menu object, HttpServletRequest request) throws UnsupportedEncodingException {
		Menu resObject = this.menuService.getObjectById(object.getMenuid());
		return resObject;
	}

	@RequestMapping(value = "/deleteMenubyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteMenubyid(@RequestBody Menu object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.menuService.deletebyid(object.getMenuid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateMenu", method = RequestMethod.POST)
	@ResponseBody
	public Message updateMenu(@RequestBody Menu object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Menu resObject = this.menuService.getObjectById(object.getMenuid());
			resObject.setMenuname(object.getMenuname());
			resObject.setMenubs(object.getMenubs());
			resObject.setParentmenuid(object.getParentmenuid());
			resObject.setDescription(object.getDescription());
			resObject.setOrdernum(object.getOrdernum());
			this.menuService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/addMenu", method = RequestMethod.POST)
	@ResponseBody
	public Message addMenu(@RequestBody Menu object, HttpServletRequest request) throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			object.setMenuid(UUID.randomUUID().toString().toLowerCase());
			this.menuService.insert(object);
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
	public List<Map> selectOption(HttpServletRequest request) throws UnsupportedEncodingException {
		List<Map> mapList = new ArrayList<Map>();
		try {
			mapList = getOption(mapList, "", 0);
		} catch (Exception e) {

		}
		return mapList;
	}

	@RequestMapping(value = "/selectOptionList", method = RequestMethod.POST)
	@ResponseBody
	public List<Map> selectOptionList(@RequestBody Map<String, String> map, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String roleid = map.get("roleid");
		List<Map> mapList = new ArrayList<Map>();
		Role role = this.roleService.getObjectById(roleid);
		String menuid = role.getMenuid();
		if (role.getStatus().equals("1")) {
			try {
				if (roleid.equals("b8efacbb-7d43-4da5-9f48-9a75d8c68d30")) {
					mapList = getOptionList(mapList, "", 0);
				} else {
					
					// List<String> menulist=new ArrayList();
					// if(!menuid.equals("")) {
					// String[] strs=menuid.split(",");
					// for(String str:strs) {
					// menulist.add(str);
					// }
					//
					// mapList=getOptionListIn(menulist,mapList,"",0);
					// }
					mapList = getOptionList(mapList, "", 0);
					for (int i = 0; i < mapList.size(); i++) {
						Map mapItem = mapList.get(i);
						if (menuid.indexOf(mapItem.get("value").toString()) == -1) {
							mapList.remove(mapItem);
						}
						List<Map> subList = (List<Map>) (mapItem.get("list"));
						for (int j = 0; j < subList.size(); j++) {
							Map subItem = subList.get(j);
							if (menuid.indexOf(subItem.get("value").toString()) == -1) {
								subList.remove(subItem);
							}
						}
					}
				}
			} catch (Exception e) {

			}
		}

		return mapList;
	}

	public List<Map> getOption(List<Map> maplist, String parentcateid, int i) {
		i++;
		List<Menu> list = this.menuService.selectOption(parentcateid);

		for (int j = 0; j < list.size(); j++) {
			Menu item = list.get(j);
			Map map = new HashMap();
			map.put("text", item.getMenuname());
			map.put("value", item.getMenuid());
			map.put("url", item.getDescription());
			map.put("level", i);
			maplist.add(map);
			maplist = getOption(maplist, item.getMenuid(), i);
		}

		return maplist;
	}

	public List<Map> getOptionList(List<Map> maplist, String parentcateid, int i) {
		i++;
		List<Menu> list = this.menuService.selectOption(parentcateid);

		for (int j = 0; j < list.size(); j++) {
			Menu item = list.get(j);
			Map map = new HashMap();
			map.put("text", item.getMenuname());
			map.put("value", item.getMenuid());
			map.put("url", item.getDescription());
			map.put("level", i);

			List<Map> optionlist = getOptionList2(item.getMenuid(), i);
			map.put("list", optionlist);
			maplist.add(map);
		}

		return maplist;
	}

	public List<Map> getOptionListIn(List<String> menulist, List<Map> maplist, String parentcateid, int i) {
		i++;
		List<Menu> list = this.menuService.selectOptionIn(parentcateid, menulist);

		for (int j = 0; j < list.size(); j++) {
			Menu item = list.get(j);
			Map map = new HashMap();
			map.put("text", item.getMenuname());
			map.put("value", item.getMenuid());
			map.put("url", item.getDescription());
			map.put("level", i);

			List<Map> optionlist = getOptionListIn2(menulist, item.getMenuid(), i);
			map.put("list", optionlist);
			maplist.add(map);
		}

		return maplist;
	}

	public List<Map> getOptionList2(String parentid, int i) {
		List<Map> optionlist = new ArrayList<Map>();

		List<Menu> list = this.menuService.selectOption(parentid);

		for (int j = 0; j < list.size(); j++) {
			Menu item = list.get(j);
			Map map = new HashMap();
			map.put("text", item.getMenuname());
			map.put("value", item.getMenuid());
			map.put("url", item.getDescription());
			optionlist.add(map);
		}
		return optionlist;
	}

	public List<Map> getOptionListIn2(List<String> menulist, String parentid, int i) {
		List<Map> optionlist = new ArrayList<Map>();

		List<Menu> list = this.menuService.selectOptionIn(parentid, menulist);

		for (int j = 0; j < list.size(); j++) {
			Menu item = list.get(j);
			Map map = new HashMap();
			map.put("text", item.getMenuname());
			map.put("value", item.getMenuid());
			map.put("url", item.getDescription());
			optionlist.add(map);
		}
		return optionlist;
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public Message importScore(@RequestParam("myfile") MultipartFile myFile, HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("/");
		String status = "success";
		String msg = "";
		String fileName = myFile.getOriginalFilename();
		String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		String guid = UUID.randomUUID().toString();
		try {
			System.out.println("OriginalFilename: " + myFile.getOriginalFilename());
			System.out.println("InputStream: " + myFile.getInputStream());

			if (!myFile.isEmpty()) {
				myFile.transferTo(new File(path + "uploads\\" + guid + "." + suffix));
			}

			msg = "uploads/" + guid + "." + suffix;

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
