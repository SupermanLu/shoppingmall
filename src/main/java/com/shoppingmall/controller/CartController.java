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
import com.shoppingmall.model.Product;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CartService;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.ProductService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/cart")
public class CartController {

	

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
	
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getCart")
	@ResponseBody
	public Map getCart(@RequestBody Cart object,HttpServletRequest request) throws UnsupportedEncodingException {
		Map map=new HashMap();
		List<Cart> list=this.cartService.selectByCid(object.getCid());
		
		List<Map> otherList=new ArrayList<Map>();
		int i=0;
		BigDecimal price=new BigDecimal(0);
		for(Cart cart:list) {
			Product p=this.productService.getObjectById(cart.getPid());
			if(p!=null&&p.getIssj().equals("1")) {	
				Map likeCart=new HashMap();
				likeCart.put("num", cart.getNum());
				likeCart.put("cartid", cart.getCartid());
				likeCart.put("pid", cart.getPid());
				likeCart.put("cid", cart.getCid());
				i+=cart.getNum();			
				likeCart.put("product", p);
				price=price.add(p.getDiscountedprice().multiply(new BigDecimal(cart.getNum()))).add(p.getPostage()==null?new BigDecimal(0):p.getPostage());
				otherList.add(likeCart);
			}
			else {
				this.cartService.deletebyid(cart.getCartid());
			}
		}
		map.put("cartlist", otherList);
		map.put("price", price);
		map.put("total", i);
		return map;
	}


	@RequestMapping(value = "/updateCart", method = RequestMethod.POST)
	@ResponseBody
	public Message updateCart(@RequestBody Cart object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Cart resObject=this.cartService.getObjectById(object.getCartid());
			resObject.setNum(object.getNum());
			if(object.getNum()==0) {
				this.cartService.deletebyid(object.getCartid());
			}
			this.cartService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addCart", method = RequestMethod.POST)
	@ResponseBody
	public Message addCart(@RequestBody Cart object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			List<Cart> list=this.cartService.selectByCPid(object);
			if(list.size()>0) {
				Cart cart=list.get(0);
				cart.setNum(cart.getNum()+object.getNum());
				this.cartService.update(cart);
			}
			else {
				object.setCartid(UUID.randomUUID().toString().toLowerCase());
				this.cartService.insert(object);
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
	
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteCart(@RequestBody Cart object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.cartService.deletebyid(object.getCartid());
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
