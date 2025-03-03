<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Validation</title>
</head>
<script type="text/javascript">
	function checkLogin() {
		var form = document.loginForm;
		
		// 아이디 검증
		if (form.id.value.length < 4 || form.id.value.length > 12) {
			alert("아이디는 4~12자 이내로 입력 가능합니다!");
			form.id.select();
			return false;  // 폼 전송을 막음
		} 
		
		// 비밀번호 검증
		if (form.passwd.value.length < 4) {
			alert("비밀번호는 4자 이상으로 입력해야 합니다!");
			form.passwd.select();
			return false;  // 폼 전송을 막음
		}
		
		// 검증이 통과되면 폼을 제출합니다.
		return true;
	}
</script>
<body>
	<form name="loginForm" action="validation02_process.jsp" method="post" onsubmit="return checkLogin();">
		<p> 아이디 : <input type="text" name="id">
		<p> 비밀번호 : <input type="password" name="passwd">
		<p> <input type=submit value="전송">
	</form>
</body>
</html>
