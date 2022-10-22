// 로그인 alert
function nullInputAlert() {
	Swal.fire({
	    title: '저런...',
	    text: '아이디와 비밀번호를 모두 입력해주세요',
	    icon: 'error',
	    confirmButtonColor: '#9966FF',
	    confirmButtonText: '확인'
 	})
}

function checkInputVal() {
	Swal.fire({
	    title: 'Oooops',
	    text: '아이디와 비밀번호를 확인해주세요',
	    icon: 'question',
	    confirmButtonColor: '#9966FF',
	    confirmButtonText: '확인'
 	})
}


//============= 회원가입 화면이동 =============

$(function() {
	$("button:contains('회원가입')").on("click", function() {
		self.location = "/user/addUser"
	});
});

$(function() {
	$("button:contains('아이디 찾기')").on("click", function() {
		self.location = "/user/findId"
	});
});

$(function() {
	$("button:contains('비밀번호 재설정')").on("click", function() {
		self.location = "/user/findPassword"
	});
});

$(function() {
	$("button:contains('로그인')").on("click", function() {
		login();
	});
})

$(function() {
	$("#password").on("keyup",function() {
		if(window.event.keyCode == 13) {
			login();
		}
	}) 
})



// 유효성 체크
function login() {

	var loginForm = $("#loginForm");
	var userId = $("#userId").val();
	var password = $("#password").val();

	if (userId == "" || userId.length < 1 || userId == null || password == "" || password.length < 1 || password == null) {
		nullInputAlert();
	} else {
				
		$.ajax({
			url : "/user/rest/login?userId="+userId+"&password="+password,
			type : "GET",
			headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
        	},
        	success : function(result) {
				if(result) {
					if(result == false) {
						checkInputVal();
					} else {						
						$("form").attr("method", "POST").attr("action", "/user/login").submit();
					}
				} else {
					checkInputVal();
				}
			}
		})
	}
}