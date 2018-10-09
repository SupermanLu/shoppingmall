<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle.jsp"%>
<body>
	<%@ include file="../common/head.jsp"%>

	<!--Body-->
	<div class="all_body_container">

		<div class="page_container" id="pagecontrainer">
		<script id="pagetemplate" type="text/x-tpl">
			<div class="container">
				<div class="catalog-list">
					<div class="products">
						<div class="category-header read-more">
							<div class="inner">
								<div class="category-title"
									style="background-image: url({{category.bannerurl}})">
									<div class="table_cell">
										<h1>
											{{category.catename}}<span class="subheadline"><span
												class="icon-ribbon"></span></span>
										</h1>
										<div class="blurb">
											<p></p>
										</div>
									</div>
								</div>
								<div class="info-wrapper" style="display: none">
									<div class="more-info">
										<img
											src="./Men’s watches – Elegance and Fashion-Welly Merck fashion Luxury watches for men and Elegant women_files/5afbfcaa0a5b1.jpg"
											width="400" alt="A VERSATILE LOOK">
										<div class="text">
											<h3>A VERSATILE LOOK</h3>
											<p>Welly Merck's mesh watches for men are durable,
												dependable and always stylish. Free Shipping Worldwide.
												Three-Year Warranty.</p>
											<br> <br> <br> <br>
										</div>
									</div>
									<div class="more-info">
										<img src="https://www.wellymerck.com/watch/men" width="400"
											alt=""><br> <br>
										<div class="text">
											<h3></h3>
											<p></p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="summary-product-list summary-product-list1 layouts">
							<div class="product_list clearfix">
								{{#plist}}
								<div class="each_product ">
									<a
										href="${domain}/jsp/user/productdetail.jsp?pid={{productid}}">
										<div class="pro_name">{{pname}}</div>
										<div class="picture">
											<img
												src="{{logourl}}"
												width="275" alt="{{pname}}">
										</div>
									</a>
									<div class="price_wrap clearfix">

										<span class="price">¥{{discountedprice}}</span>
										<div class="shop_now_btns">
											<a
												href="javascript:;" data-id="{{productid}}"
												class="shop_now btn-label"> <span>SHOP NOW</span><br>
												<span>SHOP NOW</span>
											</a>
										</div>
									</div>
								</div>
								{{/plist}}
								
						</div>
					</div>
					{{#clist}}
					<div class="products">
						<div class="category-header read-more">
							<div class="inner">
								<div class="category-title"
									style="background-image: url({{bannerurl}})">
									<div class="table_cell">
										<h1>
											{{catename}}<span class="subheadline"><span
												class="icon-ribbon"></span></span>
										</h1>
										<div class="blurb">
											<p></p>
										</div>
									</div>
								</div>
								<div class="info-wrapper" style="display: none">
									<div class="more-info">
										<img src="https://www.wellymerck.com/watch/men" width="400"
											alt="">
										<div class="text">
											<h3></h3>
											<p></p>
											<br> <br> <br> <br>
										</div>
									</div>
									<div class="more-info">
										<img src="https://www.wellymerck.com/watch/men" width="400"
											alt=""><br> <br>
										<div class="text">
											<h3></h3>
											<p></p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="summary-product-list summary-product-list2 layouts">
							<div class="product_list clearfix">
								{{#plist}}
								<div class="each_product ">
									<a
										href="https://www.wellymerck.com/products/pioneer-dublin-42mm">
										<div class="pro_name">{{pname}}</div>
										<div class="picture">
											<img
												src="./Men’s watches – Elegance and Fashion-Welly Merck fashion Luxury watches for men and Elegant women_files/5ad73fceec291.jpg"
												width="275" alt="{{pname}}">
										</div>
									</a>
									<div class="choice_wrap">
										<span class="circle on"> <i class="dot"
											style="background-color: #000000"></i>
										</span>
									</div>
									<div class="price_wrap clearfix">

										<span class="price">¥{{discountedprice}}</span>
										<div class="shop_now_btns">
											<a
												href="https://www.wellymerck.com/order/addcart/idstr/132-259-p-0"
												class="shop_now btn-label"> <span>SHOP NOW</span><br>
												<span>SHOP NOW</span>
											</a>
										</div>
									</div>
								</div>
								{{/plist}}
								
						</div>
					</div>
					{{/clist}}
				</div>
			</div>
			</script>
		</div>
		
		


		<!--/Body-->

		<%@ include file="../common/footer.jsp"%>
	</div>

	<!--Others-->

	<script>
		//    load more
		$(".read-more_btn").click(function() {
			$(this).toggleClass("on");
			$(this).parents(".read-more").find(".info-wrapper").slideToggle();
		})

		$(".each_product .choice_wrap .circle").click(
				function() {
					$(this).addClass("on").siblings().removeClass("on");
					$(this).parents(".each_product").find(".picture img").eq(
							$(this).index()).show().siblings().hide();
					$(this).parents(".each_product").find(".shop_now_btns a")
							.eq($(this).index()).show().siblings().hide();
				}).eq(0).click();

		$(document).ready(function() {
			$(".summary-product-list-hide").hide();
			$(".show_more").click(function() {
				$(this).css('display', 'none');
				$(this).prev().find(".summary-product-list-hide").show();
			})
		});
		
		$.ajax({
			url:'${domain}/product/getproductlist',
			type:'post',
			contentType:'application/json',
			data:JSON.stringify({
				cateid:GetQueryString('cateid')
			}),
			success:function(res){
				console.log(res);
				var innerHtml=Mustache.render($('#pagetemplate').html(),res);
				$('#pagecontrainer').html(innerHtml);
			}
		})
		
		$('body').on('click','.shop_now',function(){
			var pid=$(this).attr('data-id');
			addCart(pid);
		})
	</script>

	<!--/Others-->
</body>
</html>