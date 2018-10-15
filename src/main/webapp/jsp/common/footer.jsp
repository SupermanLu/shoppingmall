<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Footer-->
<!--footer-->
<div class="footer">
	<div class="top_footer">
		<div class="layouts">

			<div class="bottom_menu clearfix" id="helplist">
				<script id="helptemplate" type="text/x-tpl">
				{{#help}}
				<div class="each_one">
					<dl>
						<dt>{{text}}</dt>
						{{#helplist}}
						<dd>
							<a href="javascript:;" class="helpitem" data-id="{{helpid}}">{{helpname}}</a>
						</dd>
						{{/helplist}}
					</dl>
				</div>
				{{/help}}
				</script>
				
			</div>

		</div>
	</div>
	<div class="copyright">© 2018 Welly Merck INC</div>
</div>

<!--end footer-->

<script src="${domain}/jsp/user/js/cityjson"></script>
<script src="${domain}/jsp/user/js/dfpay.js"></script>

<p id="nocookiets"
	style="display: none; position: fixed; left: 0; top: 0; width: 100%; text-align: center; line-height: 1.5; padding: 15px 0; color: #f00; z-index: 999999; background: #fff; box-shadow: 0 0 15px rgba(0, 0, 0, .2);">
	Please open cookie in browser settings, otherwise you may not finish
	the shopping correctly.</p>
<script>
	if (!(document.cookie || navigator.cookieEnabled)) {
		$('#nocookiets').css('display', 'block');
	}


	$('body').on('click', '#myinfo', function() {
		if (customid != '') {
			window.location.href = "${domain}/jsp/user/myinfo.jsp";
		} else {
			window.location.href = "${domain}/jsp/user/login.jsp";
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
						+'<dl>'
						+'<dt>友情链接</dt>';
					for ( var i in res) {
						var item = res[i];
						innerHtml +='<dd><a href="'+item.linkurl+'" target="_blank">'
								+ item.linkname + '</a></dd>';
					}

					innerHtml+='</dl></div>';
					$('#helplist').append(innerHtml);
				}
			})
		}
	})
	
	$('body').on('click','.helpitem',function(){
		window.location.href = "${domain}/jsp/user/detail.jsp?hid="+$(this).attr('data-id');
	})
</script>
<!--/Footer-->

