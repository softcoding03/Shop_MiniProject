	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>

<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script>
        var IMP = window.IMP; 
        IMP.init("imp13567041"); 
    
        function requestPay() {  //CORS 문제 해결하기 위해 검색해야한다.
            IMP.request_pay({
                pg : 'html5_inicis',
                pay_method : 'card',
                merchant_uid: "57008833-33010", 
                name : '무봤나숯불 양념치킨',
                amount : 1000,
                buyer_email : 'didtn1233@gmail.com',
                buyer_name : '김앵수',
                buyer_tel : '010-9783-3446',
                buyer_addr : '서울특별시 강남구 비트캠프',
                buyer_postcode : '비트캠프 건물 6층 603호'
            }, function (rsp) {
                if (rsp.success) {
                    // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                    // jQuery로 HTTP 요청
                    jQuery.ajax({
                      url: "https://api.iamport.kr/payments/57008833-33009",   //실제 홈페이지 url보고 필요한 정보 가져올 수 있다. 참고하기
                      method: "POST",
                      headers: { "Content-Type": "application/json" },
                      data: {
                        imp_uid: rsp.imp_uid,            // 결제 고유번호
                        merchant_uid: rsp.merchant_uid   // 주문번호
                      }
                    }).done(function (data) {
                      // 가맹점 서버 결제 API 성공시 로직
                      alert(data);
                    })
                  } else {
                    alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                  }
                });
        };
        
    </script>
    <meta charset="euc-kr">
    <title>Sample Payment</title>
</head>
<body>
    <button onclick="requestPay()">결제하기</button> <!-- 결제하기 버튼 생성 -->
</body>
</html>