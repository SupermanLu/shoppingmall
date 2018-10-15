<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<title>订单列表</title>
<%@ include file="../common/table.jsp"%>
<div id="toolbar">
	<div class="btn-group">
		<button class="btn btn-default" id="exportExcel">
			<i class="glyphicon glyphicon-export">导出Excel</i>
		</button>
		<button class="btn btn-default" id="search">
			<i class="glyphicon glyphicon-search">搜索</i>
		</button>
	</div>
	<div class="layui-form">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">买家用户名</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" id="searchname" placeholder="">
				</div>
				<label class="layui-form-label">订单编号</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" id="searchno"
						placeholder="">
				</div>
				<label class="layui-form-label">支付时间</label>
				<div class="layui-input-inline">
					<input type="text" name="start_time" class="layui-input"
						id="start_time" placeholder="开始时间(支付时间)">
				</div>
				<div class="layui-input-inline">
                        <input
						type="text" name="end_time" class="layui-input" id="end_time"
						placeholder="结束时间(支付时间)">
				</div>
				
			</div>
			
			<div class="layui-inline">		
				<label class="layui-form-label" id="total" style="width:auto;">交易总额:0</label>
			</div>

		</div>
	</div>
</div>
<style>
.layui-upload-img{
	width:384px;
	height:90px;
	margin-left:120px;
}
</style>
<input type="file" name="myfile" id="myfile" style="display: none;" />

<script>
	//Demo
	var form;
	var isAdd = true;
	var dataid = '';
	var path='';
	layui.use([ 'form', 'laydate' ], function() {
		form = layui.form;
		var laydate = layui.laydate;
		//日期时间范围
		var nowTime = new Date().valueOf();
		var max = null;

		var start = laydate.render({
			elem : '#start_time',
			type : 'datetime',
			btns : [ 'clear', 'confirm' ],
			done : function(value, date) {
				endMax = end.config.max;
				end.config.min = date;
				end.config.min.month = date.month - 1;
			}
		});
		var end = laydate.render({
			elem : '#end_time',
			type : 'datetime',
			done : function(value, date) {
				if ($.trim(value) == '') {
					var curDate = new Date();
					date = {
						'date' : curDate.getDate(),
						'month' : curDate.getMonth() + 1,
						'year' : curDate.getFullYear()
					};
				}
				start.config.max = date;
				start.config.max.month = date.month - 1;
			}
		});

	});

	var $objectTable = $('#tableCommon')
	.bootstrapTable(
			{
				columns : [
					{
						align : 'center',
						title : '序号',
						field : '',
						formatter : function(value, row, index) {
							return index + 1;
						}
					},
					{
						field : 'orderno',
						title : '订单号'
						
					},
					{
						field : 'customname',
						title : '买家用户名'
					},
					{
						field : 'pname',
						title : '商品'
					},
					{
						field : 'preprice',
						title : '单价'
					},
					{
						field : 'num',
						title : '数量'
					},
					{
						field : 'postage',
						title : '邮费'
					},
					{
						field : 'paytime',
						title : '支付时间'
					},
					{
						align : 'center',
						field : 'orderid',
						title : '发货',
						formatter : function(value,row,index) {
							return row.status=='0'?"<button class='btn btn-info item-fh' data-id='"
					+ value + "'> 发货 </button>":"<button class='btn btn-info item-ch' data-id='"
						+ value + "'> 撤回发货状态发货 </button>";
						}
					},
					{
						align : 'center',
						field : 'orderid',
						title : '详情',
						formatter : function(value) {
							return "<button class='btn btn-warning item-detail' data-id='"
					+ value + "'> 详情 </button>";
						}
					} ],
				url : '${domain}/order/getOrder',
				search : false,
				showToggle : false,
				cardView : false,
				pagination : true,
				sidePagination : 'server',
				pageList : [ 5, 10, 20, 50 ],
				queryParams : function(params) {
					params.customname = $('#searchname').val();
					params.searchno = $('#searchno').val();
					params.begintime = $('#start_time').val();
					params.endtime = $('#end_time').val();
					return params;
				}
			});
	
	$.ajax({
		url : "${domain}/order/selectTotal",
		type : "POST",
		contentType : "application/json",
		success : function(data) {
			$('#total').html('交易总额:'+data.total+'元');
		}
	});
	

	initListener();

	function deleteUser(ids) {
		var msg = "您真的确定要删除吗？";
		if (confirm(msg) == true) {
			$.ajax({
				url : "${domain}/note/deletecustombyids",
				type : "POST",
				contentType : "application/x-www-form-urlencoded",
				data : {
					ids : ids
				},
				success : function(data) {
					alert('删除成功');
					//重新加载记录
					//重新加载数据
					$objectTable.bootstrapTable('refresh');
				}
			});
		}

	}

	function deleteObject(id) {
		var msg = "您真的确定要删除吗？";
		if (confirm(msg) == true) {
			$.ajax({
				url : "${domain}/swip/deleteSwipbyid",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					swipid : id
				}),
				success : function(data) {
					alert('删除成功');
					//重新加载记录
					//重新加载数据
					$objectTable.bootstrapTable('refresh');
				}
			});
		}
	}

	function editCustom(url, data) {
		$.ajax({
			url : url,
			type : "POST",
			data : data,
			contentType : "application/json",
			success : function(res) {
				console.log(JSON.stringify(res));
				if (res.status == 'success') {
					alert((isAdd ? '新增' : '修改') + '成功');
					$('#myModal').modal('toggle');
					$tableObject.bootstrapTable('refresh');
				} else {
					alert(res.msg);
				}
			}
		});
	}

	function ajaxFileUpload() {
		$.ajaxFileUpload({
			url : '${domain}/swip/upload',
			secureuri : false,
			cache : false,
			fileElementId : 'myfile',
			dataType : 'json',
			success : function(data, status) {

			console.log(data);
			$('#uploadImg').attr('src','${domain}/'+data.msg);
			path='${domain}/'+data.msg;
			$('#myfile').val('');
			},
			error : function(data, status, e) {

				console.log(JSON.stringify(e));
				alert(data.msg);
				$('#myfile').val('');

			}
		});
		$('input[type="file"]').on('change', function() {
			ajaxFileUpload();
		})
	}

	function initListener() {
		$('#export').on('click', function() {
			$('#myfile').click();
		});
		
		$('#exportExcel').on('click', function() {
			window.location.href="${domain}/order/export";
		});
		
		
		
		$('body').on('click','#uploadBtn',function(){
			console.log(1);
			$('#myfile').click();
		})

		$('input[type="file"]').on('change', function() {
			ajaxFileUpload();
		});

		$('#delall').on('click', function() {
			$.ajax({
				url : "${domain}/category/deleteallcustom",
				type : "POST",
				data : {},
				success : function(data) {
					alert('删除成功');
					//重新加载记录
					//重新加载数据
					$objectTable.bootstrapTable('refresh');
				}
			});
		});

		$('#delsel').on('click', function() {
			//获取所有被选中的记录
			var rows = $objectTable.bootstrapTable('getSelections');
			if (rows.length == 0) {
				alert("请先选择要删除的记录!");
				return;
			}
			var ids = '';
			for (var i = 0; i < rows.length; i++) {
				ids += rows[i]['customid'] + ",";
			}
			ids = ids.substring(0, ids.length - 1);
			deleteUser(ids);
		});

		$('body').on('click', '#add', function() {

			
			$('#myModal').modal('toggle');
			$('#myModalLabel').html('新增');
			isAdd = true;

			$('#swiplink').val('');
			$('#ordernum').val('');
			path='';
			$('#uploadImg').attr('src','');
			

			form.render();

		});
		
		$('body').on('click','.item-fh',function(){
			dataid = $(this).attr('data-id');
			$.ajax({
				url : "${domain}/order/updateOrder",
				type : "POST",
				data : JSON.stringify({
					orderid:dataid,
					status:'1'
				}),
				contentType : "application/json",
				success : function(res) {
					console.log(JSON.stringify(res));
					if (res.status == 'success') {
						alert('发货成功');
						
						$tableObject.bootstrapTable('refresh');
					} else {
						alert(res.msg);
					}
				}
			});
		})
		
		$('body').on('click','.item-ch',function(){
			dataid = $(this).attr('data-id');
			$.ajax({
				url : "${domain}/order/updateOrder",
				type : "POST",
				data : JSON.stringify({
					orderid:dataid,
					status:'0'
				}),
				contentType : "application/json",
				success : function(res) {
					console.log(JSON.stringify(res));
					if (res.status == 'success') {
						alert('撤回成功');
						
						$tableObject.bootstrapTable('refresh');
					} else {
						alert(res.msg);
					}
				}
			});
		})
		
		
		$('body').on('click', '#search', function() {
			$objectTable.bootstrapTable('refresh');
		})
		
		
		$('body').on(
				'click',
				'.item-detail',
				function() {
					dataid = $(this).attr('data-id');
					$('#myModal').modal('toggle');
					$('#myModalLabel').html('订单详情');
					

					$.ajax({
						url : '${domain}/order/getOrderbyid',
						type : "POST",
						contentType : "application/json",
						data : JSON.stringify({
							orderid : dataid
						}),
						success : function(data) {
							$('#customname').val(data.customname);
							$('#pname').val(data.pname);
							$('#preprice').val(data.preprice);
							$('#num').val(data.num);
							$('#paytime').val(data.paytime);
							$('#receiver').val(data.receiver);
							$('#location').val(data.location);
							$('#mobile').val(data.phone);
							$('#deliverytime').val(data.deliverytime);
	
							
						}
					})

				});

		$('body').on(
				'click',
				'.item-edit',
				function() {
					dataid = $(this).attr('data-id');
					$('#myModal').modal('toggle');
					$('#myModalLabel').html('修改');
					isAdd = false;

					$('input:radio[name=issy]').prop('checked', 'false');
					form.render('radio');

					$.ajax({
						url : '${domain}/swip/getSwipbyid',
						type : "POST",
						contentType : "application/json",
						data : JSON.stringify({
							swipid : dataid
						}),
						success : function(data) {
							$('#swiplink').val(data.swiplink);
							$('#ordernum').val(data.ordernum);
							$('#uploadImg').attr('src',data.swipimgurl);
						}
					})

				});

		$('body').on('click', '.item-del', function() {
			dataid = $(this).attr('data-id');
			deleteObject(dataid);
		});

		$('body').on('click', '#submitBtn', function() {
			if (isAdd) {
				editCustom('${domain}/swip/addSwip', JSON.stringify({
					swiplink : $('#swiplink').val(),
					ordernum:$('#ordernum').val(),
					swipimgurl:path
				}));
			} else {
				editCustom('${domain}/swip/updateSwip', JSON.stringify({
					swipid : dataid,
					swiplink : $('#swiplink').val(),
					ordernum:$('#ordernum').val(),
					swipimgurl:path
				}));
			}
		})

	}
</script>


<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style='z-index: 9999;'>
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">修改</h4>
			</div>
			<div class="modal-body">
				<form class="layui-form" action="" method="post">
					<div class="layui-form-item">
						<label class="layui-form-label">用户:</label>
						<div class="layui-input-block">
							<input type="text" name="customname" id="customname"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商品:</label>
						<div class="layui-input-block">
							<input type="text" name="pname" id="pname"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label">单价:</label>
						<div class="layui-input-block">
							<input type="text" name="preprice" id="preprice"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">数量:</label>
						<div class="layui-input-block">
							<input type="text" name="num" id="num"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">下单时间:</label>
						<div class="layui-input-block">
							<input type="text" name="paytime" id="paytime"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">收货人:</label>
						<div class="layui-input-block">
							<input type="text" name="receiver" id="receiver"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">详细收获地址:</label>
						<div class="layui-input-block">
							<input type="text" name="location" id="location"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">联系电话:</label>
						<div class="layui-input-block">
							<input type="text" name="mobile" id="mobile"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">发货时间:</label>
						<div class="layui-input-block">
							<input type="text" name="deliverytime" id="deliverytime"
								autocomplete="off" class="layui-input" disabled>
						</div>
					</div>
				

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>