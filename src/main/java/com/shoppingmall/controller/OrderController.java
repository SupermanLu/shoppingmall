package com.shoppingmall.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.LoggerFactory;
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
import com.shoppingmall.model.ProductWithBLOBs;
import com.shoppingmall.model.Score;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.CartService;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.CustomService;
import com.shoppingmall.service.FriendlinkService;
import com.shoppingmall.service.NoteService;
import com.shoppingmall.service.OrderService;
import com.shoppingmall.service.ProductService;
import com.shoppingmall.service.ScoreService;
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
	
	@Resource
	private ScoreService scoreService;
	
	/*
	 * Note
	 */
	@RequestMapping(value = "/getOrder", method = RequestMethod.GET)
	@ResponseBody
	public CommonList getOrder(HttpServletRequest request) throws UnsupportedEncodingException {
		Order object = new Order();
		object.setLimit(Integer.parseInt(request.getParameter("limit")));
		object.setOffset(Integer.parseInt(request.getParameter("offset")));
		object.setCustomname(request.getParameter("customname"));
		object.setSearchno(request.getParameter("searchno"));
		object.setBegintime(request.getParameter("begintime").equals("")?"1900-01-01 00:00:00":request.getParameter("begintime"));
		object.setEndtime(request.getParameter("endtime").equals("")?"2900-01-01 00:00:00":request.getParameter("endtime"));
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
			String customid=object.getCustomid();
			Custom custom=this.customService.getObjectById(customid);
			List<Cart> carts=this.cartService.selectByCid(customid);
			BigDecimal price=new BigDecimal(0);
			Boolean flag=true;
			String noStock="";
			for(Cart cart:carts) {
				ProductWithBLOBs p=this.productService.getObjectById(cart.getPid());
				if(p.getStock()<cart.getNum()) {
					flag=false;
					noStock+=p.getPname()+",";
				}
				price=price.add(p.getDiscountedprice().multiply(new BigDecimal(cart.getNum()))).add(p.getPostage());
			}
			int a = price.compareTo(custom.getScore());
			System.out.println(price);
			if(a==1) {
				status="fail";
				msg=custom.getCustomname()+"积分余额不足";
			}
			else {
				if(flag) {
					for(Cart cart:carts) {
						//插入订单表
						ProductWithBLOBs product=this.productService.getObjectById(cart.getPid());
						String oid=UUID.randomUUID().toString().toLowerCase();
						object.setOrderid(oid);
						object.setStatus("0");
						SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						object.setOrdertime(sdf.format(new Date()));
						object.setPaytime(sdf.format(new Date()));
						object.setProid(product.getProductid());
						object.setPname(product.getPname());
						object.setPreprice(product.getDiscountedprice());
						object.setNum(cart.getNum());
						object.setPostage(product.getPostage());
						this.orderService.insert(object);
						
						//更新用户积分
						custom.setScore(custom.getScore().subtract(price));
						this.customService.update(custom);
						
						//更新销量和库存
						if(product.getSales()==null) {
							product.setSales(cart.getNum());
						}
						else {
							product.setSales(product.getSales()+cart.getNum());
						}						
						if(product.getStock()==null) {
							product.setStock(0);
						}
						else {
							product.setStock(product.getStock()-cart.getNum());
						}
						this.productService.update(product);
						
						
						Score score=new Score();
						score.setScoreid(UUID.randomUUID().toString().toLowerCase());
						score.setCustomid(cart.getCid());
						score.setOid(oid);
						score.setScore(product.getDiscountedprice().multiply(new BigDecimal(cart.getNum())));
						score.setType("1");
						score.setOperatetime(sdf.format(new Date()));
						this.scoreService.insert(score);
						
						//删除购物车中记录
						this.cartService.deletebyid(cart.getCartid());
					}
					
				}else {
					status="fail";
					noStock=noStock.substring(0, noStock.length()-1);
					msg=noStock+"库存不足";
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
	
	@RequestMapping(value = "/selectListByCid", method = RequestMethod.POST)
	@ResponseBody
	public List<Order> selectListByCid(@RequestBody Order object, HttpServletRequest request) {
		return this.orderService.selectListByCid(object.getCustomid());
	}
	
	@RequestMapping(value = "/selectLastByCid", method = RequestMethod.POST)
	@ResponseBody
	public Order selectLastByCid(@RequestBody Order object, HttpServletRequest request) {
		Order order=new Order();
		List<Order> list=this.orderService.selectListByCid(object.getCustomid());
		if(list.size()>0) {
			order=list.get(0);
		}
		return order;
	}
	
	@RequestMapping(value = "/selectTotal", method = RequestMethod.POST)
	@ResponseBody
	public Map selectTotal(HttpServletRequest request) {
		List<Order> list=this.orderService.selectAll();
		BigDecimal total=new BigDecimal(0);
		for(Order order:list) {
			total=total.add(order.getPreprice().multiply(new BigDecimal(order.getNum()))).add(order.getPostage());
		}
		Map map=new HashMap();
		map.put("total", total);
		return map;
	}
	
	
	@RequestMapping("/export")
    public void export(HttpServletRequest request, HttpServletResponse response){
        //response.setContentType("octets/stream");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        String excelName = "商品订单列表"+sdf.format(new Date())+".xls";
        try {
        	response.setCharacterEncoding("UTF-8");
        	response.setContentType("application/ms-excel;charset=UTF-8"); 
 
    		excelName = URLEncoder.encode(excelName, "UTF-8");
    		response.addHeader("Content-Disposition", "attachment;filename=" + excelName);

            OutputStream out = response.getOutputStream();
            export(excelName ,out);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	
	
	 public void export(String excelName, OutputStream out) {
	        try {
	            // 第一步，创建一个webbook，对应一个Excel文件  
	            HSSFWorkbook wb = new HSSFWorkbook();
	            //生成一个表格  
	            HSSFSheet sheet = wb.createSheet(excelName); 
	            // 第三步，在sheet中添加表头第0行
	            HSSFRow row = sheet.createRow(0);
	            
	            // 第四步，创建单元格，并设置值表头 设置表头居中  
	            HSSFCellStyle style = wb.createCellStyle();  
	            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
	            HSSFCell cell = row.createCell(0);
	            cell.setCellStyle(style);
	            
	            List<Order> list=this.orderService.selectAll();
	            this.insertData(wb, sheet, row, list, out);
	        } catch (Exception e) {
	        	System.out.println(e.getMessage());
	        }
	    }
	    
	    /**
	     * 导入数据到表格中
	     * @param wb execl文件
	     * @param sheet 表格
	     * @param row 表格行
	     * @param record 要导出的数据
	     * @param out 输出流
	     */
	    private void insertData(HSSFWorkbook wb,HSSFSheet sheet,HSSFRow row,List<Order> record,
	            OutputStream out){
	        try {
	            row = sheet.createRow(1);
	            String[] title = new String[] {"订单号","买家用户名","商品","单价","数量","邮费","状态","支付时间"};
	            for(int i=0;i<title.length;i++){
	                row.createCell(i).setCellValue(title[i]);
	            }
	            for(int i=0;i<record.size();i++){
	                row = sheet.createRow(i+2);
	                Order data = record.get(i);
	                row.createCell(0).setCellValue(data.getOrderno());
	                row.createCell(1).setCellValue(data.getCustomname());
	                row.createCell(2).setCellValue(data.getPname());
	                row.createCell(3).setCellValue(data.getPreprice().toString());
	                row.createCell(4).setCellValue(data.getNum());
	                row.createCell(5).setCellValue(data.getPostage().toString());
	                row.createCell(6).setCellValue(data.getStatus().equals("0")?"已支付":"已发货");
	                row.createCell(7).setCellValue(data.getPaytime());
	            }
	            //合并单元格，前面2位代表开头结尾行，后面2位代表开头结尾列
//	            CellRangeAddress region = new CellRangeAddress(0,0,0,title.length-1);
//	            sheet.addMergedRegion(region);
	            wb.write(out);
	            out.flush();
	            out.close();
	            wb.close();
	        } catch (Exception e) {
	        	System.out.println(e.getMessage());
	        }
	    }

}
