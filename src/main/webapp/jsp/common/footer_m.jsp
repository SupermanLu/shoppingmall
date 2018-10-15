<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#helplist .each_one{
float:left;
margin:10px 10px;
width:calc(50% - 22px - 1rem);
padding: 1rem 0.5rem;
    border: 1px solid #333;
    overflow: hidden;
}

.footer .bottom_menu .each_one .dt_title{
	height:3rem;
	line-height:3rem;
	margin-bottom: 0;
}

.footer .bottom_menu .each_one .dt_title i{
margin-top:1.25rem;
}
</style>

<!--Footer-->
<div class="footer">
    <div class="top_footer">
        
        <div class="back_to_top_wrap">
            <a href="javascript:void(0)" class="back_to_top"><i></i></a>
        </div>
        <div class="layouts">
            <div class="bottom_menu clearfix" id="helplist">
            <script id="helptemplate" type="text/x-tpl">
				{{#help}}
				<div class="each_one">
                    <div class="dt_title" style="cursor:pointer;">{{text}}<i></i></div>
                    <div class="dd_cont">
						{{#helplist}}
                        <div class="dd_each">
<a href="javascript:;" class="helpitem" data-id="{{helpid}}">{{helpname}}</a>
</div>
						{{/helplist}}
                     </div>
                </div>
				{{/help}}
				</script>
                
            </div>
		

        </div>
    </div>
    <div class="copyright">© 2018 Welly Merck INC</div>
</div>

<script>
	$("body").on('click','.bottom_menu .dt_title',function(){
		$(this).toggleClass("on");
		$(this).siblings(".dd_cont").slideToggle();
	});
    $('.back_to_top').stop().on("click",function(){
        $('html,body').animate({scrollTop: 0},400);
    });
	$(".language_switch .show_wrap").click(function(){
		$(this).next().slideToggle();
	})
</script>

<p id="nocookiets" style="display:none;position: fixed;left: 0;top: 0; width: 100%;text-align: center;line-height: 1.5;padding: 15px 0;color: #f00;z-index: 999999;background: #fff;box-shadow: 0 0 15px rgba(0,0,0,.2);">
    Please open cookie in browser settings, otherwise you may not finish the shopping correctly.</p>
<script>
    if(!(document.cookie || navigator.cookieEnabled)){
        $('#nocookiets').css('display','block');
    }
    
    $('body').on('click', '#myinfo', function() {
		if (customid != '') {
			window.location.href = "${domain}/jsp/mobile/myinfo.jsp";
		} else {
			window.location.href = "${domain}/jsp/mobile/login.jsp";
		}
	})

	$.ajax({
		url : '${domain}/help/selectOptionList',
		type : 'post',
		contentType : 'application/json',
		success : function(res) {
			console.log(res);
			var result = {
				help : res
			};
			var innerHtml=Mustache.render($('#helptemplate').html(),result);
			$('#helplist').html(innerHtml);

			$.ajax({
				url : "${domain}/friendlink/getall",
				type : "post",
				data : JSON.stringify({}),
				contentType : 'application/json',
				success : function(res) {
					var innerHtml =  '<div class="each_one">'
						+'<div class="dt_title" style="cursor:pointer;">友情链接<i></i></div>'
						+'<div class="dd_cont">';
					for ( var i in res) {
						var item = res[i];

								
						innerHtml+= '<div class="dd_each">'
						+'<a href="'+item.linkurl+'" target="_blank">'+item.linkname+'</a></div>';
						
					}

					innerHtml+='</div></div>';
					$('#helplist').append(innerHtml);
				}
			})
		}
	})
	
	$('body').on('click','.helpitem',function(){
		window.location.href = "${domain}/jsp/mobile/detail.jsp?hid="+$(this).attr('data-id');
	})
	

    $('.back_to_top').stop().on("click",function(){
        $('html,body').animate({scrollTop: 0},400);
    });
	$(".language_switch .show_wrap").click(function(){
		$(this).next().slideToggle();
	})
</script>


<!--/Footer-->

