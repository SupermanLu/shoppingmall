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
import org.springframework.web.bind.annotation.PathVariable;
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
import com.shoppingmall.model.ProductWithBLOBs;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.ProductService;
import com.shoppingmall.service.UsersService;

@Controller
@RequestMapping("/product")
public class ProductController {

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
	private ProductService productService;
	
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getProduct", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getProduct(HttpServletRequest request) throws UnsupportedEncodingException {
		ProductWithBLOBs object = new ProductWithBLOBs();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setPname(request.getParameter("pname"));
		object.setSearchno(request.getParameter("searchno"));
		object.setBegintime(request.getParameter("begintime").equals("")?"1900-01-01 00:00:00":request.getParameter("begintime"));
		object.setEndtime(request.getParameter("endtime").equals("")?"2900-01-01 00:00:00":request.getParameter("endtime"));
		List<ProductWithBLOBs> objectList = this.productService.selectList(object);
		List<ProductWithBLOBs> objectListTotal = this.productService.selectCount(object);
		CommonList list = new CommonList();
		list.setRows(objectList);
		list.setTotal(objectListTotal.toArray().length);
		return list;
	}

	@RequestMapping(value = "/getProductbyid", method = RequestMethod.POST)
	@ResponseBody
	public ProductWithBLOBs getProductbyid(@RequestBody ProductWithBLOBs object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		ProductWithBLOBs resObject = this.productService.getObjectById(object.getProductid());
		return resObject;
	}

	@RequestMapping(value = "/deleteProductybyid", method = RequestMethod.POST)
	@ResponseBody
	public Message deleteProductbyid(@RequestBody ProductWithBLOBs object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			this.productService.deletebyid(object.getProductid());

		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}

	@RequestMapping(value = "/updateProduct", method = RequestMethod.POST)
	@ResponseBody
	public Message updateProduct(@RequestBody ProductWithBLOBs object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			ProductWithBLOBs resObject=this.productService.getObjectById(object.getProductid());
			resObject.setCid(object.getCid());
			resObject.setPname(object.getPname());
			resObject.setIssj(object.getIssj());
			resObject.setIstj(object.getIstj());
			resObject.setIsjptj(object.getIsjptj());
			resObject.setIsrxjp(object.getIsrxjp());
			resObject.setIsrm(object.getIsrm());
			resObject.setIsxp(object.getIsxp());
			resObject.setIsqg(object.getIsqg());
			resObject.setIsdlsy(object.getIsdlsy());
			resObject.setIstg(object.getIstg());
			resObject.setOriginalprice(object.getOriginalprice());
			resObject.setDiscountedprice(object.getDiscountedprice());
			resObject.setPostage(object.getPostage());
			resObject.setStock(object.getStock());
			resObject.setLogourl(object.getLogourl());
			resObject.setPimgurl(object.getPimgurl());
			resObject.setDescption(object.getDescption());
			resObject.setOrdernum(object.getOrdernum());
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			resObject.setUpdatetime(sdf.format(new Date()));
			this.productService.update(resObject);
		} catch (Exception e) {
			status = "fail";
			msg = e.getMessage();
		}
		Message message = new Message();
		message.setStatus(status);
		message.setMsg(msg);
		return message;
	}
	
	
	@RequestMapping(value = "/addProduct", method = RequestMethod.POST)
	@ResponseBody
	public Message addCategory(@RequestBody ProductWithBLOBs object, HttpServletRequest request)
			throws UnsupportedEncodingException {
		String status = "success";
		String msg = "";
		try {
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			object.setProductid(UUID.randomUUID().toString().toLowerCase());
			object.setUpdatetime(sdf.format(new Date()));
			if(object.getPostage()==null||object.getPostage().equals("")) {
				object.setPostage(new BigDecimal(0));
			}
			object.setSales(0);
			this.productService.insert(object);
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
	
	@RequestMapping(value = "getproductlist")  
	@ResponseBody
	public Map getproductlist(@RequestBody Category object,HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException{
		Map map=new HashMap();
		String cateid=object.getCateid();
		Category category=this.categoryService.getObjectById(cateid);
		
		List<ProductWithBLOBs> plist=this.productService.selectpbycid(cateid);
		List<Category> clist=this.categoryService.selectOption(cateid);
		List<Map> maplist=new ArrayList<Map>();
		for(Category citem:clist) {
			Map subMap=new HashMap();
			subMap.put("cateid",citem.getCateid());
			subMap.put("catename",citem.getCatename());
			subMap.put("bannerurl",citem.getBannerurl());
			List<ProductWithBLOBs> subplist=this.productService.selectpbycid(citem.getCateid());
			subMap.put("plist", subplist);
			maplist.add(subMap);
		}
		map.put("plist", plist);
		map.put("clist", maplist);
		map.put("category", category);
		return map;
	}
	
	@RequestMapping(value = "getHot")  
	@ResponseBody
	public List<ProductWithBLOBs> getHot(HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException{
		return this.productService.getHot();
	}
	
	@RequestMapping(value = "getTJ")  
	@ResponseBody
	public List<ProductWithBLOBs> getTJ(HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException{
		return this.productService.getTJ();
	}
	
	@RequestMapping(value = "getJPTJ")  
	@ResponseBody
	public List<ProductWithBLOBs> getJPTJ(HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException{
		return this.productService.getJPTJ();
	}
	
	@RequestMapping(value = "getRXJP")  
	@ResponseBody
	public List<ProductWithBLOBs> getRXJP(HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException{
		return this.productService.getRXJP();
	}
	
	@RequestMapping(value = "getXP")  
	@ResponseBody
	public List<ProductWithBLOBs> getXP(HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException{
		return this.productService.getXP();
	}
	
	@RequestMapping(value = "getQG")  
	@ResponseBody
	public List<ProductWithBLOBs> getQG(HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException{
		return this.productService.getQG();
	}
	
	@RequestMapping(value = "getTG")  
	@ResponseBody
	public List<ProductWithBLOBs> getTG(HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException{
		return this.productService.getTG();
	}
	
	
	
	

}
