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
    
    	//CORS문제 해결할 수 있는 방법을 아마 아임포트측에서 제공할것임. 확인해볼것, 제공 안해주면 Controller이용해서 해결해보기.
    	//강사님이 설명해주신 것도 떠올리기.
    	//redirect 문제 공부하기. 혹은 강사님께 여줘보기
    	//Naver SNS 서비스 메커니즘 공부하기. 
    	//0331 controller 만들건지 >?
    	
    			//token 값 가져와서 header에 넣어주면 api사용이 가능하다 ..?
    			//api 참고 ...
    
    
    
        var IMP = window.IMP; 
        IMP.init("imp13567041"); 
    
        function requestPay() {  //CORS 문제 해결하기 위해 검색해야한다.
            IMP.request_pay({
                pg : 'html5_inicis', //html5_inicis
                pay_method : 'card',
                merchant_uid: "57008833-33020", 
                name : '뉴진스앨범1st',
                amount : 100,
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
                      url: "https://api.iamport.kr/payments/imp_687146285859",   //실제 홈페이지 url보고 필요한 정보 가져올 수 있다. 참고하기
                      method: "GET",
                      headers: {"Content-Type": "application/json", "Authorization" :"0ceac440a7954c7992f11f0cf552cd4d6fd95b55"}
//                       data: { 
//                         imp_uid: rsp.imp_uid,            // 결제 고유번호
//                         merchant_uid: rsp.merchant_uid,  // 주문번호 
//                       }
                    });
//                     .done(function (data) {
//                       // 가맹점 서버 결제 API 성공시 로직
//                     	msg = '결제가 완료되었습니다.';
//                         msg += '\n고유ID : ' + rsp.imp_uid;
//                         msg += '\n상점 거래ID : ' + rsp.merchant_uid;
//                         msg += '\n결제 금액 : ' + rsp.paid_amount;
//                         msg += '카드 승인번호 : ' + rsp.apply_num;

//                         alert(msg);
//                     })
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