<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Validation</title>
</head>
<script type="text/javascript">
	function checkLogin() {
		var form = document.loginForm;
		if (form.id.value == "") {
			alert("아이디를 입력해주세요.");
			form.id.focus();
			return false;
		} else if (form.passwd.value == "") {
			alert("비밀번호를 입력해주세요");
			form.passwd.focus();
			return false;
		}
		// 검증이 통과되면 폼을 제출합니다.
		return true;
	}
</script>
<body>
	<form name="loginForm" action="validation02_process.jsp" method="post" onsubmit="return checkLogin();">
		<p> 아이디 : <input type="text" name="id">
		<p> 비밀번호 : <input type="password" name="passwd">
		<p> <input type="submit" value="전송">
	</form>
</body>
</html>
