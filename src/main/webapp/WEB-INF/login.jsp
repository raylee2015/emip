<%@ page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>综合管理系统</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0" />

<!-- basic styles -->

<link href="EmipUI_V2/assets/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="EmipUI_V2/assets/css/font-awesome.min.css" />

<!--[if IE 7]>
		  <link rel="stylesheet" href="EmipUI_V2/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

<!-- page specific plugin styles -->

<!-- fonts -->

<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />

<!-- ace styles -->

<link rel="stylesheet"
	href="EmipUI_V2/assets/css/ace.min.css" />
<link rel="stylesheet"
	href="EmipUI_V2/assets/css/ace-rtl.min.css" />

<!--[if lte IE 8]>
		  <link rel="stylesheet" href="EmipUI_V2/assets/css/ace-ie.min.css" />
		<![endif]-->

<!-- inline styles related to this page -->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
		<script src="EmipUI_V2/assets/js/html5shiv.js"></script>
		<script src="EmipUI_V2/assets/js/respond.min.js"></script>
		<![endif]-->
</head>
<style type="text/css">
HTML, body {
	height: 100%;
}
</style>
</head>
<body style="margin: 0px; background: #f6f6f6">
	<table style="width: 100%; height: 100%;">
		<tr>
			<td align="center"><div
					style="margin-bottom: 35px; text-align: center; width: 300px; font-family: 微软雅黑;">
					<h1>
						<b style="color: rgb(14, 45, 95);">综合管理平台</b>
					</h1>
				</div>
				<div id="content" class="panel panel-primary" title="登陆"
					style="width: 300px; height: 260px; padding: 10px;">
					<form action="<%=contextPath%>/login.do" method="post">
						<p></p>
						工 号:
						<p></p>
						<input id="userCode" name="userCode" type="text"
							style="height: 32px; width: 270px;"
							class="easyui-textbox" />
						<p></p>
						密 码:
						<p></p>
						<input id="userPassWord" name="userPassWord"
							type="password" style="height: 32px; width: 270px;"
							class="easyui-textbox" /><br> <br> <br>
						<input type="submit" value="登录"
							style="width: 270px; height: 32px" />
						<p></p>
					</form>
				</div></td>
		</tr>
	</table>
</body>
</html>
