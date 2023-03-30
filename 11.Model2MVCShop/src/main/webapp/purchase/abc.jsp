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
    
    
    
    
        var IMP = window.IMP; 
        IMP.init("imp13567041"); 
    
        function requestPay() {  //CORS ���� �ذ��ϱ� ���� �˻��ؾ��Ѵ�.
            IMP.request_pay({
                pg : 'html5_inicis',
                pay_method : 'card',
                merchant_uid: "57008833-33010", 
                name : '���ó����� ���ġŲ',
                amount : 1000,
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
                      url: "https://api.iamport.kr/payments/57008833-33009",   //���� Ȩ������ url���� �ʿ��� ���� ������ �� �ִ�. �����ϱ�
                      method: "POST",
                      headers: { "Content-Type": "application/json" },
                      data: {
                        imp_uid: rsp.imp_uid,            // ���� ������ȣ
                        merchant_uid: rsp.merchant_uid   // �ֹ���ȣ
                      }
                    }).done(function (data) {
                      // ������ ���� ���� API ������ ����
                      alert(data);
                    })
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