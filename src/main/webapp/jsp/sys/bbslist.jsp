<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<title>会员列表</title>
<%@ include file="../common/table.jsp"%>
<div id="toolbar">
	<div class="btn-group">
		<button class="btn btn-default" id="delall">
			<i class="glyphicon glyphicon-trash">删除全部</i>
		</button>
	</div>
	<!--
	<div class="form-group">
		 <label class="control-label">性别：</label> <label class="radio-inline">
			<input type="radio" name="sex" value="男" /> 男
		</label> <label class="radio-inline"> <input type="radio" name="sex"
			value="女" /> 女
		</label> 
	</div>
	-->
</div>

<input type="file" name="myfile" id="myfile" style="display: none;" />

<script>
	//Demo
	var form;
	var isAdd = true;
	var dataid = '';
	layui.use('form', function() {
		form = layui.form;

	});

	var $objectTable = getTable(
			$('#tableCommon'),
			[
					{
						align : 'center',
						title : '序号',
						field : '',
						formatter : function(value, row, index) {
							return index + 1;
						}
					},
					{
						field : 'customname',
						title : '会员名',
						formatter : function(value) {
							return value == null ? '匿名用户' : value
						}
					},
					{
						field : 'email',
						title : '电子邮件'
					},
					{
						align : 'center',
						field : 'bbstype',
						title : '留言类型',
						formatter : function(value) {

							var type = '';
							switch (value) {
							case '1':
								type = '留言';
								break;
							case '2':
								type = '投诉';
								break;
							case '3':
								type = '询问';
								break;
							case '4':
								type = '售后';
								break;
							case '5':
								type = '求购';
								break;
							default:
								type = '留言';
								break;
							}
							return type;
						}
					},
					{
						field : 'subject',
						title : '主题'
					},
					{
						field : 'bbscontent',
						title : '留言内容'
					},
					{
						field : 'bbstime',
						title : '留言时间'
					},
					{
						align : 'center',
						field : 'bbsid',
						title : '阅读',
						formatter : function(value, row, index) {
							var html = '';

							if (row.status == '0') {
								html = "<button class='btn btn-info item-edit' data-id='"
					+ value + "'> 阅读 </button>";
							} else {
								html = "已阅";
							}
							return html;
						}
					},
					{
						align : 'center',
						field : 'bbsid',
						title : '删除',
						formatter : function(value) {
							return "<button class='btn btn-warning item-del' data-id='"
					+ value + "'> 删除 </button>";
						}
					} ], '${domain}/bbs/getBbs', {});

	initListener();

	function deleteUser(ids) {
		var msg = "您真的确定要删除吗？";
		if (confirm(msg) == true) {
			$.ajax({
				url : "${domain}/bbs/deleteBbsbyid",
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
				url : "${domain}/bbs/deleteBbsbyid",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					bbsid : id
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
			url : '${domain}/custom/importCustom',
			secureuri : false,
			cache : false,
			fileElementId : 'myfile',
			dataType : 'json',
			success : function(data, status) {

				alert("导入成功");
				$('#myfile').val('');
				$objectTable.bootstrapTable('refresh');

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

		$('input[type="file"]').on('change', function() {
			ajaxFileUpload();
		});

		$('#delall').on('click', function() {
			$.ajax({
				url : "${domain}/bbs/deleteallbbs",
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

		$('body').on(
				'click',
				'.item-edit',
				function() {
					dataid = $(this).attr('data-id');
					$.ajax({
						url : '${domain}/bbs/updateBbs',
						type : "POST",
						data : JSON.stringify({
							bbsid:dataid,
							status:'1'
						}),
						contentType : "application/json",
						success : function(res) {
							console.log(JSON.stringify(res));
							if (res.status == 'success') {
								alert('阅读成功');
				
								$tableObject.bootstrapTable('refresh');
							} else {
								alert(res.msg);
							}
						}
					});

				});

		$('body').on('click', '.item-del', function() {
			dataid = $(this).attr('data-id');
			deleteObject(dataid);
		});

		$('body').on('click', '#submitBtn', function() {
			editCustom('${domain}/custom/updateCustom', JSON.stringify({
				customid : dataid,
				customname : $('#customname').val(),
				password : $('#password').val(),
				status : $("input[name='status']:checked").val()
			}));
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
						<label class="layui-form-label">会员名称:</label>
						<div class="layui-input-block">
							<input type="text" name="customname" id="customname"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">会员密码:</label>
						<div class="layui-input-block">
							<input type="text" name="password" id="password"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">会员状态:</label>
						<div class="layui-input-block">
							<input type="radio" name="status" value="0" title="正常" checked>
							<input type="radio" name="status" value="1" title="冻结">
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