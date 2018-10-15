<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle_m.jsp"%>
<body>
	<%@ include file="../common/head_m.jsp"%>

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
										{{#pimgs}}
										<div class="swiper-slide {{cls}}">
											<img
												src="{{url}}"
												width="640px" height="640px"
												title="{{pname}}"
												alt="{{pname}}" layer-index="{{index}}">
										</div>
										{{/pimgs}}
										
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
							<div style="float:left;width: 100%;margin-bottom:10px;text-align:center;">
								<div style="border-color: transparent;width: auto;height:52px;line-height:58px;padding-left:10px;; color: #fff;  background-color: #479e7a;transition: all .6s;">
									<span  class="checkbox1" data-org_val="39" id="other">
									  <!--  <input type="checkbox" name="checkbox" id="chk"/>
										 <label></label>-->
										
									   <span style="padding-right: 15px; width: auto; font-size: 16px;" class="price">
										 库存:{{stock}}                                </span>
									</span>
								</div>
							</div>

							<div style="float:left;width: 100%;margin-bottom:10px;text-align:center;">
								<div style="border-color: transparent;width: auto;height:52px;line-height:58px;padding-left:10px;; color: #fff;  background-color: #479e7a;transition: all .6s;">
									<span  class="checkbox1" data-org_val="39" id="other">
									  <!--  <input type="checkbox" name="checkbox" id="chk"/>
										 <label></label>-->
										
									   <span style="padding-right: 15px; width: auto; font-size: 16px;" class="price">
									销量:{{sales}}                                </span>
									</span>
								</div>
							</div>

							<div style="float:left;width: 100%;margin-bottom:10px;text-align:center;">
								<div style="border-color: transparent;width: auto;height:52px;line-height:58px;padding-left:10px;; color: #fff;  background-color: #479e7a;transition: all .6s;">
									<span  class="checkbox1" data-org_val="39" id="other">
									  <!--  <input type="checkbox" name="checkbox" id="chk"/>
										 <label></label>-->
										 
									   <span style="padding-right: 15px; width: auto; font-size: 16px;" class="price">
										原价:<span style="text-decoration:line-through;">￥{{originalprice}}</span>                                </span>
									</span>
									
								</div>
							</div>

							<div class="shopnow_wrap">
								<div class="price_wrap">
									<div class="checkout_before clearfix">
										<span data-org_val="229" id="total" class="price">¥{{discountedprice}}
										</span>
										<div class="shop_now_btns">
											<a href="javascript:void (0);"
												onclick="addtocart('{{productid}}')" class="shop_now btn-label">
												<span>马上兑换</span><br> <span>马上兑换</span>
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

		<div class="bd goods_list layouts">
			<div class="tab_title">
				<h2>
					<span class="icon"></span>商品咨询
				</h2>
			</div>
			<p class="promInfo clearfix">
				<span class="span1"> <i class="red">温馨提示：</i><br>
					因厂家更改产品、产地等不作提前通知，且每位咨询者购买情况、提问时间等不同。回复的内容仅在一定的时期内有参考意义，若由此给您带来不便请多多谅解，敬请谅解，谢谢！
				</span> <span class="span2"> <a class="item_message btn-css3"
					href="tencent://message/?uin=863779999&amp;Site=在线QQ&amp;Menu=yes"
					target="_blank">咨询客服</a> <br>
				</span>
			</p>
			<div id="message_wrapper" style="padding: 0">
				<p class="empty">暂时还没有任何用户咨询</p>
			</div>
		</div>

		<div id="myModals" class="hide"></div>


		<!--/Body-->

		<%@ include file="../common/footer_m.jsp"%>
	</div>
	<!--Others-->

	<style>
.bd {
	border: none;
	padding: 0;
	overflow: hidden;
	background: transparent;
	padding: 10px;
	border: 1px solid #eee;
}

.tab_title {
	background: #f6f6f6;
	height: 30px;
	line-height: 30px;
	padding-left: 10px;
	margin-bottom: 10px;
	padding-top: 7px;
	padding-left: 10px;
}

.promInfo {
	background: #F8F9F9;
	border: 1px solid #eee;
	display: block;
	height: 100%;
	margin: 10px 0 0;
	overflow: hidden;
	padding: 15px 18px;
}

.promInfo span {
	float: left;
	height: 100px;
	overflow: hidden;
	color: #666;
}

.span1 {
	border-right: 1px solid #eee;
	padding: 0 25px 0 0;
	width: calc(100% - 158px);
}

.span2 {
	padding: 7px 0 0 24px;
	text-align: center;
	width: 108px;
}

.empty {
	font-family: 'Microsoft JhengHei', 'Microsoft YaHei', '微软雅黑', '黑体';
	display: block;
	padding: 50px 0;
	color: #999;
	font-size: 1.5em;
	font-weight: normal;
	text-align: center;
}

.btn-css3 {
	background-color: #f70;
	border: 1px solid #eb7207;
	border-radius: 3px;
	color: #FFFFFF;
	display: inline-block;
	font-size: 100%;
	overflow: hidden;
	padding: 5px 12px;
	vertical-align: middle;
	height: 16px;
	line-height: 16px;
	margin-top:10px;
}

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

		$
				.ajax({
					url : '${domain}/product/getProductbyid',
					type : 'post',
					contentType : 'application/json',
					data : JSON.stringify({
						productid : GetQueryString('pid')
					}),
					success : function(res) {
						console.log(res);
						res.descption = unescape(res.descption);
						var pimgurl = res.pimgurl;
						if (pimgurl == null) {
							pimgurl = '';
						}
						var pimgs = pimgurl.split(',');
						var pimglist = [];
						for ( var i in pimgs) {
							var img = {
								url : pimgs[i],
								cls : (i == 0 ? 'swiper-slide-active'
										: (i == 1 ? 'swiper-slide-next' : '')),
								pname : res.pname,
								index : i
							}
							pimglist.push(img);
						}

						res.pimgs = pimglist;
						var innerHtml = Mustache.render($('#pagetemplate')
								.html(), res);
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
						var swiper = new Swiper(
								'.each_product_show .swiper-container',
								{
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