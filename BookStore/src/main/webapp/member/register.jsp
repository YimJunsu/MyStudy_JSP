<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
  <title>회원가입</title>
  <style>
    body {
      background-color: #f3f4f6;
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 60px 0;
    }
    .register-container {
      background-color: white;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 8px 16px rgba(0,0,0,0.1);
      width: 460px;
    }
    h2 {
      text-align: center;
      margin-bottom: 24px;
      color: #333;
    }
    input[type="text"], input[type="password"], input[type="email"] {
      width: 100%;
      padding: 12px;
      margin: 8px 0 16px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      transition: 0.3s;
    }
    input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
      border-color: #6366f1;
      outline: none;
    }
    button, .btn-small {
      width: 100%;
      padding: 12px;
      background-color: #6366f1;
      border: none;
      color: white;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
      transition: 0.3s;
    }
    button:hover, .btn-small:hover {
      background-color: #4f46e5;
    }
    .btn-small {
      width: auto;
      padding: 10px 16px;
      font-size: 14px;
      margin-top: 4px;
      margin-left: 8px;
    }
    .form-group {
      margin-bottom: 16px;
    }
  </style>

  <!-- 카카오 주소 API -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    function execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          document.getElementById("zipcode").value = data.zonecode;
          document.getElementById("address1").value = data.roadAddress;
          document.getElementById("address2").focus();
        }
      }).open();
    }
  </script>
</head>
<body>
  <div class="register-container">
    <h2>회원가입</h2>
    <form action="registerProcess.jsp" method="post">
      <div class="form-group">
        <input type="text" name="id" placeholder="아이디" required>
      </div>
      <div class="form-group">
        <input type="password" name="password" placeholder="비밀번호" required>
      </div>
      <div class="form-group">
        <input type="text" name="name" placeholder="이름" required>
      </div>
      <div class="form-group">
        <input type="email" name="email" placeholder="이메일" required>
      </div>
      <div class="form-group" style="display: flex; gap: 8px;">
        <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly>
        <button type="button" class="btn-small" onclick="execDaumPostcode()">주소 검색</button>
      </div>
      <div class="form-group">
        <input type="text" id="address1" name="address1" placeholder="기본 주소" readonly>
      </div>
      <div class="form-group">
        <input type="text" id="address2" name="address2" placeholder="상세 주소">
      </div>
      <button type="submit">가입하기</button>
    </form>
  </div>
</body>
</html>
