<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Validation</title>
</head>
<script type="text/javascript">
    function checkLogin() {
        var form = document.loginForm;
        
        // 아이디가 영문 소문자, 대문자, 숫자만 포함하도록 검사
        for (var i = 0; i < form.id.value.length; i++) {
            var ch = form.id.value.charAt(i);
            if (!((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') || (ch >= '0' && ch <= '9'))) {
                alert("아이디는 영문 소문자, 대문자, 숫자만 입력 가능 합니다!");
                form.id.select();
                return false;
            }
        }

        // 비밀번호는 숫자만 입력 가능
        if (isNaN(form.passwd.value)) {
            alert("비밀번호는 숫자만 입력 가능 합니다!");
            form.passwd.select();
            return false;
        }

        // 모든 유효성 검사를 통과하면 폼을 제출
        form.submit();
    }
</script>
<body>
    <form name="loginForm" action="validation04_process.jsp" method="post">
        <p> 아이디 : <input type="text" name="id">
        <p> 비밀번호 : <input type="password" name="passwd">
        <p> <input type="submit" value="전송" onclick="return checkLogin()">
    </form>
</body>
</html>
