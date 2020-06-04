---
layout: post
title:  "JQ加密密码到cookie"
date:   2019-04-08 09:00:00 +0800
categories: code
---
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>账号：</th>
			<td><input type="text" id="username" /></td>
		</tr>
		<tr>
			<th>密码：</th>
			<td><input type="text" id="password" /></td>
		</tr>
		<tr>
			<td><button onclick="setCookie();">保存</button></td>
			<td><button onclick="getCookie();">读取</button></td>
		</tr>
	</table>
</body>
<script type="text/javascript" src="http://lib.sinaapp.com/js/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="http://lib.sinaapp.com/js/jquery.cookie/jquery.cookie.js"></script>
<script type="text/javascript" src="https://raw.githubusercontent.com/yckart/jquery.base64.js/master/jquery.base64.js"></script>
<script type="text/javascript">
	function setCookie() { //设置cookie  
		var loginCode = $("#username").val(); //获取用户名信息  
		var pwd = $("#password").val(); //获取登陆密码信息  
		$.cookie("username", loginCode);//调用jquery.cookie.js中的方法设置cookie中的用户名  
		$.cookie("pwd", $.base64.encode(pwd));//调用jquery.cookie.js中的方法设置cookie中的登陆密码，并使用base64（jquery.base64.js）进行加密  
	}
	function getCookie() { //获取cookie  
		var loginCode = $.cookie("username"); //获取cookie中的用户名  
		var pwd = $.cookie("pwd"); //获取cookie中的登陆密码  
		if (loginCode) {//用户名存在的话把用户名填充到用户名文本框  
			$("#username").val(loginCode);
		}
		if (pwd) {//密码存在的话把密码填充到密码文本框  
			$("#password").val($.base64.decode(pwd));
		}
	}
</script>
</html>
```