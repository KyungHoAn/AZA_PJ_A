// common :: 로그인 동시에 sessionStorage 설정
window.addEventListener('DOMContentLoaded', event => {
   $.ajax({
      url:"/user/rest/getUser",
      type:"POST",
      headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
       	success: function(result) {
			if(result) {
			console.log(result);
			sessionStorage.clear();
			sessionStorage.setItem("userId", result.userId);
			sessionStorage.setItem("role", result.role);
			sessionStorage.setItem("userName", result.userName);
			
			var roleStr = "";
			
			switch(result.role) {
				case "teacher" : 
					roleStr = "선생님";
					break;
				case "parent":
					roleStr = "학부모님";
					break;
				case "student":
					roleStr = "학생"
					break;
				default : 
					break;				
			}
			
			var str = `${result.userName}  ${roleStr} 오늘도 AZA:D`;
			
			$('.greetingMsg').append(str);
				
			} else {
				console.log("getUser error");
			}


      } 

   })

});

// common :: iframe : main
function changeIframeUrl(url)
{
    $("#mainFrame").src = url;
}

// common :: ifram : sub
function changeSubframeUrl(url)
{
    $("#subFrame").src = url;
}

// common :: message : 채팅 상대 목록 만들기
function makeOthersList(result) {
   var listOtherView = "";
   
   result.map((other,i) => {
                      var userId = other.userId;
                      var userName = other.relationName ? other.firstStudentName + "  " + other.relationName : other.userName;
                      
            

                		listOtherView += `<ul id='getOtherMessage' class='list-unstyled mb-0' onclick="getOtherMessage('`+userId+`','`+userName+`')">
                		<li class='p-2 pb-0 border-bottom' data-id=`+userId+`>
                            	<a class="d-flex justify-content-between">
                                    <div class="d-flex flex-row">
                                        <div class="pt-1">
                                            <p class="fw-bold mb-0">`+userName+`</p>
                                            <p class="small text-muted"> @ `+userId+`</p>
                                        </div>
                                    </div>
                               </a>
                           </li>
                       </ul>`;
               }
   );
                   
   //$('#getOtherMessage').remove();
   $('#listOther').append(listOtherView);
}

// index_student :: addStudentsRecord Form
function resetForm() {
   document.addStudentsRecordForm.reset();
   $('.lessonCheck').removeClass('show');
}


// index_student :: jquery event
$(function() {
   
   $('input').on("focus", function() {
      $('.lessonCheck').removeClass('show');
      $('.valCount').removeClass('show');   
   })
   
   
   
   $('#addStudentsRecordBtn').on("click", function() {

      var valFlag = false;
      const lessonCode = document.addStudentsRecordForm.lessonCode.value;
      const lessonStartDate = document.addStudentsRecordForm.lessonStartDate.value;
      const fees = document.addStudentsRecordForm.fees.value;
      const payDueDate = document.addStudentsRecordForm.payDueDate.value;
      
      if(isNaN(fees)) {
         $('.valCount').addClass('show');
         return;
      } else   if(lessonCode.length < 8 || lessonCode == null ) {
         $('.lessonCheck').addClass('show');
      } else {
         $.ajax({
             url: "/lesson/rest/checkLessonCode/"+lessonCode,
                  type: "GET",
                  headers : {
                          "Accept" : "application/json",
                          "Content-Type" : "application/json",                                    
                      },
                  success: function(result) {
                      if(result) {
                         console.log(result);
                         
                         if(result == true) {
                            valFlag = true;
                         }
                         
                         if(!valFlag) {
                            $('.lessonCheck').addClass('show');
                            return;
                         }
                         
                         console.log(valFlag);
                         
                         if(valFlag) {
                           document.addStudentsRecordForm.action = "/students/addStudentsRecord";
                           document.addStudentsRecordForm.method = "POST";
                           document.addStudentsRecordForm.submit();      
                        }
                      } else {
                         console.log("lesson/rest/checkLessonCode :: error || null");                            
                         $('.lessonCheck').addClass('show');
                      }
                  }
         })
      }
      
       

   })
})





// common :: jquery : event
$(function() {

	
	// 메인 네비
	$('.left_nav').on('click', function(e) {
		var url = e.target.dataset.url;
		console.log(url);
		$("#mainFrame").attr('src',url)
	})
	
	// 탑 네비
	$('.top_nav').on('click', function(e) {
		var url = e.target.dataset.url;
		console.log(url);
		$("#mainFrame").attr('src',url)
	})
	
	// 서브탭 
	$('.subframe_nav').on('click', function(e) {
		var url = e.target.dataset.url;
		console.log(url);
		$("#subFrame").attr('src',url)
	})
	
	// Alert 버튼
	 $('#dropdownMenuNotifications').on('click', function() {
		console.log("알림 버튼 눌림");
		listAlert();
	})

   // Message 버튼
   $("#open-messagePopup").on("click", function() {
      console.log("메시지 버튼 눌림");
         $("#listOther").empty();
      
        $.ajax({
            url: "/message/rest/listMessage",
            type: "GET",
            headers : {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json",                                    
                },
            success: function(result) {
                if(result) {
                   console.log(result);
                   
                   $('#getOtherMessage').remove();
                   
                   makeOthersList(result);

                } else {
                    console.log("실패");
                }
            } 
        })
   })

   // Message 이름 검색
   $("#messageSearchKeyword").on("keyup", function() {
      var searchKeyword = $("#messageSearchKeyword").val();
      $("#listOther").empty();
         
      if(searchKeyword != '' || searchKeyword != " " || searchKeyword != null) {
         if(sessionStorage.getItem("role") == "teacher") {
            data = {
               searchCondition : 1,
               searchKeyword : searchKeyword
            }
         }
         
         if(sessionStorage.getItem("role") == "student" ) {
            data = {
               //searchCondition : 5,
               searchKeyword : searchKeyword
            }
         }
         
         if(sessionStorage.getItem("role") == "parent") {
            data = {
               searchCondition : 5,
               searchKeyword : searchKeyword
            }
         }
         
         $.ajax({
            url : "/message/rest/listMessage",
            type : "POST",
            data : JSON.stringify(data),
            headers : {
                       "Accept" : "application/json",
                       "Content-Type" : "application/json",                                    
                   },
            success : function(result) {
               if(result) {
                  console.log(result);
                  $('#getOtherMessage').remove();
                  makeOthersList(result);
               } else {
                  console.log("리스트 없음");
               }
            }
         })   
      } 
   })
})


// index_student : 수업 추가
function resetForm() {
	document.addStudentsRecordForm.reset();
	$('.lessonCheck').removeClass('show');
	$('.valCheck').removeClass('show');	
}

$(function() {
	// addStudentsRecord
	$('#addStudentsRecordBtn').on("click", function() {

		var valFlag = false;
		const lessonCode = document.addStudentsRecordForm.lessonCode.value;
		const lessonStartDate = document.addStudentsRecordForm.lessonStartDate.value;
		const fees = document.addStudentsRecordForm.fees.value;
		const payDueDate = document.addStudentsRecordForm.payDueDate.value;
		
		// 유효성 check
		if(lessonCode.length < 8 || lessonCode == null || lessonStartDate.length < 1 || lessonStartDate.length == null || fees.length < 1 || fees == null || payDueDate < 1 || payDueDate == null) {
			$('.valCheck').addClass('show');
		} else {
			$.ajax({
				 url: "http://localhost:8080/lesson/rest/checkLessonCode/"+lessonCode,
		            type: "GET",
		            headers : {
		                    "Accept" : "application/json",
		                    "Content-Type" : "application/json",                                    
		                },
		            success: function(result) {
		                if(result) {
		                	console.log(result);
		                	
		                	if(result == true) {
		                		valFlag = true;
		                	}
		                	
		                	if(!valFlag) {
		                		$('.lessonCheck').addClass('show');
		                		return;
		                	} else {
									document.addStudentsRecordForm.action = "/students/addStudentsRecord";
		            				document.addStudentsRecordForm.method = "POST";
		            				document.addStudentsRecordForm.submit();	

							}
		                	
		                } else {
		                	console.log("lesson/rest/checkLessonCode :: error || null");			                	
		                	$('.lessonCheck').addClass('show');
		                }
		            }
			})
		}
		
    	

	})
})








