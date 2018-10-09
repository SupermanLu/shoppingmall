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
				
				<div class="product_detail">
					<div class="layouts">
						<h1 class="product_name tc">{{pname}}</h1>
						<div class="product_show_scroll">
							<div class="each_product_show each_product_show1 on" id="view1">
								<!-- Swiper -->
								<div
									class="swiper-container swiper-container-horizontal swiper-container-3d swiper-container-coverflow"
									style="cursor: -webkit-grab;">
									<div class="swiper-wrapper"
										style="transform: translate3d(30px, 0px, 0px); transition-duration: 0ms;">
										<div class="swiper-slide swiper-slide-prev"
											style="transform: translate3d(0px, 0px, -100px) rotateX(0deg) rotateY(0deg); z-index: 0; transition-duration: 0ms;">
											<img
												src="{{logourl}}"
												width="640px" height="640px"
												title="{{pname}}"
												alt="{{pname}}" layer-index="0">
										</div>
										<div class="swiper-slide swiper-slide-active"
											style="transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg); z-index: 1; transition-duration: 0ms;">
											<img
												src="{{logourl}}"
												width="640px" height="640px"
												title="{{pname}}"
												alt="{{pname}}" layer-index="1">
										</div>
										<div class="swiper-slide swiper-slide-next"
											style="transform: translate3d(0px, 0px, -100px) rotateX(0deg) rotateY(0deg); z-index: 0; transition-duration: 0ms;">
											<img
												src="{{logourl}}"
												width="640px" height="640px"
												title="{{pname}}"
												alt="{{pname}}" layer-index="2">
										</div>
										<div class="swiper-slide"
											style="transform: translate3d(0px, 0px, -200px) rotateX(0deg) rotateY(0deg); z-index: -1; transition-duration: 0ms;">
											<img
												src="{{logourl}}"
												width="640px" height="640px"
												title="{{pname}}"
												alt="{{pname}}" layer-index="3">
										</div>
										<div class="swiper-slide"
											style="transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(0deg); z-index: -2; transition-duration: 0ms;">
											<img
												src="{{logourl}}"
												width="640px" height="640px"
												title="{{pname}}"
												alt="{{pname}}" layer-index="4">
										</div>
									</div>
									<!-- Add Pagination -->
									<div class="swiper-pagination"></div>
								</div>
								<!-- Add Pagination -->
								<div class="swiper-button-next"></div>
								<div class="swiper-button-prev"></div>
							</div>
							
						</div>
						<div class="product_addtocart_form clearfix">

	
							<div class="shopnow_wrap">
								<div class="price_wrap">
									<div class="checkout_before clearfix">
										<span data-org_val="229" id="total" class="price"> ¥{{discountedprice}}
										</span>
										<div class="shop_now_btns">
											<a href="javascript:void (0);"
												onclick="addtocart('{{productid}}')" class="shop_now btn-label">
												<span>SHOP NOW</span><br> <span>SHOP NOW</span>
											</a>
										</div>
									</div>
									<div class="checkout_after">
										<a href="/order" class="blackbtn">Go To Checkout</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="margin-bottom: 20px;" class="gray_discount">
					<div class="layouts">
						<!-- Swiper -->
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<div class="each_one">
										<span class="icon"> <img
											src="images/58f80bf2633e4.png"
											height="20">
										</span> <em>免运费</em>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="each_one">
										<span class="icon"> <img
											src="images/58f80bf3000fa.png"
											height="20">
										</span> <em>闪电到货</em>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="each_one">
										<span class="icon"> <img
											src="images/58f80bfed5af2.png"
											height="20">
										</span> <em> 质量保证</em>
									</div>
								</div>
							</div>
						</div>
						<!--end Swiper-->
					</div>
				</div>
				<div class="product_detail_more">
					<div class="layouts">
					{{{descption}}}
					</div>
				</div>
				
			</div>
			</script>
		</div>


		<div id="myModals" class="hide"></div>


		<!--/Body-->

		<%@ include file="../common/footer.jsp"%>
	</div>
	<!--Others-->

	<style>
.sigma-middle-line:before {
	content: '';
	display: block;
	height: 2px;
	background-color: #ebeced; /*颜色需与主题大背景色一致*/
	position: relative;
	top: 12px; /*调节线高*/
}

.sigma-line-text {
	display: inline-block;
	background: #fff;
	padding: 0 18px 0 18px;
	position: relative;
	font-size: 18px;
	font-weight: 500;
}
</style>
	<script>
		
		$(function() {
			$(".product_options .option").click(
					function() {
						$(this).addClass("on").siblings().removeClass("on");
						$(".product_show_scroll .each_product_show").eq(
								$(this).index()).addClass("on").siblings()
								.removeClass("on");
						$(".shopnow_wrap").find(".shop_now_btns a").eq(
								$(this).index()).show().siblings().hide();
					})
		});

		$(".checkout_before").click(function() {
			$(this).parent().addClass("on");
			$(this).slideUp();
			$(this).next().slideDown();
		})
	</script>
	<script>
		$("#chk").click(
				function() {
					if (this.checked) {
						var total = $("#total").data('org_val')
								+ $('#other').data('org_val');
						$("#total").html("$" + total);
					} else {
						$("#total").html("$" + $("#total").data('org_val'))
								.addcss('');
					}
				});

		function addtocart(idstr) {
			addCart(idstr);
		}
	</script>
	<script>
		$(".What_Is_Customization").click(function() {
			{
				var id = $(".product_options .on").data('id')
				layer.load(1);
				$.get("/products/customization?pid=104", {
					color_id : id
				}, function(html) {
					layer.closeAll();
					layer.open({
						type : 1,
						title : '',
						shadeClose : true,
						shade : 0.8,
						area : [ '70%', '80%' ],
						content : html
					});
				}, 'html');
			}
		});
	</script>

	<script>
		$("#pop2").click(function() {
			console.info(html);
			$("#myModals").empty();
			layer.open({
				type : 1,
				title : '',
				shadeClose : true,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : html
			});
		});
		
		$.ajax({
			url:'${domain}/product/getProductbyid',
			type:'post',
			contentType:'application/json',
			data:JSON.stringify({
				productid:GetQueryString('pid')
			}),
			success:function(res){
				console.log(res);
				res.descption=unescape(res.descption);
				var innerHtml=Mustache.render($('#pagetemplate').html(),res);
				$('#pagecontrainer').html(innerHtml);
				
				layer.photos({
					photos : '#view1',
					closeBtn : 1,
					anim : -1,
					shade : .6
				});
				layer.photos({
					photos : '#view2',
					closeBtn : 1,
					anim : -1,
					shade : .6
				});
				var swiper = new Swiper('.each_product_show .swiper-container', {
					nextButton : '.each_product_show .swiper-button-next',
					prevButton : '.each_product_show .swiper-button-prev',
					effect : 'coverflow',
					grabCursor : true,
					centeredSlides : true,
					slidesPerView : 'auto',
					initialSlide : 1,
					coverflow : {
						rotate : 0,
						stretch : 0,
						depth : 100,
						modifier : 1,
						slideShadows : false
					}
				});

				
			}
		})
	</script>


	<!--/Others-->
</body>
</html>