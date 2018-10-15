<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle_m.jsp"%>
<body>
	<%@ include file="../common/head_m.jsp"%>
	<style>
.gray {
	-webkit-filter: grayscale(100%);
	-moz-filter: grayscale(100%);
	-ms-filter: grayscale(100%);
	-o-filter: grayscale(100%);
	filter: grayscale(100%);
	filter: gray;
}
</style>
	<!--Body-->
	<div class="all_body_container">

		<form id="Order" onsubmit="return false" novalidate="novalidate">
			<div class="page_container">
				<div class="container">
					<div class="settlement_page normal_page">
						<div class="page_normal_title_wrap">
							<h2 class="page_normal_title">确认购买</h2>
						</div>
						<div class="settlement_content">
							<div class="settlement_list">
								<div class="layouts">
									<div class="settlement_product" id="pagecontrainer">
										<script id="pagetemplate" type="text/x-tpl">
										{{#cartlist}}
										<div class="each_product clearfix">
											<div class="picture">
												<a
													href="${domain}/jsp/mobile/productdetail.jsp?pid={{product.productid}}"><img
													src="{{product.logourl}}" width="120"></a>
											</div>
											<!-- 印章图标 -->
											<div class="text_wrap text_wrap2">
												<span class="close removecart"  data-id="{{cartid}}"></span>
												<a
													href="${domain}/jsp/mobile/productdetail.jsp?pid={{product.productid}}"><h2
														class="pro_name">{{product.pname}}</h2></a>
												<div class="more_parameter clearfix">
													<div class="per_part num_part">
														<div class="add_sub sub_part" data-id="{{cartid}}" data-num="{{num}}">
															<i></i>
														</div>
														<div class="quantity" id="number_0">{{num}}</div>
														<div class="add_sub add_part" data-id="{{cartid}}"  data-num="{{num}}">
															<i></i>
														</div>
													</div>
													<div class="per_part price_part input_w">
														￥ <font id="xj_0">{{product.discountedprice}}</font> <span id="xj_real_0"
															style="display: none">{{product.discountedprice}}</span>
													</div>
												</div>
											</div>
										</div>
										{{/cartlist}}
										</script>

									</div>
									<div class="con_shop">
										<a href="${domain}/jsp/mobile/index.jsp" class="greenbtn">继续购买</a>
									</div>
								</div>
							</div>

							<script>
								function removecart(id) {
									layer.open({
										type : 2,
										shadeClose : false,
										area : [ '600px', '280px' ],
										title : '',
										shade : 0.4,
										content : "/order/removecart?id=" + id
									});
								}

								function changenum(type, id) {
									$.ajax({
										type : "post",
										url : "/ajax/changenum",
										dataType : 'json',
										data : {
											type : type,
											id : id
										},
										success : function(data) {
										}
									});
									var number = parseInt($('#number_' + id)
											.html());
									var changenumber = number;
									var price = parseFloat($('#price_' + id)
											.val());
									if (type == 'add') {
										number++;
									} else {
										if (number > 1) {
											number--;
										}
									}
									$('#number_' + id).html(number);
									$('#f_number_' + id).html(number);
									var xj = number * price;
									$('#xj_real_' + id).html(xj);
									$('#xj_' + id).html(number_format(xj));
									$('#f_xj_real' + id).html(xj);
									$('#f_xj_' + id).html(number_format(xj));
									if (changenumber != number) {
										countmoney(type, price);
									}
								}

								function countmoney(type, money) {
									var all_money = parseFloat($(
											'#all_real_money').html());
									money = parseFloat(money);
									if (type == 'add') {
										all_money += money;
									} else {
										if (all_money - money > 0) {
											all_money -= money;
										}
									}
									$('#all_real_money').html(all_money);
									$('#all_money').html(
											number_format(all_money));
								}
								$(
										".settlement_product .each_product .more_parameter .size_part")
										.click(
												function() {
													$(this).find(".down_list")
															.slideToggle();
												})
								function changelength(e, id, length) {
									$.ajax({
										type : "post",
										url : "/ajax/changelength",
										dataType : 'json',
										data : {
											length : length,
											id : id
										},
										success : function(data) {
											if (data['status']) {
												$('#diameter_' + id).text(
														length);
												e.addClass('on');
												e.siblings().removeClass('on');
											} else {
												layer.msg(data['info'], {
													icon : 5
												});
											}
										}
									});
								}

								/**
								 *number数字
								 *fix保留的小数位
								 *fh间隔
								 *jg为整数位每几位间隔,默认为3位一隔
								 */
								function number_format(number, fix, fh, jg) {
									var fix = arguments[1] ? arguments[1] : 2;
									var fh = arguments[2] ? arguments[2] : ',';
									var jg = arguments[3] ? arguments[3] : 3;
									var str = '';
									number = number.toFixed(fix);
									zsw = number.split('.')[0];//整数位
									xsw = number.split('.')[1];//小数位
									zswarr = zsw.split('');//将整数位逐位放进数组
									for (var i = 1; i <= zswarr.length; i++) {
										str = zswarr[zswarr.length - i] + str;
										if (i % jg == 0) {
											str = fh + str;//每隔jg位前面加指定符号
										}
									}
									str = (zsw.length % jg == 0) ? str
											.substr(1) : str;
									zsw = str;//重新连接整数和小数位+'.'+xsw
									return zsw;
								}
							</script>
							<div class="message_form">
								<div class="layouts">
									<div class="each_form your_message">
										<div class="each">
											<h2 class="title">您的信息</h2>

											<div class="label_input long_label_input">
												<div class="label">
													<label>姓名</label>
												</div>
												<div class="input_w">
													<input type="text" class="input_text" name="first_name"
														value="" id="name">
												</div>
											</div>

											<div class="label_input long_label_input">
												<div class="label">
													<label>电话</label>
												</div>
												<div class="input_w">
													<input type="text" class="input_text" name="phone_1"
														id="mobile" value="">
												</div>
											</div>
											<div class="label_input long_label_input">
												<div class="label">
													<label>地址</label>
												</div>
												<div class="input_w">
													<textarea name="street_address_1" id="address"></textarea>
												</div>
											</div>




											<script>
												$(".your_message .checkbox1")
														.click(
																function() {
																	if ($(
																			".your_message .checkbox1 input")
																			.is(
																					':checked')) {
																		$(this)
																				.parent()
																				.next()
																				.slideDown();
																	} else {
																		$(this)
																				.parent()
																				.next()
																				.slideUp();
																	}
																})
											</script>
										</div>


									</div>
									<div class="each_form total_form" id="total_form">
										<script id="total_form_template" type="text/x-tpl">
										<h2 class="title">总计</h2>
										<div class="total_table">
											<div class="product_rows">
												{{#cartlist}}
												<div class="each_tabel_row clearfix">
													<div class="row1">
														<font id="f_number_0">{{num}}</font>x
													</div>
													<div class="row2">{{product.pname}}</div>
													<div class="row3">
														￥ <font id="f_xj_0">{{product.discountedprice}}</font> <span id="f_xj_real_0"
															style="display: none">{{product.discountedprice}}</span>
													</div>
												</div>
												{{/cartlist}}
											</div>
											<div class="total_row clearfix">
												<div class="clearfix" id="discount_area"
													style="display: none">
													<div class="row1">
														Discount(<font id="coupon_xs"></font>)
													</div>
													<div class="row2">
														$<font id="discount_money"></font>
													</div>
												</div>
												<div class="clearfix">
													<div class="row1">总价</div>
													<div class="row2">
														￥<font id="all_money">{{price}}</font> <span id="all_real_money"
															style="display: none">{{price}}</span>
													</div>
												</div>
											</div>
										</div>

										<div class="submit_wrap">
											<input type="hidden" name="coupon" id="coupon"> <input
												id="sumbitinput" type="button" class="greenbtn"
												value="确认订单">
										</div>
										
										</script>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!--<script src="/Public/Common/layer/layer.js"></script>-->
				<script src="${domain}/jsp/user/js/jquery.validate-1.13.1.js"></script>
				<script>
					var dfpaycard = 0;

					jQuery.validator
							.addMethod(
									"isMobile",
									function(value, element) {
										var length = value.length;
										var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
										return this.optional(element)
												|| (length == 11 && mobile
														.test(value));
									}, "");

					jQuery.validator
							.addMethod(
									"isCard",
									function(value, element) {
										return this.optional(element)
												|| (checkCardNoLength(value) && luhnCheckSum(value));
									}, "");
					//ccv2
					jQuery.validator
							.addMethod(
									"isccv2",
									function(value, element) {
										return this.optional(element)
												|| (checkCvvLength(value) && checkCvvFormat(value));
									}, "");

					//card
					jQuery.validator.addMethod("cardYz", function(value,
							element) {
						var result = false;
						$.ajax({
							type : "post",
							url : "/ajax/cardyz",
							dataType : 'json',
							data : {
								cardnumber : value
							},
							async : false,
							success : function(data) {
								result = data;
							}
						});
						return result;
					}, "");

					$()
							.ready(
									function() {
										$('#Order')
												.validate(
														{
															//debug: true,
															rules : {
																"email_1" : {
																	"required" : true,
																	"email" : true,
																	"maxlength" : 100
																},
																"first_name_1" : {
																	"required" : true,
																	"maxlength" : 30
																},
																"last_name_1" : {
																	"required" : true,
																	"maxlength" : 30
																},
																"phone_1" : {
																	"required" : true,
																	"maxlength" : 50
																},
																"street_address_1" : {
																	"required" : true,
																	"maxlength" : 100
																},
																"city_1" : {
																	"required" : true,
																	"maxlength" : 50
																},
																"zip_code_1" : {
																	"required" : true,
																	"maxlength" : 20
																},
																"province_1" : {
																	"required" : true,
																	"maxlength" : 50
																},
																"email_2" : {
																	"required" : true,
																	"email" : true,
																	"maxlength" : 100
																},
																"first_name_2" : {
																	"required" : true,
																	"maxlength" : 30
																},
																"last_name_2" : {
																	"required" : true,
																	"maxlength" : 30
																},
																"phone_2" : {
																	"required" : true,
																	"maxlength" : 50
																},
																"street_address_2" : {
																	"required" : true,
																	"maxlength" : 100
																},
																"city_2" : {
																	"required" : true,
																	"maxlength" : 50
																},
																"zip_code_2" : {
																	"required" : true,
																	"maxlength" : 20
																},
																"province_2" : {
																	"required" : true,
																	"maxlength" : 50
																},
																"pay_type" : {
																	"required" : true
																},
																"c_name" : {
																	"required" : true,
																	"maxlength" : 50
																},
																"c_number" : {
																	"required" : true,
																	"maxlength" : 50,
																	"isCard" : true,
																	"cardYz" : true
																},
																"c_expdate_month" : {
																	"required" : true
																},
																"c_expdate_year" : {
																	"required" : true
																},
																"c_verinumber" : {
																	"required" : true,
																	"digits" : true,
																	"isccv2" : true
																},
																"is_accept" : {
																	"required" : true
																}
															},
															messages : {
																"email_1" : {
																	"required" : "This is a required field",
																	"email" : "Please enter a valid email address. For example jonson@domain.com",
																	"maxlength" : "Please enter less than 100 characters"
																},
																"first_name_1" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 30 characters"
																},
																"last_name_1" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 30 characters"
																},
																"phone_1" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 50 numbers"
																},
																"street_address_1" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 100 characters"
																},
																"city_1" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 50 characters"
																},
																"zip_code_1" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 20 characters"
																},
																"province_1" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 50 characters"
																},
																"email_2" : {
																	"required" : "This is a required field",
																	"email" : "Please enter a valid email address. For example jonson@domain.com",
																	"maxlength" : "Please enter less than 100 characters"
																},
																"first_name_2" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 30 characters"
																},
																"last_name_2" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 30 characters"
																},
																"phone_2" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 50 numbers"
																},
																"street_address_2" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 100 characters"
																},
																"city_2" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 50 characters"
																},
																"zip_code_2" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 20 characters"
																},
																"province_2" : {
																	"required" : "This is a required field",
																	"maxlength" : "Please enter less than 50 characters"
																},
																"pay_type" : {
																	"required" : "This is a required field"
																},
																"c_name" : {
																	"required" : "PLEASE ENTER NAME ON CARD",
																	"maxlength" : "NAME ON CARD MUST BE LESS THAN 50 NUMBERS"
																},
																"c_number" : {
																	"required" : "PLEASE ENTER CREDIT CARD NUMBER",
																	"maxlength" : "CREDIT CARD NUMBER MUST BE LESS THAN 50 NUMBERS",
																	"isCard" : "Credit card number does not match credit card type.",
																	"cardYz" : "Credit card number does not match credit card type"
																},
																"c_expdate_month" : {
																	"required" : "PLEASE SELECT EXPIRATION DATE Month"
																},
																"c_expdate_year" : {
																	"required" : "PLEASE SELECT EXPIRATION DATE YEAR"
																},
																"c_verinumber" : {
																	"required" : "PLEASE ENTER CARD VERIFICATION NUMBER",
																	"digits" : "card verification number does not match credit card type.",
																	"isccv2" : "card verification number does not match credit card type."
																},
																"is_accept" : {
																	"required" : "This is a required field"
																}
															},
															showErrors : function(
																	errorMap,
																	errorList) {
																var msg = "";
																$
																		.each(
																				errorList,
																				function(
																						i,
																						v) {
																					layer
																							.tips(
																									v.message,
																									v.element,
																									{
																										time : 1000
																									});
																					return false;
																				});
															},
															onkeyup : false,
															onfocusout : false,
															submitHandler : function() {
																$(":submit")
																		.attr(
																				"disabled",
																				true);
																layer.load(1);
																if (dfpaycard
																		&& typeof (dfpaycard) == "function") {
																	dfpaycard("/ajax/ordersubmit");
																} else {
																	$
																			.ajax({
																				type : "post",
																				url : "/ajax/ordersubmit",
																				dataType : 'json',
																				data : $(
																						'#Order')
																						.serialize(),
																				success : function(
																						data) {
																					if (data['status'] > 0) {
																						layer
																								.msg(
																										data['info'],
																										{
																											icon : 6
																										});
																						layer
																								.closeAll('loading');
																						window.location.href = "/pay/gotopay"
																					} else {
																						layer
																								.msg(
																										data['info'],
																										{
																											icon : 5
																										});
																						layer
																								.closeAll('loading');
																						$(
																								":submit")
																								.removeAttr(
																										"disabled");
																					}
																				}
																			});
																}
															}
														});
									});
				</script>
				<script>
					var dfpaycard = (function(gourl) {
						var pay_type = $("input[name='pay_type']:checked")
								.val()
						if (pay_type == 1) {
							$.ajax({
								type : "post",
								url : "/ajax/dfordersubmit",
								dataType : 'json',
								data : $('#Order').serialize(),
								success : function(data) {
									if (data['status'] > 0) {
										layer.closeAll('loading');
										//myorderajax(gourl);
										window.location.href = "/pay/gotopay";
									} else {
										layer.closeAll('loading');
										$(":submit").removeAttr("disabled");
										layer.msg(data['info'], {
											icon : 5
										});
									}
								}
							});
						} else {
							myorderajax(gourl);
						}
					});
					function Clicksumbit() {
						if (sumbitinput.value == "") {

						} else {
							/* fbq('track', 'Purchase', {
							     content_ids:121,
							     value: 229,
							     currency: 'USD'
							 });fbq('track', 'Purchase', {
							     content_ids:104,
							     value: 149,
							     currency: 'USD'
							 });*/
						}
					}
					function myorderajax(gourl) {
						$.ajax({
							type : "post",
							url : gourl,
							dataType : 'json',
							data : $('#Order').serialize(),
							success : function(items) {
								if (items['status'] > 0) {
									layer.msg(items['info'], {
										icon : 6
									});
									window.location.href = "/pay/gotopay";
								} else {
									layer.msg(items['info'], {
										icon : 5
									});
								}
							}
						});
					}

					function fobidennumber(e, number) {
						var val = e.val();
						if (val.length > number) {
							e.val(val.substring(0, val.length - 1));
						}
					}
				</script>
				<script>
					function addcoupon() {
						layer.open({
							type : 2,
							shadeClose : true,
							area : [ '600px', '250px' ],
							title : '',
							shade : 0.4,
							content : "/order/addcoupon"
						});
					}

					$(function() {
						//$('select').searchableSelect();
					});

					/*if($("#c_name").val() != ""){
					 fbq('track', 'AddPaymentInfo');
					 };*/

					$(".each_payment .radio_a")
							.click(
									function() {
										if ($(
												".each_payment .each_radio .radio_a input")
												.is(':checked')) {
											$(this).parents(".radio_wrap")
													.addClass("on").siblings()
													.removeClass("on");
											$(this).parents(".each_radio")
													.next().slideDown().parent(
															".radio_wrap")
													.siblings().find(
															".down_wrap")
													.slideUp();
										} else {
											$(this).parents(".radio_wrap")
													.siblings().removeClass(
															"on");
											$(this).parents(".each_radio")
													.next().slideUp();
										}
										//fbq('track', 'AddPaymentInfo');
									});

					$(function() {
						var navH = $("#total_form").offset().top;
						$(window)
								.scroll(
										function() {
											var scroH = $(this).scrollTop();
											if (scroH >= navH) {
												$("#total_form").addClass(
														"fixed");
												if ($(window).height() < 575
														|| $("#total_form")
																.height() > $(
																window)
																.height()) {
													$("#total_form").addClass(
															"on");
												} else {
													$("#total_form")
															.removeClass("on");
												}
											} else if (scroH < navH) {
												$("#total_form").removeClass(
														"fixed");
											}
										})
					})
					$(".what_is_this").click(function() {
						{
							layer.open({
								type : 2,
								shadeClose : true,
								area : [ '600px', '300px' ],
								title : '',
								shade : 0.4,
								content : "/order/whatisthis"
							});
						}
					})

					var total_form_template = $('#total_form_template').html();
					var pagetemplate = $('#pagetemplate').html();
					function refreshCart2() {
						$.ajax({
							url : "${domain}/cart/getCart",
							type : "POST",
							contentType : "application/json",
							data : JSON.stringify({
								cid : '${custom.customid}'
							}),
							success : function(res) {
								var innerHtml = Mustache.render(pagetemplate,
										res);
								$('#pagecontrainer').html(innerHtml);
								var innerHtml1 = Mustache.render(
										total_form_template, res);
								$('#total_form').html(innerHtml1);
								if (parseInt(res.total) > 0) {
									$('#hcart').html(
											'<i class="num" id="hcartnumber">'
													+ res.total + '</i>');

								} else {
									$('#hcart').html('');
								}
							}
						});
					}

					refreshCart2();

					$('body')
							.on(
									'click',
									'.removecart',
									function() {
										var cartid = $(this).attr('data-id');
										var customid = '${custom.customid}';
										console.log(customid);

										if (customid != '') {
											$
													.ajax({
														url : "${domain}/cart/deleteCart",
														type : "POST",
														contentType : "application/json",
														data : JSON.stringify({
															cartid : cartid
														}),
														success : function(res) {
															refreshCart2();
														}
													});
										} else {
											window.location.href = "${domain}/jsp/mobile/login.jsp";
										}
									})

					$('body').on('click', '.sub_part', function() {
						var cartid = $(this).attr('data-id');
						var num = parseInt($(this).attr('data-num')) - 1;

						changeCart(cartid, num);
					})

					$('body').on('click', '.add_part', function() {
						var cartid = $(this).attr('data-id');
						var num = parseInt($(this).attr('data-num')) + 1;

						changeCart(cartid, num);
					})

					function changeCart(cartid, num) {
						var customid = '${custom.customid}';
						console.log(customid);

						if (customid != '') {
							$.ajax({
								url : "${domain}/cart/updateCart",
								type : "POST",
								contentType : "application/json",
								data : JSON.stringify({
									cartid : cartid,
									num : num
								}),
								success : function(res) {
									refreshCart2();
								}
							});
						} else {
							window.location.href = "${domain}/jsp/mobile/login.jsp";
						}

					}
					
					$.ajax({
						url : "${domain}/order/selectLastByCid",
						type : "POST",
						contentType : "application/json",
						data : JSON
								.stringify({
									customid : '${custom.customid}'
								}),
						success : function(res) {
							$('#name').val(res.receiver);
							$('#mobile').val(res.phone);
							$('#address').val(res.location);
						}
					});
					

					$('body')
							.on(
									'click',
									'#sumbitinput',
									function() {
										var name = $('#name').val();
										var mobile = $('#mobile').val();
										var address = $('#address').val();
										if (name == '' || mobile == ''
												|| address == '') {
											alert('信息填写完整');
											return;
										}
										$
												.ajax({
													url : "${domain}/cart/getCart",
													type : "POST",
													contentType : "application/json",
													data : JSON
															.stringify({
																cid : '${custom.customid}'
															}),
													success : function(res) {
														if (res.cartlist.length <= 0) {
															alert('需要选择商品');
															return;
														}
														for ( var i in res.cartlist) {
															var item = res.cartlist[i];
															var product = item.product;
															$
																	.ajax({
																		url : "${domain}/order/addOrder",
																		type : "POST",
																		contentType : "application/json",
																		data : JSON
																				.stringify({
																					customid : '${custom.customid}',
																					receiver : name,
																					location : address,
																					detaillocation : address,
																					phone : mobile
																				}),
																		success : function(
																				res) {
																			if (res.status == 'success') {
																				refreshCart2();
																				alert('购买成功');
																				window.location.href = "${domain}/jsp/mobile/index.jsp";
																			} else {
																				alert(res.msg);
																			}
																		}
																	});
														}

													}
												});

									})
				</script>
				<script src="${domain}/jsp/user/js/validSend.js"></script>

				<!--/Body-->


			</div>
		</form>
	</div>
</body>
</html>