<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle_m.jsp"%>
<body>
	<%@ include file="../common/head_m.jsp"%>

	<!--Body-->
	<div class="all_body_container" style="overflow-x: hidden;">
		<div class="total_container page_container" style="width: 100%; overflow-x: hidden;">
			<div class="swiper-container">
				<div class="swiper-wrapper" id="swipercontrainer">
					<script id="swipertemplate" type="text/x-tpl">
					{{#swiplist}}
					
					<a class="swiper-slide" href="{{swiplink}}"  target="_blank">
						<div class="index_banner"
							style="height:19.25rem;background:url({{swipimgurl}}) no-repeat center top;background-size:200% 100%;">
							<div class="layouts">
								<div class="text_wrap table">
									<div class="text table_cell">
										<h2 class="big_word">
											<div style="color: #FFFFFF; margin-bottom: 20px">
												<br>
											</div>
										</h2>
										<div class="btn_wrap">
											
												
											
										</div>
									</div>
								</div>
							</div>
						</div>
					</a>
					{{/swiplist}}
					
					</script>
				</div>
			</div>
		</div>
		<script>
			$.ajax({
				url : "${domain}/swip/getall",
				type : "POST",
				contentType : "application/json",
				success : function(res) {
					var result = {
						swiplist : res
					}
					var innerHtml = Mustache.render(
							$('#swipertemplate').html(), result);
					$('#swipercontrainer').html(innerHtml);

					var viewSwiper = new Swiper(
							'.total_container .swiper-container', {
								nextButton : '.view .swiper-button-next',
								prevButton : '.view .swiper-button-prev',
								autoHeight : true, //enable auto height
								autoplay : 3000,
								autoplayDisableOnInteraction : false,
							});
				}
			});
		</script>
		<div class="gray_discount">
			<div class="layouts">
				<!-- Swiper -->
				<div class="swiper-container swiper-container-horizontal">
					<div class="swiper-wrapper" style="transform: translate3d(-762px, 0px, 0px); transition-duration: 0ms;">
						<div class="swiper-slide  swiper-slide-active" style="width: 351px; margin-right: 30px;">
							<div class="each_one">
								<span class="icon"> <img
									src="${domain}/jsp/user/images/58f80bf2633e4.png" height="20">
								</span> <em>免运费</em>
							</div>
						</div>
						<div class="swiper-slide swiper-slide-next" style="width: 351px; margin-right: 30px;">
							<div class="each_one">
								<span class="icon"> <img
									src="${domain}/jsp/user/images/58f80bf3000fa.png" height="20">
								</span> <em>闪电发货</em>
							</div>
						</div>
						<div class="swiper-slide" style="width: 351px; margin-right: 30px;">
							<div class="each_one">
								<span class="icon"> <img
									src="${domain}/jsp/user/images/58f80bfed5af2.png" height="20">
								</span> <em>质量保证</em>
							</div>
						</div>
					</div>
				</div>
				<!--end Swiper-->
			</div>
			
		</div>
		<div class="index_popular">
			<div class="layouts">
				<h2 class="normal_title normal_title1">热卖商品</h2>
				<!-- Swiper -->
				<div class="swiper-container swiper-container-horizontal">
					<div class="swiper-wrapper" id="popularcontrainer">
						<script id="populartemplate" type="text/x-tpl">
						{{#productlist}}
						<div class="swiper-slide {{res}}"
							style="width: 351px; margin-right: 30px;">
							<div class="scroll_product">
								<a
									href="${domain}/jsp/mobile/productdetail.jsp?pid={{productid}}">
									<img
									src="{{logourl}}"
									width="275" height="275" alt="{{pname}}">
								</a>
								<div class="text_w">
									<strong class="pro_name">{{pname}}</strong>
									<div class="price_wrap clearfix">

										<span class="price">￥{{discountedprice}}</span>
										<!--<span class="price">￥{{discountedprice}}</span>-->
										<a
											href="javascript:;" data-id="{{productid}}"
											class="shop_now btn-label"> <span>马上兑换</span><br>
											<span>马上兑换</span>
										</a>
									</div>
								</div>
							</div>
						</div>
						{{/productlist}}
						</script>
					</div>
					<!-- Add Pagination -->
					<div class="swiper-pagination"></div>
				</div>
				<!-- Add Pagination -->
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev swiper-button-disabled"></div>
				<!--end Swiper-->
			</div>
		</div>
		<div class="index_show">
			<div class="layouts pro_list">
				<h1 class="tab">
					<a href="javascript:;" class="hot" data-index="1">推荐商品</a> <a
						href="javascript:;" data-index="2">精品推荐</a> <a href="javascript:;"
						data-index="3">热卖精品</a> <a href="javascript:;" data-index="4">新品上架</a>
						<a href="javascript:;" data-index="5">抢购商品</a>
						<a href="javascript:;" data-index="6">团购商品</a>
				</h1>
				<script id="ulisttemplate" type="text/x-tpl">
							{{#list}}
							<div class="per_one goproduct" data-id="{{productid}}" style="{{isShow}}">
								<img src="{{logourl}}" 
style="padding-bottom:20%;"alt="{{pname}}">
								<div class="shop_now table transition">
									<span class="table_cell">{{pname}}
<br />折扣价:￥{{discountedprice}}&nbsp&nbsp|&nbsp&nbsp销量:{{sales}}</span>

									
								</div>
							</div>
							{{/list}}
				</script>
				<ul style="" data-index="1">
					<li>
						<div class="list clearfix" id="ulist1">
							
						</div>
						<div class="show_more">
							<a href="javascript:void(0)" class="more listmore">
								<span>显示更多</span>
							</a>
						</div>
					</li>
				</ul>
				<ul style="display:none;" data-index="2">
					<li>
						<div class="list clearfix" id="ulist2">
							
						</div>
						<div class="show_more">
							<a href="javascript:void(0)" class="more listmore">
								<span>显示更多</span>
							</a>
						</div>
					</li>
				</ul>
				<ul style="display:none;" data-index="3">
					<li>
						<div class="list clearfix" id="ulist3">
							
						</div>
						<div class="show_more">
							<a href="javascript:void(0)"  class="more listmore">
								<span>显示更多</span>
							</a>
						</div>
					</li>
				</ul>
				<ul style="display:none;" data-index="4">
					<li>
						<div class="list clearfix" id="ulist4">
							
						</div>
						<div class="show_more">
							<a href="javascript:void(0)"  class="more listmore">
								<span>显示更多</span>
							</a>
						</div>
					</li>
				</ul>
				<ul style="display:none;" data-index="5">
					<li>
						<div class="list clearfix" id="ulist5">
							
						</div>
						<div class="show_more">
							<a href="javascript:void(0)"  class="more listmore">
								<span>显示更多</span>
							</a>
						</div>
					</li>
				</ul>
				<ul style="display:none;" data-index="6">
					<li>
						<div class="list clearfix" id="ulist6">
							
						</div>
						<div class="show_more">
							<a href="javascript:void(0)"  class="more listmore">
								<span>显示更多</span>
							</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<script>
			//POPULAR HOT & BESTSELLERS
			
			$('body').on('click','.listmore',function(){
				$(this).css('display','none');
				var ulist=$(this).parent().parent().children('div:eq(0)');
				$(ulist).find('.per_one').css('display','block');
			})
			
			
			$('body').on('click','.pro_list h1 a',function(){
				var index=$(this).attr('data-index');
				$('.pro_list ul').css('display','none');
				$('.pro_list h1 a').removeClass('hot');
				var uls=$('.pro_list ul');

				for(var i=0;i<uls.length;i++){
					if($(uls[i]).attr('data-index')==index){
						$(uls[i]).css('display','block');
					}
				}
				
				$(this).addClass('hot');
			})
			
			
			$('body').on('click','.goproduct',function(){
				var productid=$(this).attr('data-id');
				window.location.href = "${domain}/jsp/mobile/productdetail.jsp?pid="+productid;
			})
			
			var listTemplate=$('#ulisttemplate').html();
			
			function renderUl(dom,url){
				$
				.ajax({
					url : url,
					type : "POST",
					contentType : "application/json",
					success : function(res) {
						if (res.length > 6) {
							res[0].isShow = 'display:none;';
						}
						var result = {
							list : res
						}
						var innerHtml = Mustache.render(listTemplate, result);
						dom.html(innerHtml);
					}
				});
			}
			
			renderUl($(ulist1),"${domain}/product/getTJ");
			renderUl($(ulist2),"${domain}/product/getJPTJ");
			renderUl($(ulist3),"${domain}/product/getRXJP");
			renderUl($(ulist4),"${domain}/product/getXP");
			renderUl($(ulist5),"${domain}/product/getQG");
			renderUl($(ulist6),"${domain}/product/getTG");

			$
					.ajax({
						url : "${domain}/product/getHot",
						type : "POST",
						contentType : "application/json",
						success : function(res) {
							if (res.length > 0) {
								res[0].cls = 'swiper-slide-active';
							}
							if (res.length > 1) {
								res[1].cls = 'swiper-slide-next';
							}
							var result = {
								productlist : res
							}
							var innerHtml = Mustache.render($(
									'#populartemplate').html(), result);
							$('#popularcontrainer').html(innerHtml);

							var swiper = new Swiper('.index_popular .swiper-container', {
			                    nextButton: '.index_popular .swiper-button-next',
			                    prevButton: '.index_popular .swiper-button-prev',
			                    slidesPerView: 1,
			                    spaceBetween: 30,
			                    paginationClickable: true,
			                    autoplay: 2000
			                });
						}
					});

			$('body').on('click', '.shop_now', function() {
				var pid = $(this).attr('data-id');
				addCart(pid);
			})
		</script>
		<!--<div class="index_show">
			<div class="layouts">
				<div class="title_w tc">
					<h2 class="normal_title">
						THE WELLY MERCK WORLD<br>
						<span class="line_word">WORLD</span>
					</h2>
					<p style="font-family: regular" class="tips">
						Our watches are all over the world. Take a look at how other
						people <br> wear their Welly Merck watches and get inspired.
					</p>
				</div>
				<div class="list clearfix" id="ulist">
					<div class="per_one" onclick="opendetail(15)">
						<img
							src="./Welly Merck fashion Luxury watches for men and Elegant women_files/5b97ca2e3b298.jpg"
							width="585" alt="SHOP THE LOOK">
						<div class="shop_now table transition">
							<span class="table_cell">SHOP THE LOOK</span>
						</div>
					</div>
					<div class="per_one" onclick="opendetail(16)">
						<img
							src="./Welly Merck fashion Luxury watches for men and Elegant women_files/5a6ef1371eced.jpg"
							width="585" alt="SHOP THE LOOK">
						<div class="shop_now table transition">
							<span class="table_cell">SHOP THE LOOK</span>
						</div>
					</div>
					<div class="per_one" onclick="opendetail(7)">
						<img
							src="./Welly Merck fashion Luxury watches for men and Elegant women_files/5b93371c85d00.jpg"
							width="585" alt="SHOP THE LOOK">
						<div class="shop_now table transition">
							<span class="table_cell">SHOP THE LOOK</span>
						</div>
					</div>
					<div class="per_one" onclick="opendetail(14)">
						<img
							src="./Welly Merck fashion Luxury watches for men and Elegant women_files/5b90acefaae65.jpg"
							width="585" alt="SHOP THE LOOK">
						<div class="shop_now table transition">
							<span class="table_cell">SHOP THE LOOK</span>
						</div>
					</div>
					<div class="per_one" onclick="opendetail(4)">
						<img
							src="./Welly Merck fashion Luxury watches for men and Elegant women_files/5b97cab65279c.jpg"
							width="585" alt="SHOP THE LOOK">
						<div class="shop_now table transition">
							<span class="table_cell">SHOP THE LOOK</span>
						</div>
					</div>
					<div class="per_one" onclick="opendetail(9)">
						<img
							src="./Welly Merck fashion Luxury watches for men and Elegant women_files/5b90ad55efb96.jpg"
							width="585" alt="SHOP THE LOOK">
						<div class="shop_now table transition">
							<span class="table_cell">SHOP THE LOOK</span>
						</div>
					</div>
				</div>
				<div class="show_more">
					<a href="javascript:void(0)" onclick="getmore()" class="more">
						<span>SHOW MORE</span>
					</a>
				</div>
			</div>
		</div>-->
		<script>
			function opendetail(id) {
				layer.open({
					type : 2,
					shadeClose : true,
					area : [ '1200px', '628px' ],
					title : '',
					shadeClose : true,
					shade : 0.4,
					content : "/index/worlddetail?id=" + id
				});
			}
		</script>

		<script>
			var start_num = 1;
			var page = "2";
			function getmore() {
				$
						.ajax({
							type : "post",
							url : "/index/getmore",
							dataType : 'json',
							data : {
								start_num : start_num
							},
							success : function(data) {
								var str = '';
								data
										.forEach(function(item) {
											str += '<div class="per_one" onclick="opendetail('
													+ item['id']
													+ ')"><img src="' + item['picture'] + '" width="380" /><div class="shop_now table transition"><span class="table_cell">'
													+ item['title']
													+ '</span></div></div>';
										})
								$('#ulist').append(str);
								start_num++;
								if (start_num == parseInt(page)) {
									$('.show_more').css('display', 'none');
								}
							}
						});
			}
		</script>



		<!--/Body-->

		<%@ include file="../common/footer_m.jsp"%>
	</div>
	<!--Others-->

	<script type="text/javascript">
		/*$(document).ready(function() {
		    layer.open({
		        type: 2,
		        area: ['798px', '450px'],
		        title: '',
		        shadeClose: true,
		        shade: 0.4,
		        content: "/index/loadshowcode"
		    });
		});*/
	</script>
	<script>
		var viewSwiper = new Swiper('.index_about .view .swiper-container', {
			nextButton : '.view .swiper-button-next',
			prevButton : '.view .swiper-button-prev',
			autoHeight : true, //enable auto height
			autoplay : 3000,
			autoplayDisableOnInteraction : false,
		});

		var previewSwiper = new Swiper(
				'.index_about .preview .swiper-container', {
					spaceBetween : 10,
					centeredSlides : true,
					slidesPerView : 'auto',
					touchRatio : 0.2,
					slideToClickedSlide : true,
					virtualTranslate : true,
					autoplay : 3000,
					autoplayDisableOnInteraction : false,
				});
		viewSwiper.params.control = previewSwiper;
		previewSwiper.params.control = viewSwiper;
		$('.index_about').mouseover(function() {
			viewSwiper.stopAutoplay();
			previewSwiper.stopAutoplay();
		});

		$('.index_about').mouseleave(function() {
			viewSwiper.startAutoplay();
			previewSwiper.startAutoplay();
		});
		function updateNavPosition() {
			$('.preview .active-nav').removeClass('active-nav')
			var activeNav = $('.preview .swiper-slide').eq(
					viewSwiper.activeIndex).addClass('active-nav')
		}
		
		var swiper = new Swiper('.gray_discount .swiper-container', {
            nextButton: '.gray_discount .swiper-button-next',
            prevButton: '.gray_discount .swiper-button-prev',
            slidesPerView: 1,
            spaceBetween: 30,
            paginationClickable: true,
            autoplay: 2000
        });
	</script>

	<!--/Others-->
</body>
</html>