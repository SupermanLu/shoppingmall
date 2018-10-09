<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<title>友情链接列表</title>
<%@ include file="../common/table.jsp"%>
<div id="toolbar">
	<div class="btn-group">
		<button class="btn btn-default" id="add">
			<i class="glyphicon glyphicon-plus">新增链接</i>
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
						field : 'linkname',
						title : '友情链接名称'
					},
					{
						field : 'linkurl',
						title : '友情链接地址'
					},
					{
						field : 'ordernum',
						title : '排序'
					},
					{
						align : 'center',
						field : 'linkid',
						title : '修改',
						formatter : function(value) {
							return "<button class='btn btn-info item-edit' data-id='"
					+ value + "'> 修改 </button>";
						}
					},
					{
						align : 'center',
						field : 'linkid',
						title : '删除',
						formatter : function(value) {
							return "<button class='btn btn-warning item-del' data-id='"
					+ value + "'> 删除 </button>";
						}
					} ], '${domain}/friendlink/getFriendlink', {});

	initListener();

	function deleteUser(ids) {
		var msg = "您真的确定要删除吗？";
		if (confirm(msg) == true) {
			$.ajax({
				url : "${domain}/friendlink/deletecustombyids",
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
				url : "${domain}/friendlink/deleteFriendlinkbyid",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					linkid : id
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
			url : '${domain}/friendlink/importCustom',
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
				url : "${domain}/friendlink/deleteallcustom",
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

			$('#linkname').val('');
			$('#linkurl').val('');
			$('#ordernum').val('');

		});

		$('body').on('click', '.item-edit', function() {
			dataid = $(this).attr('data-id');
			$('#myModal').modal('toggle');
			$('#myModalLabel').html('修改');
			isAdd = false;

			$.ajax({
				url : '${domain}/friendlink/getFriendlinkbyid',
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					linkid : dataid
				}),
				success : function(data) {
					$('#linkname').val(data.linkname);
					$('#linkurl').val(data.linkurl);
					$('#ordernum').val(data.ordernum);
				}
			})

		});

		$('body').on('click', '.item-del', function() {
			dataid = $(this).attr('data-id');
			deleteObject(dataid);
		});

		$('body').on('click', '#submitBtn', function() {
			if (isAdd) {
				editCustom('${domain}/friendlink/addFriendlink', JSON.stringify({
					linkname : $('#linkname').val(),
					linkurl : $('#linkurl').val(),
					ordernum : $('#ordernum').val(),
				}));
			} else {
				editCustom('${domain}/friendlink/updateFriendlink', JSON.stringify({
					linkid : dataid,
					linkname : $('#linkname').val(),
					linkurl : $('#linkurl').val(),
					ordernum : $('#ordernum').val(),
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
						<label class="layui-form-label">链接名称:</label>
						<div class="layui-input-block">
							<input type="text" name="linkname" id="linkname"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">链接地址:</label>
						<div class="layui-input-block">
							<input type="text" name="linkurl" id="linkurl" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">排序:</label>
						<div class="layui-input-block">
							<input type="number" name="ordernum" id="ordernum"
								autocomplete="off" class="layui-input">
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