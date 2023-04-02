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
    
    	//CORS���� �ذ��� �� �ִ� ����� �Ƹ� ������Ʈ������ �����Ұ���. Ȯ���غ���, ���� �����ָ� Controller�̿��ؼ� �ذ��غ���.
    	//������� �������ֽ� �͵� ���ø���.
    	//redirect ���� �����ϱ�. Ȥ�� ����Բ� ���ຸ��
    	//Naver SNS ���� ��Ŀ���� �����ϱ�. 
    	//0331 controller ������� >?
    	
    			//token �� �����ͼ� header�� �־��ָ� api����� �����ϴ� ..?
    			//api ���� ...
    
    
    
        var IMP = window.IMP; 
        IMP.init("imp13567041"); 
    
        function requestPay() {  //CORS ���� �ذ��ϱ� ���� �˻��ؾ��Ѵ�.
            IMP.request_pay({
                pg : 'html5_inicis', //html5_inicis
                pay_method : 'card',
                merchant_uid: "57008833-33020", 
                name : '�������ٹ�1st',
                amount : 100,
                buyer_email : 'didtn1233@gmail.com',
                buyer_name : '��޼�',
                buyer_tel : '010-9783-3446',
                buyer_addr : '����Ư���� ������ ��Ʈķ��',
                buyer_postcode : '��Ʈķ�� �ǹ� 6�� 603ȣ'
            }, function (rsp) {
                if (rsp.success) {
                    // ���� ���� ��: ���� ���� �Ǵ� ������� �߱޿� ������ ���
                    // jQuery�� HTTP ��û
                    jQuery.ajax({
                      url: "https://api.iamport.kr/payments/imp_687146285859",   //���� Ȩ������ url���� �ʿ��� ���� ������ �� �ִ�. �����ϱ�
                      method: "GET",
                      headers: {"Content-Type": "application/json", "Authorization" :"0ceac440a7954c7992f11f0cf552cd4d6fd95b55"}
//                       data: { 
//                         imp_uid: rsp.imp_uid,            // ���� ������ȣ
//                         merchant_uid: rsp.merchant_uid,  // �ֹ���ȣ 
//                       }
                    });
//                     .done(function (data) {
//                       // ������ ���� ���� API ������ ����
//                     	msg = '������ �Ϸ�Ǿ����ϴ�.';
//                         msg += '\n����ID : ' + rsp.imp_uid;
//                         msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
//                         msg += '\n���� �ݾ� : ' + rsp.paid_amount;
//                         msg += 'ī�� ���ι�ȣ : ' + rsp.apply_num;

//                         alert(msg);
//                     })
                  } else {
                    alert("������ �����Ͽ����ϴ�. ���� ����: " + rsp.error_msg);
                  }
                });
        };
        
    </script>
    <meta charset="euc-kr">
    <title>Sample Payment</title>
</head>
<body>
    <button onclick="requestPay()">�����ϱ�</button> <!-- �����ϱ� ��ư ���� -->
</body>
</html>