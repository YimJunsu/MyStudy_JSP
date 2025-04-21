<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>회원가입</title>
    <!-- Bootstrap 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- 카카오 주소 API -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    document.getElementById('zipcode').value = data.zonecode;
                    document.getElementById('address1').value = data.address;
                    document.getElementById('address2').focus();
                }
            }).open();
        }
    </script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">회원가입</h4>
        </div>
        <div class="card-body">
            <form action="registerProcess.jsp" method="post">
                <div class="mb-3">
                    <label class="form-label">아이디</label>
                    <input type="text" name="id" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">비밀번호</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">이름</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">이메일</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">우편번호</label>
                    <div class="input-group">
                        <input type="text" id="zipcode" name="zipcode" class="form-control" readonly>
                        <button type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()">주소 검색</button>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">기본주소</label>
                    <input type="text" id="address1" name="address1" class="form-control" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label">상세주소</label>
                    <input type="text" id="address2" name="address2" class="form-control">
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">회원가입</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
