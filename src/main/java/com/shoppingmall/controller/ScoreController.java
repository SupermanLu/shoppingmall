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
import com.shoppingmall.model.Cart;
import com.shoppingmall.model.Category;
import com.shoppingmall.model.CommonList;
import com.shoppingmall.model.Custom;
import com.shoppingmall.model.Friendlink;
import com.shoppingmall.model.Message;
import com.shoppingmall.model.Note;
import com.shoppingmall.model.Order;
import com.shoppingmall.model.Product;
import com.shoppingmall.model.Score;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CartService;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.ProductService;
import com.shoppingmall.service.ScoreService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/score")
public class ScoreController {

	

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
	private ProductService productService;

	@Resource
	private CartService cartService;
	
	@Resource
	private ScoreService scoreService;
	
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getScore")
	@ResponseBody
	public List<Score> getScore(@RequestBody Score object,HttpServletRequest request) throws UnsupportedEncodingException {
		
		return this.scoreService.selectByCid(object.getCustomid());
	}
	
	@RequestMapping(value = "/selectListByCid", method = RequestMethod.POST)
	@ResponseBody
	public List<Score> selectListByCid(@RequestBody Score object, HttpServletRequest request) {
		return this.scoreService.selectListByCid(object.getCustomid());
	}


}
