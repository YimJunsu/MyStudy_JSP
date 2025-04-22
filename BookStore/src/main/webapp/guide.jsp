<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>이용 방법 | 책속의 밤</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f3f4f6;
      font-family: 'Segoe UI', sans-serif;
    }

    .guide-section {
      background-color: white;
      padding: 60px;
      border-radius: 12px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.05);
      margin-top: 40px;
    }

    h1, h2 {
      color: #333;
    }

    .step {
      margin-bottom: 32px;
    }

    .step-title {
      font-size: 20px;
      font-weight: bold;
      color: #4f46e5;
      margin-bottom: 10px;
    }

    .step-desc {
      color: #555;
      font-size: 16px;
    }

    .highlight {
      color: #ef4444;
      font-weight: 600;
    }
  </style>
</head>
<body>
  <div class="container py-5">
    <%@ include file="menu.jsp" %>

    <div class="guide-section">
      <h1 class="text-center mb-5 fw-bold">📘 이용 방법 안내</h1>

      <div class="step">
        <div class="step-title">1. 회원가입 및 로그인</div>
        <div class="step-desc">서비스를 이용하려면 먼저 회원가입 후 로그인 해주세요.</div>
      </div>

      <div class="step">
        <div class="step-title">2. 도서 목록 확인</div>
        <div class="step-desc">메뉴에서 다양한 도서를 확인하고, 원하는 책의 정보를 열람할 수 있어요.</div>
      </div>

      <div class="step">
        <div class="step-title">3. 장바구니 담기</div>
        <div class="step-desc">관심 있는 도서를 장바구니에 담고 결제를 진행해보세요.</div>
      </div>

      <div class="step">
        <div class="step-title">4. 배송 안내</div>
        <div class="step-desc">
          주문하신 도서는 보통 <span class="highlight">3~5일 내로 배송</span>되며, 
          <span class="highlight">제주도 지역은 최대 일주일</span> 정도 소요될 수 있어요. 📦
        </div>
      </div>

      <div class="step">
        <div class="step-title">5. 마이페이지 이용</div>
        <div class="step-desc">회원 정보 수정, 비밀번호 변경 등 다양한 기능을 이용할 수 있어요.</div>
      </div>

      <div class="step">
        <div class="step-title">6. 문의 및 책 신청</div>
        <div class="step-desc">
          <span class="highlight">[문의하기]</span> 메뉴를 통해 궁금한 점을 문의할 수 있으며, 
          <strong>원하는 책을 신청</strong>할 수도 있어요! 😊
        </div>
      </div>
    </div>

    <%@ include file="footer.jsp" %>
  </div>
</body>
</html>
