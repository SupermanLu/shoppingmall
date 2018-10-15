<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle_m.jsp"%>
<body>
	<%@ include file="../common/head_m.jsp"%>
	<style>
.pro_list .tab-contrainer {
	position: fixed;
	top: 5.75rem;
	left: 0;
	z-index: 99;
	background: #fff;
	width: 100%;
}
#tab{
	margin-top:10px;
}

#pagecontrainer {
	padding-top: 5.75rem;
}
</style>
	<!--Body-->
	<div class="all_body_container">
		<div class="layouts pro_list">
<div class="tab-contrainer">
			<h1 class="tab layouts" id="tab">
				<script id="tabtemplate" type="text/x-tpl">
{{#tab}}
					<a href="JavaScript:;" class="tab-item {{hotClass}}" data-guid="{{value}}">{{text}}</a>
{{/tab}}
				</script>
			</h1>
			</div>
			<div class="page_container" id="pagecontrainer">

				<script id="pagetemplate" type="text/x-tpl">
			<div class="container">
				<div class="catalog-list">
					<div class="products" id="{{category.cateid}}">
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
								
							</div>
						</div>
						<div class="summary-product-list summary-product-list1 layouts">
							<div class="product_list clearfix">
								{{#plist}}
								<div class="each_product ">
									<a
										href="${domain}/jsp/mobile/productdetail.jsp?pid={{productid}}">
										
										<div class="picture">
											<img
												src="{{logourl}}"
												width="275" height="275" alt="{{pname}}">
										</div>
										<div class="pro_name" style="margin:10px 0 20px;">{{pname}}</div>
									</a>
									<div class="price_wrap clearfix">

										<span class="price">¥{{discountedprice}}</span>
										<div class="shop_now_btns">
											<a
												href="javascript:;" data-id="{{productid}}"
												class="shop_now btn-label"> <span>马上兑换</span><br>
												<span>马上兑换</span>
											</a>
										</div>
									</div>
								</div>
								{{/plist}}
								
						</div>
					</div>
					{{#clist}}
					<div class="products" id="{{cateid}}">
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
								
							</div>
						</div>
						<div class="summary-product-list summary-product-list2 layouts">
							<div class="product_list clearfix">
								{{#plist}}
								<div class="each_product ">
									<a
										href=""${domain}/jsp/mobile/productdetail.jsp?pid={{productid}}">
										
										<div class="picture">
											<img
												src="{{logourl}}"
												width="275" height="275" alt="{{pname}}">
										</div>
										<div class="pro_name" style="margin:10px 0 20px;">{{pname}}</div>
									</a>
						
									<div class="price_wrap clearfix">

										<span class="price">¥{{discountedprice}}</span>
										<div class="shop_now_btns">
											<a
												href="javascript:;"
												class="shop_now btn-label" data-id="{{productid}}"> <span>马上兑换</span><br>
												<span>马上兑换</span>
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
		</div>




		<!--/Body-->

		<%@ include file="../common/footer_m.jsp"%>
	</div>

	<!--Others-->

	<script>
		//    load more
		$(".read-more_btn").click(function() {
			$(this).toggleClass("on");
			$(this).parents(".read-more").find(".info-wrapper").slideToggle();
		})

		$('body').on('click', '.tab-item', function() {
			$('.pro_list h1 a').removeClass('hot');
			$(this).addClass("hot");
			var guid = $(this).attr('data-guid');
			$('body,html').animate({scrollTop: ($("#" + guid).offset().top-$($('.header')[0]).height()-$($('.tab-contrainer')[0]).height())}, 500);
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

		$
				.ajax({
					url : '${domain}/product/getproductlist',
					type : 'post',
					contentType : 'application/json',
					data : JSON.stringify({
						cateid : GetQueryString('cateid')
					}),
					success : function(res) {
						console.log(res);
						var carts = [ {
							text : res.category.catename,
							value : res.category.cateid,
							hotClass : 'hot'
						} ]
						for (var i = 0; i < res.clist.length; i++) {
							var item = res.clist[i];
							carts.push({
								text : item.catename,
								value : item.cateid
							});
						}
						var tab = {
							tab : carts
						}
						var innerHtml = Mustache.render($('#pagetemplate')
								.html(), res);
						var innerHtmlTab = Mustache.render($('#tabtemplate')
								.html(), tab);
						$('#pagecontrainer').html(innerHtml);
						$('#tab').html(innerHtmlTab);
					}
				})

		$('body').on('click', '.shop_now', function() {
			var pid = $(this).attr('data-id');
			addCart(pid);
		})
	</script>

	<!--/Others-->
</body>
</html>