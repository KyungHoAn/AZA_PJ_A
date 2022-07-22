function nullInputAlert(nullInput) {
	Swal.fire({
	    title: 'Oooops',
	    text: nullInput+' 입력해주세요!',
	    icon: 'question',
	    confirmButtonColor: '#9966FF',
	    confirmButtonText: '확인'
 	})
}

function confirmDelete() {
	Swal.fire({
	  title: '정말 삭제하시겠습니까?',
	  icon: 'question',
	  showDenyButton: true,
	  confirmButtonText: '삭제',
	  confirmButtonColor: '#d33',
	  denyButtonColor: "#9966FF"
	}).then((result) => {
  /* Read more about isConfirmed, isDenied below */
  if (result.isConfirmed) {
	$("form").attr("method", "POST").attr("action","/paper/deletePaperHomework").submit();
  } else if (result.isDenied) {
    Swal.fire('삭제가 취소되었습니다', '', 'info')
  }
})
}

$(function () {
         $('#lessonName').change(function() {
            $('#studentName').html("");
            var lessonName = $('option:selected').val().trim();
            //alert("=====>"+lessonName);
             $.ajax(
                  {url : "/students/rest/listStudentsRecordByLessonName/"+lessonName ,
                     method : "GET" ,
                     dataType : "json" ,
                     headers : {
                        "Accept" : "application/json",
                        "Content-Type" : "application/json"
                     },
                     success : function(JSONData , status) {
                        console.log(JSONData);
                        console.log(status);
                        
                        for(var i=0; i<JSONData.list.length; i++){
                           var studentName = JSONData.list[i].studentName;
                           var studentId = JSONData.list[i].studentId;
                           var newSelect = `<option align="left" value="`+studentId+`" >`+studentName;
                           
                           $('#studentName').append(newSelect);

                              }


                     }
                  }      
            )         
         })         
      });
		
function addBtn(){

	var lessonName = $('option:selected').text().trim();
	var homeworkTitle = $("input[name='homeworkTitle']").val();
	var studentName = $('option:selected').text().trim();
	var homeworkDueDate = $("input[name='homeworkDueDate']").val();
	var homeworkContent = $("textarea[name='homeworkContent']").val();
	
	if(homeworkTitle == null || homeworkTitle.length<1){
		nullInputAlert("제목을");
	} else if(homeworkContent == null || homeworkContent.length<1){
		nullInputAlert("과제 내용을");
	} else {
		$("form").attr("method","POST").attr("action" , "/paper/addPaperHomework").submit();	
	}
}

function cancelBtn() {
	history.go(-1);
}


	$(function() {
	
	$( "button.btn.btn-outline-primary:contains('수정')").on("click" , function() {
		
		document.getElementById("homeworkTitle").readOnly=false;
		document.getElementById("homeworkDueDate").readOnly=false;
		document.getElementById("homeworkContent").readOnly=false;
		
		$("#goUpdateBtn").hide();
		$("#updateBtn").show();
		$("#cancelBtn").show();
		$("#goBackBtn").hide();

		
		
	    const homeworkDueDate = document.getElementById('homeworkDueDate');
	    homeworkDueDate.type = "date";
	});
});
	
	$(function() {
		
	$( "button.btn.btn-outline-primary:contains('확인')").on("click" , function() {
		
		var lessonName = $('option:selected').text().trim();
		var homeworkTitle = $("input[name='homeworkTitle']").val();
		var studentName = $("input[name='studentName']").val();
		var homeworkDueDate = $("input[name='homeworkDueDate']").val();
		var homeworkContent = $("textarea[name='homeworkContent']").val();
		
		if(homeworkTitle == null || homeworkTitle.length<1){
			nullInputAlert("제목을");
		}

		if(homeworkContent == null || homeworkContent.length<1){
			alert("과제 내용을 반드시 입력해야합니다.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action","/paper/updatePaperHomework").submit();
		$("#lessonNameList").hide();
		$("#lessonNameListInput").show();
	});
	});
	
function deleteBtn() {
	confirmDelete();
}


function goBackBtn() {
	if(sessionStorage.getItem("role") == 'teacher'){
		history.go(-1);				
	} else{
		self.location = "/paper/listPaperHomework"
	}
}

function cancelBtn() {
	if(sessionStorage.getItem("role") == 'teacher'){
		history.go(-1);				
	}else{
		self.location = "/paper/listPaperHomework"
	}
}
