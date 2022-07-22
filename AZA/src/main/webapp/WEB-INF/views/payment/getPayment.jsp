<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  포맷 lib-->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR"> 
<title>GET PAYMENT</title>


<!--  -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/b209e29beb.js" crossorigin="anonymous"></script>
    <link href="/resources/css/message.css" rel="stylesheet">
    <!-- Load Favicon-->
    <link href="assets/img/favicon.ico" rel="shortcut icon" type="image/x-icon">
    <!-- Load Material Icons from Google Fonts-->
    <link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">
    <!-- Load Simple DataTables Stylesheet-->
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet">
    <!-- Roboto and Roboto Mono fonts from Google Fonts-->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500" rel="stylesheet">
    <!-- Load main stylesheet-->
    <link href="/resources/css/styles.css" rel="stylesheet">
    
        

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="/resources/css/payment.css"/>
        
<!--  -->

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<style>

</style>
</head>
<body>

<script>

function requestPay(){
	
	var price = $("#amount").text().trim();
	var lessonName = $("#lessonName").text().trim();
	var payCode = $("#payCode").val();
	var payer = $("#payer").val();
	var phone = $("#phone").val();

	
	
	
    var IMP = window.IMP;
    IMP.init('imp15771574');
    
    // name, amonut

    // 결제창 호출
    IMP.request_pay({
        pg : 'html5_inicis',
        pay_method : 'card',
        merchant_uid : payCode, // 주문 번호
		name : lessonName,
		amount : price,
		buyer_name : payer,
		buyer_tel : phone

    }, function(rsp) {
         console.log(rsp); 
        if (rsp.success) { // 결제 성공 시 
                  var msg = '결제가 완료되었습니다.';
	    			msg += '\n고유ID : ' + rsp.imp_uid;
	    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	    			msg += '\n결제 금액 : ' + rsp.paid_amount;
	    			msg += '결제자 : ' + rsp.buyer_name;
	    			// 넘겨줄 정보..

 	    		let payment = {
						payCode: rsp.merchant_uid,
						impUid: rsp.imp_uid,
						checkPay : 'Y',
						payer : rsp.buyer_name
						
						} 

	           $.ajax({
						url : "/payment/rest/complete",
						type : "post",
						data : payment,
						dataType : "text",
						success : function(data){

								window.location.href = "/payment/getPayment/"+payCode; 

						},

					})

        } else {
			var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
        }
    
        //alert(msg);
    
    })
};


</script>

<!-- 폼 변경 -->
<form>
<div class="card card-raised border-top border-4 border-primary h-100" align="center" style="width:600px;height:10%;">
      <div class="card-body p-5">
          <div class="overline text-muted mb-4"></div>
          <h1>수업료 상세 내역</h1>
          <input type="hidden" id="payCode" value="${payment.payCode}">
          <input type="hidden" id="payer" name="userName" value="${user.userName}">
          <input type="hidden" id="phone" name="phone" value="${user.phone}">
          <br/>
          <table class="table mb-0">
              <tbody>
                  <tr>

                      <td>수업명</td>
                      <td class="text-end" id="lessonName" value="${payment.payLessonName.getLessonName()}" >${payment.payLessonName.getLessonName()}</td></td>
                  </tr>
                  <tr>

                      <td>학생이름</td>
                      <td class="text-end" id="studentName" payCode="${payment.payCode}">${payment.studentName}</td>
                  </tr>
                  <tr>

                      <td>수납료</td>
                      <td class="text-end" value="${payment.amount}" id="amount" >
					${payment.amount}</td>
                  </tr>
                  <tr>

                  <tr>

                      <td>수납예정일</td>
                      <td class="text-end"> ${payment.payDueDate } </td>
                  </tr>
                  <tr>

                      <td>수납완료일</td>
                       <td class="text-end"  id="payDay">
                    	  <fmt:parseDate value="${payment.payDay}" var="payday" pattern="yyyy-MM-dd" />
						  <fmt:formatDate value="${payday}" pattern="yyyy/MM/dd"/> 	
					  </td>                     
                  </tr>                  
                  <tr>

                      <td>수납여부</td>
                      <td class="text-end" id="checkPay" value="${payment.checkPay }">${payment.checkPay }</td>
                  </tr>                
                  
              </tbody>
          </table>
      </div>
      <!-- 결제 미완료 -->
      <c:if test="${payment.checkPay eq 'N'.charAt(0) }">
	      <div class="card-footer bg-transparent position-relative ripple-gray" onclick="requestPay()">
	          <a class="d-flex align-items-center justify-content-end text-decoration-none stretched-link text-primary">
	              <div class="fst-button">결제하기</div>
	              <i class="material-icons icon-sm ms-1" ></i>
	          </a>
	      </div>
      </c:if>
     <!-- 결제완료 --> 
       <c:if test="${payment.checkPay eq 'Y'.charAt(0) }">
	      <div class="card-footer bg-transparent position-relative ripple-gray">
	          <a class="d-flex align-items-center justify-content-end text-decoration-none stretched-link text-primary">
	              <div class="fst-button">수업료 납부가 완료되었습니다. :) [결제자 : ${payment.payer} ] </div>
	              <i class="material-icons icon-sm ms-1" ></i>
	          </a>
	      </div>
      </c:if>    
     
  </div>
<!--  -->
</form>

</body>
</html>