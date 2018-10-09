<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Footer-->
<!--footer-->
<div class="footer">
	<div class="top_footer">
		<div class="layouts">

			<div class="bottom_menu clearfix">
				<div class="each_one">
					<dl>
						<dt>个性化服务</dt>
						<dd>
							<a href="javascript:;" id="myinfo">我的账户</a>
						</dd>
					</dl>
				</div>
				<div class="each_one">
					<dl id="friendlink">
						<dt>友情链接</dt>
						<dd>
							<a href="https://www.wellymerck.com/en/terms-conditions">Terms
								&amp; conditions</a>
						</dd>
						<dd>
							<a href="https://www.wellymerck.com/en/privacy-policy">Privacy
								Policy</a>
						</dd>
						<dd>
							<a href="https://www.wellymerck.com/en/Warranty-and-Returns">Warranty
								&amp; Returns</a>
						</dd>
					</dl>
				</div>

			</div>

		</div>
	</div>
	<div class="copyright">© 2018 Welly Merck INC</div>
</div>

<!--end footer-->
<script>
	(function(i, s, o, g, r, a, m) {
		i['GoogleAnalyticsObject'] = r;
		i[r] = i[r] || function() {
			(i[r].q = i[r].q || []).push(arguments)
		}, i[r].l = 1 * new Date();
		a = s.createElement(o), m = s.getElementsByTagName(o)[0];
		a.async = 1;
		a.src = g;
		m.parentNode.insertBefore(a, m)
	})(window, document, 'script',
			'https://www.google-analytics.com/analytics.js', 'ga');

	ga('create', 'UA-78081006-1', 'auto');
	ga('send', 'pageview');
</script>
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

	$.ajax({
		url : "${domain}/friendlink/getall",
		type : "post",
		data : JSON.stringify({}),
		contentType : 'application/json',
		success : function(res) {
			var innerHtml = '<dt>友情链接</dt>';
			for ( var i in res) {
				var item = res[i];
				innerHtml += ' <dd><a href="'+item.linkurl+'" target="_blank">' + item.linkname
						+ '</a></dd>'
			}

			$('#friendlink').html(innerHtml);
		}
	})
	
	$('body').on('click','#myinfo',function(){
		if (customid != '') {
			window.location.href = "${domain}/jsp/user/myinfo.jsp";
		} else {
			window.location.href = "${domain}/jsp/user/login.jsp";
		}
	})
</script>
<!--/Footer-->

