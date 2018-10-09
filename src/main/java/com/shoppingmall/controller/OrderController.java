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
import com.shoppingmall.model.ProductWithBLOBs;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CartService;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.OrderService;
import com.shoppingmall.service.ProductService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/order")
public class OrderController {

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
	private OrderService orderService;
	
	@Resource
	private ProductService productService;

	@Resource
	private CartService cartService;
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getOrder", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getOrder(HttpServletRequest request) throws UnsupportedEncodingException {
		Order object = new Order();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setSearch(URLDecoder.decode(request.getParameter("search").toString(), "UTF-8"));
		List<Order> objectList = this.orderService.selectList(object);
		List<Order> objectListTotal = this.orderService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getOrderbyid", method = RequestMethod.POST)
	@ResponseBody
	public Order getOrderbyid(@RequestBody Order object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		Order resObject = this.orderService.getObjectById(object.getOrderid());
		return resObject;
	}

	@RequestMapping(value = "/deleteOrderbyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteOrderbyid(@RequestBody Order object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.orderService.deletebyid(object.getOrderid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateOrder", method = RequestMethod.POST)
	@ResponseBody
	public Message updateOrder(@RequestBody Order object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			Order resObject=this.orderService.getObjectById(object.getOrderid());
			resObject.setStatus(object.getStatus());
			if(object.getStatus().equals("1")) {
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				resObject.setDeliverytime(sdf.format(new Date()));
			}
			this.orderService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	@ResponseBody
	public Message addCategory(@RequestBody Order object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			BigDecimal total=object.getPreprice().multiply(new BigDecimal(object.getNum()));
			Custom custom=this.customService.getObjectById(object.getCustomid());
			ProductWithBLOBs product=this.productService.getObjectById(object.getProid());
			int a = total.compareTo(custom.getScore());
			int num=object.getNum();
			if(a==1) {
				status="fail";
				msg=custom.getCustomname()+"积分余额不足";
			}
			else {
				if(product.getStock()<num) {
					status="fail";
					msg=product.getPname()+"库存不足";
				}
				else {
					object.setOrderid(UUID.randomUUID().toString().toLowerCase());
					object.setStatus("0");
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					object.setOrdertime(sdf.format(new Date()));
					object.setPaytime(sdf.format(new Date()));
					this.orderService.insert(object);
					
					custom.setScore(custom.getScore().subtract(total));
					this.customService.update(custom);
					
					
					if(product.getSales()==null) {
						product.setSales(num);
					}
					else {
						product.setSales(product.getSales()+num);
					}
					
					
					if(product.getStock()==null) {
						product.setStock(0);
					}
					else {
						product.setStock(product.getStock()-num);
					}
					this.productService.update(product);
					
					Cart cart=new Cart();
					
					cart.setCid(object.getCustomid());
					
					cart.setPid(object.getProid());
					
					List<Cart> cartList=this.cartService.selectByCPid(cart);
					
					if(cartList.size()>0) {
						this.cartService.deletebyid(cartList.get(0).getCartid());
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
	
	

}
