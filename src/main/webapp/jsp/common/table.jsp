<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${domain}/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="${domain}/js/frame.js"></script>
<!-- Bootstrap Core JavaScript -->
<script type="text/javascript" src="${domain}/layui/layui.js"></script>
<script type="text/javascript" src="${domain}/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${domain}/js/bootstrap-table.js"></script>

<script type="text/javascript" src="${domain}/js/ajaxfileupload.js"></script>  

<script type="text/javascript" src="${domain}/js/bootstrap-table-zh-CN.js"></script>


<!-- Bootstrap Core CSS -->
<link href="${domain}/css/bootstrap.css" rel='stylesheet' type='text/css' />

<link href="${domain}/layui/css/layui.css" rel='stylesheet' type='text/css' />


<!-- bootstrap table css -->
<link href="${domain}/css/bootstrap-table.css" rel='stylesheet' type='text/css' />
<table id="tableCommon" data-classes="table table-hover "
	data-search="true" data-show-refresh="true" data-show-toggle="true"
	data-show-columns="true" data-toolbar="#toolbar"></table>
	
<style>
.fixed-table-body
{
	height: calc(100% - 110px);
}

.layui-form-label{
	width:120px;
}

.layui-input-block{
	margin-left:120px;
}

table td{
	word-break: break-all;
}

.layui-upload-img{
	width:50px;
	height:50px;
	margin-left:120px;
}
</style>
