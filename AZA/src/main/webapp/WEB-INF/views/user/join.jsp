<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link
   href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
   rel="stylesheet" />
<!-- Roboto and Roboto Mono fonts from Google Fonts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
   rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
   rel="stylesheet" />


<!-- 회원가입용 Load main stylesheet-->
<link href="/resources/css/template.css" rel="stylesheet" />
<link href="/resources/css/common.css" rel="stylesheet" />
<link href="/resources/css/main.css" rel="stylesheet" />
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
   crossorigin="anonymous"></script>



<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<!-- <link
<<<<<<< HEAD
   href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
   rel="stylesheet">
=======
	href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
	rel="stylesheet">
>>>>>>> refs/heads/HMHM
 -->

<script
   src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
*, body {
   font-family: Pretendard, 'Noto Sans KR';
   background-color: white;
}

body>div.container {
   border: 3px solid #D6CDB7;
   margin-top: 10px;
}

.id_ok {
   color: #6A82FB;
   display: none;
}

.id_already {
   color: red;
   display: none;
}

.form-horizontal {
   padding-left: 20px;
   margin-top: 20px;
   margin-bottom: 30px;
   line-height: 50px;
}

.is_ok {
   color: #6A82FB;
   display: none;
}

.is_no {
   color: red;
   display: none;
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->


</head>

<body class="">
   <!-- Layout wrapper-->
   <div id="layoutAuthentication">
      <!-- Layout content-->
      <div id="layoutAuthentication_content">
         <main>
            <!-- Main content container-->
            <div class="container">
               <div class="row justify-content-center">
                  <div class="col-xxl-7 col-xl-10">
                     <div class="card card-raised shadow-10 mt-5 mt-xl-10 mb-5">
                        <div class="card-body p-5">
                           <!-- Auth header with logo image-->
                           <div class="text-center">
                              <img class="mb-3" src="/resources/img/logo2.png" alt="..."
                                 style="height: 100px">
                              <h1 class="display-5 mb-0 text-primary fw-bold">회원가입</h1>
                              <div class="subheading-1 mb-5 text-muted">회원가입 후 이용이
                                 가능합니다:D</div>
                           </div>
                           <!-- Register new account form-->
                           <form>
                           
                           <div class="row">
                           <label for="role">회원유형을 선택하세요</label>
                              <div class="col-sm-4 mb-4 p-2">
                                 <select class="form-select" name="role" id="role">
                                    <option value="teacher">선생님</option>
                                    <option value="student">학생</option>
                                    <option value="parent">학부모</option>
                                 </select>
                              </div>
                          </div> 
                           
                              <div class="row">
                                 <div class="col-sm-6 mb-4">
                                    <mwc-textfield class="w-100" id="userId" name="userId" label="아이디" outlined="" oninput="checkDuplication()"></mwc-textfield>
                                 </div>
                                 <span class="id_ok">사용가능한 아이디입니다.</span> 
                                 <span class="id_already">사용중인 아이디 입니다.</span>
                              </div>   
                              <div class="row">
                                 <div class="col-sm-6 mb-4">
                                 <label for="userName"></label>
                                    <mwc-textfield class="w-100" id="userName" name="userName" label="이름" outlined=""></mwc-textfield>
                                 </div>
                              </div>
                              
                              <div class="row">
                                <div class="col-sm-6 mb-4">
                                <label for="password"></label>
                                    <mwc-textfield class="w-100" label="비밀번호" outlined="" id="password" type="password"
                                       name="password"
                                       icontrailing="visibility_off" type="비밀번호"></mwc-textfield>
                                 </div>
                                 <div class="col-sm-6 mb-4">
                                 <label for="password2"></label>
                                    <mwc-textfield class="w-100" label="비밀번호 확인" id="password2" type="password"
                                       name="password2"
                                       outlined="" icontrailing="visibility_off" type="비밀번호 확인"></mwc-textfield>
                                 </div>
                              </div>
  <div class="input-group mb-4">
  <input type="text" class="form-control" placeholder="ex)01012345678" aria-label="phone" id="phone" name="phone" aria-describedby="button-addon2" required>
  <button class="btn btn-outline-secondary" type="button" id="phoneBtn" onclick="cert();" disabled="disabled">인증번호 받기</button>
 <!--  <div id="phoneCheck"></div> -->
</div>

<div class="input-group mb-3">
  <input type="text" class="form-control" id="certification" name="auth" placeholder="인증번호를 입력하세요" aria-label="auth" aria-describedby="button-addon2">
  <button class="btn btn-outline-secondary" type="button" id="sms_AuthBtn" onclick="smsAuthBtn();">인증번호 입력</button>
</div>

<div id="certCheck"></div>
<span id="check" ></span>



							<div class="student" style="display: none;">
							<div class="row">
                                <div class="col-sm-6 mb-4">
                                <label for="school"></label>
                                    <mwc-textfield class="w-100" label="학교" outlined="" id="school" 
                                       name="school" type="학교"></mwc-textfield>
                                 </div>
                                 <div class="col-sm-6 mb-4">
                                 <label for="grade"></label>
                                    <mwc-textfield class="w-100" label="학년" id="grade" 
                                       name="grade" outlined=""  type="학년"></mwc-textfield>
                                 </div>
                             </div>
                             </div>
                             
                             
                             <div class="parent" style="display: none;">
                             <div class="row">
                             <label for="firstStudentId"></label>
                                 <div class="col-sm-6 mb-4">
                                    <mwc-textfield class="w-100" id="firstStudentId" name="firstStudentId" label="자녀 아이디" outlined="" oninput="checkStudent()"></mwc-textfield>
                                 </div>
                               <div class="form-group" id="certCheck2"></div>
                               
                                 <div class="col-sm-6 mb-4">
                                 <label for="relationName"></label>
                                    <mwc-textfield class="w-100" id="relationName" name="relationName" label="학생과의 관계" outlined=""></mwc-textfield>
                                 </div>
                              </div>
                              </div>



										<div class="agree__box my-3" >
											<input type="checkbox" id="check_above" name="agreecheck" />
											<label for="check_above">사용자 약관 전체 동의 (필수)</label>

										</div>


										<div align="center" class="accordion" id="accordionExample"
                                 style="width: 500px;">
                                 <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingOne">
                                       <button class="accordion-button" type="button"
                                          data-bs-toggle="collapse" data-bs-target="#collapseOne"
                                          aria-expanded="false" aria-controls="collapseOne">
                                          서비스 이용 약관 동의 (필수)</button>
                                    </h2>
                                    <div id="collapseOne" class="accordion-collapse collapse"
                                       aria-labelledby="headingOne"
                                       data-bs-parent="#accordionExample">
                                       <div class="accordion-body">
                                          개인정보 수집 및 이용 동의 <br /> 1. 수집항목: [필수] 이름, 연락처 <br /> 2.
                                          수집 및 이용목적: 서비스 이용을 위한 수집 <br /> 3. 보관기간: 회원탈퇴 등 개인정보 이용목적
                                          달성 시까지 보관. 단, 상법 및 ‘전자상거래 등에서의 소비자 보호에 관한 법률’ 등 관련 법령에 의하여
                                          일정 기간 보관이 필요한 경우에는 해당 기간 동안 보관함 <br /> 4. 동의 거부권 등에 대한
                                          고지: 정보주체는 개인정보의 수집 및 이용 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이
                                          제한될 수 있습니다. 개인정보 제3자 제공 동의 <br /> <br /> 1. 개인정보를 제공받는
                                          자: AZA 호스트 <br /> 2. 제공하는 개인정보 항목: [필수] AZA 아이디, 이름, 연락처
                                          <br /> 3. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간: 개인정보 이용목적 달성 시 까지
                                          보존합니다. <br /> 4. 동의 거부권 등에 대한 고지: 정보주체는 개인정보 제공 동의를 거부할
                                          권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.

                                       </div>
                                    </div>
                                 </div>
                                 <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingTwo">
                                       <button class="accordion-button collapsed" type="button"
                                          data-bs-toggle="collapse" data-bs-target="#collapseTwo"
                                          aria-expanded="false" aria-controls="collapseTwo">
                                          서비스 이용 약관 동의 (필수)</button>
                                    </h2>
                                    <div id="collapseTwo" class="accordion-collapse collapse"
                                       aria-labelledby="headingTwo"
                                       data-bs-parent="#accordionExample">
                                       <div class="accordion-body">
                                          제 1조 (총칙) <br /> 1. 개인정보란 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는
                                          성명, 주민등록번호 등의 사항에 의하여 당해 개인을 식별할 수 있는 정보 (당해 정보만으로는 특정 개인을
                                          식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함합니다.) 를 말합니다. <br />
                                          2. AZA는 귀하의 개인정보 보호를 매우 중요시하며, ‘정보통신망이용촉진 및 정보보호에 관한 법률’
                                          상의 개인정보 보호규정 및 정보통신부가 제정한 ‘개인정보 보호지침’을 준수하고 있습니다. <br />
                                          3. AZA는 개인정보취급방침을 정하고 이를 귀하께서 언제나 쉽게 확인할 수 있게 공개하도록 하고
                                          있습니다. <br /> 4. AZA는 개인정보 처리방침의 지속적인 개선을 위하여 개정하는데 필요한
                                          절차를 정하고 있으며, 개인정보 처리방침을 회사의 필요한 사회적 변화에 맞게 변경할 수 있습니다. 그리고
                                          개인정보처리방침을 개정하는 경우 버전번호 등을 부여하여 개정된 사항을 귀하께서 쉽게 알아볼 수 있도록
                                          하고 있습니다. <br /> <br /> 제 2조 (수집하는 개인정보 항목 및 수집방법) <br />
                                          1. AZA의 서비스를 이용하시고자 할 경우 다음의 정보를 입력해주셔야 합니다. <br /> -
                                          입력항목 : 희망ID, 비밀번호, 성명, 연락처 <br /> 2. 또한 서비스 이용과정이나 사업 처리
                                          과정에서 아래와 같은 정보들이 생성되어 수집될 수 있습니다. <br /> - 회원가입 시 회원이
                                          원하시는 경우에 한하여 추가 정보를 선택, 제공하실 수 있도록 되어있으며, 일부 재화 또는 용역 상품에
                                          대한 주문 및 예약 시 회원이 원하는 정확한 주문 내용 파악을 통한 원활한 고객 응대 및 예약 처리를
                                          위하여 추가적인 정보를 요구하고 있습니다. <br /> 3. AZA는 다음과 같은 방법으로 개인정보를
                                          수집합니다. <br /> - 로그 분석 프로그램을 통한 생성정보 수집 <br /> 4. 개인정보
                                          수집에 대한 동의 <br /> - AZA는 귀하께서 AZA의 개인정보취급방침 및 이용약관의 내용에 대해
                                          「동의한다」버튼 또는 「동의하지 않는다」버튼을 클릭할 수 있는 절차를 마련하여, 「동의한다」버튼을
                                          클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다. <br /> 5. 14세 미만 아동의 개인정보보호
                                          <br /> AZA는 법정 대리인의 동의가 필요한 만14세 미만 아동의 회원가입은 받고 있지 않습니다.
                                          <br />
                                       </div>
                                    </div>
                                 </div>
                                 <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingThree">
                                       <button class="accordion-button collapsed" type="button"
                                          data-bs-toggle="collapse" data-bs-target="#collapseThree"
                                          aria-expanded="false" aria-controls="collapseThree">
                                          만14세 이상 확인 (필수)</button>
                                    </h2>
                                    <div id="collapseThree" class="accordion-collapse collapse"
                                       aria-labelledby="headingThree"
                                       data-bs-parent="#accordionExample">
                                       <div class="accordion-body">
                                          정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따라 만 14세 미만 아동의 개인정보 수집 시
                                          법정대리인의 동의를 받도록 규정하고 있습니다. <br /> 만 14세 미만 아동이 법정대리인 동의 없이
                                          회원가입을 할 경우 회원탈퇴 또는 서비스 이용에 제한이 있을 수 있습니다.
                                       </div>
                                    </div>
                                 </div>
                              </div>




                              <div class="form-group my-3" align="center">
                                 <div class="col-sm-offset-4  col-sm-4" >
                                    <button type="button" class="btn btn-primary">가&nbsp;입</button>
                                    <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
                                 </div>
                              </div>




</form>
                              </div>
                              </div>
                              

           
                       
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </main>




         <script
            src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
         <!--  ///////////////////////// CSS ////////////////////////// -->


         <!--  ///////////////////////// JavaScript ////////////////////////// -->
         <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
         <script type="text/javascript">
   

        
      //아이디 체크
      const checkDuplication = _.debounce(async (id) => {
         //var userId = $('#userId').val(); // id값이 userId인 인력란의 값 저장
         var id = $("#userId").val();
         
         
         var isID = /^[a-z0-9][a-z0-9_\-]{4,10}$/;
              if (!isID.test(id)) {
               alert("5~10자의 영문 소문자, 숫자만 사용 가능합니다.");
               return false;
              }         
              
         
         $.ajax({
         //   header :
         //   url:'localhost:8080/user/rest/checkDuplication',
            url:'/user/rest/checkDuplication',
            type:'post',
            data:{id},
            success:function(cnt){ //컨트롤러에서 넘어온 cnt값 받기
               if(cnt == 0) { //0이면 사용가능 아이디
                  $('.id_ok').css("display","inline-block");
                  $('.id_already').css("display", "none");
                  }else{
                  $('.id_ok').css("display","none");
                  $('.id_already').css("display", "inline-block");
               }
            },
            error:function(){
               alert("에러입니다");
            }
         });
      },1000);
   
      //============= "가입"  Event 연결 =============
       $(function() {
         //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
         $( "button.btn.btn-primary" ).on("click" , function() {
            fncAddUser();
         });
      });   
      
      

      $(function(){
         $('#password2').blur(function(){
            if($('#password').val() != $('#password2').val()){
               if($('#password2').val() != ''){
                  alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
                  $('#password2').val('');
                  $('#password2').focus();
               }
            }
         })
      });
      
   
      //============= "취소"  Event 처리 및  연결 =============
      $(function() {
         //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
         $("a[href='#' ]").on("click" , function() {
            $("form").attr("method" , "get").attr("action" , "http://127.0.0.1:8080/").submit();
         });
      });   
   
      
      function fncAddUser() {
         
         var id=$("mwc-textfield[name='userId']").val();
         var pw=$("mwc-textfield[name='password']").val();
         var pw_confirm=$("mwc-textfield[name='password2']").val();
         var name=$("mwc-textfield[name='userName']").val();
         var phone=$("input[name='phone']").val();
         var auth=$("input[name='auth']").val();
         var agree = false;
			var arr_agree = document.getElementsByName("agreecheck");
			for(var i=0;i<arr_agree.length;i++){
				if(arr_agree[i].checked==true){
					agree=true;
					break;
				}
			}
         
         
         if(id == null || id.length <1){
            alert("아이디는 반드시 입력하셔야 합니다.");
            return;
         }
         
         if(id.length < 5 || id.length > 11){
            alert("아이디는 5~10자 이내로 만들어주세요.");
            return;
         }
         
         if(pw == null || pw.length <1){
            alert("패스워드는  반드시 입력하셔야 합니다.");
            return;
         }
         if(pw_confirm == null || pw_confirm.length <1){
            alert("패스워드 확인은  반드시 입력하셔야 합니다.");
            return;
         }
         if(name == null || name.length <1){
            alert("이름은  반드시 입력하셔야 합니다.");
            return;
         }
         
         if( pw != pw_confirm ) {            
            alert("비밀번호 확인이 일치하지 않습니다.");
            $("input:text[name='password2']").focus();
            return;
         }
         
         if(phone == null || phone.length <1){
            alert("핸드폰 인증은 필수입니다.");
            return;
         }
         
         if(auth == null || auth.length <1){
            alert("핸드폰 인증은 필수입니다.");
            return;
         }
         if(!agree){
				alert("사용자 약관에 전체 동의해주세요.");
				return false;
			}

         
         
         $("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
      }
      
      
         $('#role').on('change', function(){
            if($(this).val()=='teacher'){
            $('.student').hide();
            $('.parent').hide();
            } else if ($(this).val()=='student'){
            $('.student').show();
            $('.parent').hide();
            }else{
            $('.student').hide();
            $('.parent').show();

            
            }
         });
   
      /* 생년월일 유효성 검사 */

   
   
   <!--휴대폰 인증 / SMS SENS API -->
   // 핸드폰 유효성 체크   
   $("#phone").on("keyup",()=>{
      const phonNum = $("#phone").val();
      const regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
      if (regPhone.test(phonNum) === true) {
         $("#phoneBtn").removeAttr("disabled");
      } else {
         $("#phoneBtn").attr("disabled","disabled");
      }
   })
   
   function cert() {
       var phone = $("#phone").val();   
      
       $.ajax({
          type : 'POST',
          url :'/user/rest/sendSMS/'+phone,
          dataType : "json",
                      
          contentType: "application/json",
          success : function(data) {
             if(data.result  == "success"){
                $('#certCheck').text("인증 번호가 전송되었습니다.");
                $('#certCheck').css('color','blue');
                $("#sms_AuthBtn").attr("disabled",true);
             }else {
                $('#certCheck').text("입력한 번호를 다시 확인해주세요.");
                $('#certCheck').css('color','red');
                $("#sms_AuthBtn").attr("disabled",true);
             }
          }
       });
   }
   
   function smsAuthBtn() {
      const phoneAuth  = $("#certification").val();
      const phoneNum = $("#phone").val();

      $.ajax({
         url: '/user/rest/confirmCode/'+phoneNum+'/'+phoneAuth,//url,
         method: "GET",
         headers : {
               "Accept" : "application/json",
               "Content-Type" : "application/json"
           },
           dataType : "json",
         success : function(data){
         console.log(data);
            $("#phone").attr("disabled","disabled");
            $("#phoneBtn").attr("disabled","disabled");
         if(data.result == "success" ) {
            $('#certCheck').text("인증이 완료되었습니다.");
            $('#certCheck').css('color','blue');   
            $("#signup_btn").attr("disabled",false);
         }else{
             $('#certCheck').text("인증번호를 다시 확인해주세요");
             $('#certCheck').css('color','red');
             $("#signup_btn").attr("disabled",true);
          }
          
 /*           if(phoneAuth == check){ 
                $('#certCheck').text("인증이 완료되었습니다.");
                $('#certCheck').css('color','blue');   
                $("#signup_btn").attr("disabled",false);
             }else{
                $('#certCheck').text("인증번호를 다시 확인해주세요");
                $('#certCheck').css('color','red');
                $("#signup_btn").attr("disabled",true);
             } */ 
  
      }
      });
      
   }
   /*      if(data.result  == "success") { //0이면 사용가능 아이디
	$('.is_ok').css("display","inline-block");
	   $('.is_no').css("display", "none");
}else{
	   $('.is_ok').css("display","none");
	   $('.is_no').css("display", "inline-block");
} */

   const checkStudent = _.debounce(async (id) => {
                         
                         var id = $("#firstStudentId").val();
                         
                         $.ajax({
                            url:'/user/rest/checkStudent',
                            type : "post",
                            data:{id},
                            success : function(cnt) {
                               if(cnt == 1) {
                                  $('#certCheck2').text("확인이 완료되었습니다.");
                                  $('#certCheck2').css('color','blue');   
                                  
                               }
                               else {
                                  $('#certCheck2').text("확인되지 않은 정보입니다.");
                                  $('#certCheck2').css('color','red');
                                  
                               }
                            }
                         });
                      },2000);
                   

                  </script>

         <script type="module" src="/resources/javascript/common/material.js"></script>
         <script type="module" src="/resources/javascript/common/scripts.js"></script>

</body>

</html>
