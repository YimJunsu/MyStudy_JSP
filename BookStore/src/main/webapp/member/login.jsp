<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>로그인</title>
  <style>
    body {
      background-color: #f3f4f6;
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .login-container {
      background-color: white;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 8px 16px rgba(0,0,0,0.1);
      width: 360px;
    }
    h2 {
      text-align: center;
      margin-bottom: 24px;
      color: #333;
    }
    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 12px;
      margin: 8px 0 16px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      transition: 0.3s;
    }
    input[type="text"]:focus, input[type="password"]:focus {
      border-color: #6366f1;
      outline: none;
    }
    button {
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
    button:hover {
      background-color: #4f46e5;
    }
    .signup-link {
      margin-top: 16px;
      text-align: center;
    }
    .signup-link a {
      color: #6366f1;
      text-decoration: none;
    }
  </style>
</head>
<body>
	  <div class="login-container">
	    <h2>로그인</h2>
	    <form action="loginProcess.jsp" method="post">
	      <input type="text" name="id" placeholder="아이디" required>
	      <input type="password" name="password" placeholder="비밀번호" required>
	      <button type="submit">로그인</button>
	    </form>
	    <div class="signup-link">
	      아직 회원이 아니신가요? <a href="register.jsp">회원가입</a>
	    </div>
	  </div>
</body>
</html>
