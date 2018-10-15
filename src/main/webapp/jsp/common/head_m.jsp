
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Header-->
<script>
    //使移动端a:active伪类生效
    document.body.addEventListener('touchstart', function () {},false);
    $(document).ready(function() {
        $(".top_fixed_wrap .close").click(function(){
            $(this).parents(".top_fixed_wrap").slideUp();
        });
    });
</script>
<style>.header .cart_btn .qq {
      position: fixed;
    top: 21px;
    left: 60px;
    background:url(${domain}/jsp/mobile/images/header_icon1-3.png) no-repeat center center;
      width: 2.2rem;
    height: 2.2rem;
    background-size: 100% 100%;

}

.nav{
    overflow-y: auto;
}
</style>

<div class="header">
    <div class="logo">
        <a href="${domain}/jsp/mobile/index.jsp">
            <img src="${domain}/jsp/mobile/images/58e85477e55c0.png">
        </a>
    </div>
    <div class="nav_wrap">
        <div class="layouts">
            <div class="total_btn btn-nav">
                <span class="icon-bar top"></span>
                <span class="icon-bar middle"></span>
                <span class="icon-bar bottom"></span>
            </div>
            <div class="nav">
                <ul class="clearfix" id="menu">
                    <li class="on">
                        <a href="https://www.wellymerck.com/" class="per">HOME</a>
                    </li>
                    <li class="">
                            <a href="https://www.wellymerck.com/watch/men" class="per">MEN<span class="line"><i></i></span></a>
                        </li><li class="">
                            <a href="https://www.wellymerck.com/watch/women" class="per">WOMEN<span class="line"><i></i></span></a>
                        </li>                    <li class="">
                        <a href="https://www.wellymerck.com/accessories" class="per">ACCESSORIES<span class="line"><i></i></span></a>
                    </li>
                    <li class="">
                        <a href="https://www.wellymerck.com/Customization" class="per">CUSTOMIZATION<span class="line"><i></i></span></a>
                    </li>
                    <li class="">
                        <a href="https://www.wellymerck.com/about-us" class="per">ABOUT US<span class="line"><i></i></span></a>
                    </li>
                </ul>
            </div>
            <div class="cart_btn">
				<a href="http://www.baidu.com" target="_blank" class="qq"></a>
			</div>
            <div class="cart_btn">
                <a href="javascript:;" class="go_cart" id="hcart"></a>
            </div>
            <div class="header_member">
                <a href="javascript:;" id="personal">
                    <span class="mem_btn"><em class="person"></em><i class="down"></i></span>
                </a>
            </div>
        </div>
    </div>
</div>
<script>


(function browserRedirect(){
    var sUserAgent = navigator.userAgent.toLowerCase();
    var bIsIpad = sUserAgent.match(/ipad/i) == 'ipad';
    var bIsIphone = sUserAgent.match(/iphone os/i) == 'iphone os';
    var bIsMidp = sUserAgent.match(/midp/i) == 'midp';
    var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == 'rv:1.2.3.4';
    var bIsUc = sUserAgent.match(/ucweb/i) == 'web';
    var bIsCE = sUserAgent.match(/windows ce/i) == 'windows ce';
    var bIsWM = sUserAgent.match(/windows mobile/i) == 'windows mobile';
    var bIsAndroid = sUserAgent.match(/android/i) == 'android';

    if(!(bIsIpad || bIsIphone || bIsMidp || bIsUc7 || bIsUc || bIsCE || bIsWM || bIsAndroid) ){
      window.location.href = '${domain}/jsp/user/index.jsp';
    }
  })();
var customid = '${custom.customid}';
console.log(customid);

if (customid != '') {
	$('#login')
			.html(
					'<li><a id="logout" href="javascript:;" class="each">注销</a></li><li><a href="${domain}/jsp/mobile/myinfo.jsp" class="each">账户信息</a></li>')
} else {
	$('#login')
			.html(
					' <li><a href="${domain}/jsp/mobile/login.jsp" class="each">登录</a></li>')
}

$('body').on('click', '#logout', logout);

$('body').on('click', '#hcart', function() {
	if (customid != '') {
		window.location.href = "${domain}/jsp/mobile/cart.jsp";
	} else {
		window.location.href = "${domain}/jsp/mobile/login.jsp";
	}
});

$('body').on('click','#personal',function(){
	if (customid != '') {
		window.location.href = "${domain}/jsp/mobile/myinfo.jsp";
	} else {
		window.location.href = "${domain}/jsp/mobile/login.jsp";
	}
})

function logout() {
	$.ajax({
		url : "${domain}/custom/logout",
		type : "POST",
		contentType : "application/json",
		success : function(res) {
			if (res.status == "success") {
				window.location.href = "${domain}/jsp/mobile/login.jsp";
			}
		}
	});
}

$
		.ajax({
			url : '${domain}/category/getcategorybypid',
			type : 'post',
			contentType : 'application/json',
			data : JSON.stringify({
				parentcateid : ''
			}),
			success : function(res) {
				var cateid = GetQueryString('cateid');
				var cls = '';
				if (cateid == null) {
					cls = 'on';
				}
				var innerHtml = '<li class="'+cls+'"><a href="${domain}/jsp/mobile/index.jsp" class="per">首页<span class="line"><i></i></span></a></li>';
				for ( var i in res) {
					var item = res[i];
					var itemCls = '';
					if (cateid == item.cateid) {
						itemCls = 'on';
					}
					innerHtml += '<li class="'+itemCls+'"><a href="'
							+ '${domain}/jsp/mobile/product.jsp?cateid='
							+ item.cateid + '" class="per">'
							+ item.catename
							+ '<span class="line"><i></i></span></a></li>';
				}
				if(cateid=='scoredetail'){
					scoredetailCls='on';
				}
				else{
					scoredetailCls='';
				}
				if(cateid=='bbs'){
					bbsCls='on';
				}
				else{
					bbsCls='';
				}
				innerHtml += '<li class="'+scoredetailCls+'"><a href="${domain}/jsp/mobile/scoredetail.jsp?cateid=scoredetail" class="per">积分规则<span class="line"><i></i></span></a></li>';
				innerHtml += '<li class="'+bbsCls+'"><a href="${domain}/jsp/mobile/bbs.jsp?cateid=bbs" class="per">留言专区<span class="line"><i></i></span></a></li>';
				innerHtml += '<li class="nav-item"><a href="http://www.baidu.com" class="per" target="_blank">官网首页<span class="line"><i></i></span></a></li>';
				innerHtml += '<li class="nav-item"><a href="http://www.baidu.com" class="per" target="_blank">联系我们<span class="line"><i></i></span></a></li>';
				$('#menu').html(innerHtml);
			}
		});

$(".header_member .mem_btn").click(function() {
	$(this).next().slideToggle();
})
$(".header .show_wrap").click(function() {
	$(this).next().slideToggle();
})
/**
 * 自动将form表单封装成json对象
 */
$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

function GetQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);//search,查询？后面的参数，并匹配正则    
	if (r != null)
		return unescape(r[2]);
	return null;
}


function refreshCart(){
	$.ajax({
		url : "${domain}/cart/getCart",
		type : "POST",
		contentType : "application/json",
		data:JSON.stringify({
			cid:'${custom.customid}'
		}),
		success : function(res) {
			if(parseInt(res.total)>0){
				$('#hcart').html('<i class="num" id="hcartnumber">'+res.total+'</i>');
			}
		}
	});
}

refreshCart();

function addCart(pid){
	var customid = '${custom.customid}';
	console.log(customid);

	if (customid != '') {
		$.ajax({
			url : "${domain}/cart/addCart",
			type : "POST",
			contentType : "application/json",
			data:JSON.stringify({
				pid:pid,
				cid:'${custom.customid}',
				num:1
			}),
			success : function(res) {
				refreshCart();
			}
		});
	} else {
		window.location.href = "${domain}/jsp/mobile/login.jsp";
	}
	
}

$(document).ready(function() {

    $(".total_btn").click(function(){
        $(this).toggleClass("animated1")
        $(this).next().toggleClass("on");
    });
    $(window).scroll(function(){
        if($(this).scrollTop()>50){
            $('.header').addClass('on').slideDown(500);
            $('.page_container').addClass('on');
        }
        else {
        }});
});
</script>
<!--/Header-->