<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Validation</title>
</head>
<script type="text/javascript">
    function checkMember() {
        var regExpId = /^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]/;
        var regExpName = /^[가-힣]+$/;
        var regExpPasswd = /^[0-9]{6,20}$/;  // 숫자만 허용하는 정규 표현식으로 수정
        var regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;
        var regExpEmail = /^[0-9a-zA-Z]([-._]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-._]?[0-9a-zA-Z])*\.[a-zA-Z]{2,6}$/i;

        var form = document.Member;

        var id = form.id.value;
        var name = form.name.value;
        var passwd = form.passwd.value;
        var phone = form.phone1.value + "-" + form.phone2.value + "-" + form.phone3.value;
        var email = form.email.value;

        if (!regExpId.test(id)) {
            alert("아이디는 문자로 시작해주세요!");
            form.id.select();
            return false;  // 폼 제출을 막기 위해 false 반환
        }
        if (!regExpName.test(name)) {
            alert("이름은 한글만 입력해주세요!");
            return false;  // 폼 제출을 막기 위해 false 반환
        }
        if (!regExpPasswd.test(passwd)) {
            alert("비밀번호는 6자이상 20자 이하의 숫자만 입력해주세요!");
            return false;  // 폼 제출을 막기 위해 false 반환
        }
        if (!regExpPhone.test(phone)) {
            alert("연락처 입력을 확인해주세요!");
            return false;  // 폼 제출을 막기 위해 false 반환
        }
        if (!regExpEmail.test(email)) {
            alert("이메일 입력을 확인해주세요!");
            return false;  // 폼 제출을 막기 위해 false 반환
        }

        return true;  // 모든 검사를 통과하면 true를 반환하여 폼을 제출
    }
</script>
<body>
    <form name="Member" action="validation05_process.jsp" method="post" onsubmit="return checkMember()">
        <p> 아이디 : <input type="text" name="id"> <input type="button" value="아이디 중복 검사"> 		
        <p> 비밀번호 : <input type="password" name="passwd">
        <p> 이름 : <input type="text" name="name">
        <p> 연락처 : <select name="phone1">
            <option value="010">010</option>
            <option value="011">011</option>
            <option value="016">016</option>
            <option value="017">017</option>
            <option value="019">019</option>
            <option value="070">070</option>
        </select> 
        - <input type="text" maxlength="3" size="3" name="phone2"> - <input type="text" maxlength="4" size="4" name="phone3">
        <p> 이메일 : <input type="text" name="email">
        <p> <input type="submit" value="전송">
    </form>
</body>
</html>
