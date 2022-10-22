var studentId = "";


window.addEventListener('DOMContentLoaded', event => {
	//var studentId = hasSearchStudentId();
	console.log(studentId);
	
	getSubject(studentId);
});

// role == parent -> 자녀 아이디
function hasSearchStudentId() {
	
	var temp = document.location.href.split("/");
	var param = temp[temp.length-1];
	
	if(sessionStorage.getItem("role") !== 'parent') {
		return;
	}
	
	if(param !== 'manageStudentsExam') {
		studentId = param;
	} 
	
	if(sessionStorage.getItem("role") == 'parent' && param == 'manageStudentsExam') {
		
		$.ajax({
			url: "/user/rest/listRelationByParent/"+sessionStorage.getItem("userId"),
			type:"POST",
			headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
            async: false,
            success: function(result) {
						if(result) {
							var list = result.list;
							param = list[0].firstStudentId;
							console.log(param);
							studentId = param;
							console.log(studentId);
						} else {
							console.log("relation 없음!");
						}					
			}			
		})
	}	
}

var valFlag = true;

$(function() {
	$("#addExamFormHandler").on("click", function() {
		examFormHandler();
	})
	
	$("#addStudentsExamBtn").on("click", function() {
		
		var valFlag = true;
		const examYear = document.addStudentsExamForm.examYear.value;
		const examSemester = document.addStudentsExamForm.examSemester.value;
		const examTerm = document.addStudentsExamForm.examTerm.value;
		const examSubject = document.addStudentsExamForm.examSubject.value;
		const examScore = document.addStudentsExamForm.examScore.value;
		
		if(isNaN(examYear) || examYear == "" || examYear.length < 1) valFlag = false;
		if(isNaN(examSemester) || examSemester == "" || examSemester.length < 1) valFlag = false;
		if(isNaN(examScore) || examScore == "" || examYear.examScore < 1) valFlag = false;
		if(examTerm == "" || examTerm.length < 1) valFlag = false;
		if(examSubject == "" || examSubject.length < 1) valFlag = false;
		
		if(!valFlag) {
			$('.valCheck').removeClass('hidden');
			$("#addStudentsExamForm")[0].reset();
		} else {
			document.addStudentsExamForm.action = "/students/addStudentsExam";
			document.addStudentsExamForm.method = "POST";
			document.addStudentsExamForm.submit();	
		}
		
	})
	
	$('input').on('focus', function() {
		$('.valCheck').addClass('hidden');
	})
	
})

// 성적 추가 폼 활성화
function examFormHandler() {
	
	if($("#studentsExamFormOpenBtn").hasClass('hidden') == false) {
		$("#studentsExamFormOpenBtn").addClass('hidden');
		$("#addStudentsExamForm").removeClass('hidden');
		$("#studentsExamFormCloseBtn").removeClass('hidden');
		
	} else {
	$("#studentsExamFormCloseBtn").addClass('hidden');
	$("#addStudentsExamForm").addClass('hidden');
	$("#studentsExamFormOpenBtn").removeClass('hidden');
	$('.valCheck').addClass('hidden');	
	}
}


// 과목 리스트 가져오기
function getSubject(studentId) {

	var url = arguments.length > 0 ? "/students/rest/listStudentsExam/subject/" + studentId :  "/students/rest/listStudentsExam/subject";
	console.log(url);
	
	
	$.ajax({
		url: url,
		type:"POST",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        async: false,
        success: function(result) {
			if(result) {
				console.log(result);
				var subjectList = result;
				listExamBySubject(result[0], studentId);
				
			} else {
				console.log("정보 없음");
			}
		}    
	})
}

function makeExamDetailList(examCode, time, score, subject) {

                    
    var scoreDiv = `<div id="examDetail-${examCode}" name="examDetail" onclick="return updateFormHandler('${examCode}')" class="">
    					<div class="list-group-item d-flex justify-content-between px-0">
                     		${time}                  
                    		<div class="ms-2"> ${score}</div>	
						</div>
					</div>
					<div class="hidden text-end mt-2 mb-2" id="updateForm-${examCode}" name="updateForm">
						<form id='form${examCode}' name='updateForm${examCode}'action="/students/updateStudentsExam" method="POST">
							<input type="hidden" name="examCode" value="${examCode}"/>
							<button id="updateStudentsExamBtn" type="button" class="btn btn-outline-light btn-sm p-1" onclick="return updateStudentsExam('${examCode}')"><i class="bi bi-check-all"></i></button>
							<button id="deleteStudentsExamBtn" type="button" class="btn btn-outline-danger btn-sm p-1" onclick="return deleteExamDetail('${examCode}')"><i class="bi bi-trash"></i></button>
							<input class="col-3 p-1" type="text" name="examScore" placeholder="숫자만  :-)"/>
						</form>
					</div>`;
					

                    
    $("#examDetailList").append(scoreDiv);                                        
                                    
	
}

function updateStudentsExam(examCode) {
	
	if(isNaN($("input[name='examScore']").val())) {
		$("input[name='examScore']").val("");
		return;
	} else {
		$(`#form${examCode}`).submit();	
		
	}


}

function deleteExamDetail(examCode) {
	console.log(examCode);
	self.location.href = "/students/deleteStudentsExam?examCode="+examCode;
}


// updateForm 활성화
function updateFormHandler(examCode) {

	if($(`#examDetail-${examCode}`).hasClass('update') == false) {
		$(`#updateForm-${examCode}`).removeClass('hidden');	
		$(`#examDetail-${examCode}`).addClass("update");
		console.log("click");
	} else {
		$(`#updateForm-${examCode}`).addClass('hidden');	
		$(`#examDetail-${examCode}`).removeClass("update");
	}
	
	
	
}

// 과목별 점수 가져오기
function listExamBySubject(subject, studentId) {
	
	var data = {
		examSubject : subject
	}
	
	var url = arguments.length > 0 ? "/students/rest/listStudentsExam/"+studentId : "/students/rest/listStudentsExam";

	if(arguments.length < 2 && sessionStorage.getItem("role") == 'parent') {
		url += "/" + $('#studentsDropDown').children().first().dataset.studentid;
	}
	
	$.ajax({
		url:url,
		type:"POST",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
    	data: JSON.stringify(data),
    	async: false,
        success: function(result) {
			if(result) {
				console.log(result);
				
				$('#examSubject').text(subject);
				
				var examDatas = result.list;
				var times = [];
				var scores = [];
				
				$("#examDetailList").empty();
				var titleDiv = `<div class="list-group-item d-flex justify-content-between px-0">
                    <div class="caption text-white-50">년도 - 학기</div>
                    <div class="caption text-white-50 ms-2">점수</div>
                    </div>` ;
				$("#examDetailList").append(titleDiv);
				

				
				examDatas.map(exam => {
					var term = exam.examTerm == '1' ? '중간고사' : '기말고사';
					var tempLabel = exam.examYear + " - " + exam.examSemester + " " + term;
					times.push(tempLabel);
					scores.push(exam.examScore);
					
					makeExamDetailList(exam.examCode, tempLabel, exam.examScore, subject);
					
				})
				
				console.log(times);
				console.log(scores);
				//const labels = times;
				const data = {
								  labels: times,
								  datasets: [{
								    label: subject,
								    data: scores,
								    fill: true,
								    borderColor: '#7b68EE',
								    tension: 0.25
								  }]
								};
								
			var ctx = document.getElementById('dashboardAreaChart').getContext('2d');
			const config = {
						    type: 'line',
						    data: data,
						    options: {
							
						}
						  };					
			makeLineChart(ctx, config);
								
			} else {
				console.log("정보 없음");
			}
		}    
	})
}

// 클릭해서 과목별 차트 바꾸기
const setMyLineChart = (subject) => {
	console.log(subject);
	
		
	var data = {
		examSubject : subject
	}
	
	var temp = document.location.href.split("/");
	var studentId = temp[temp.length-1];
	var url = studentId !== 'manageStudentsExam' ? "/students/rest/listStudentsExam/" + studentId : "/students/rest/listStudentsExam/";
	
	$.ajax({
		url:url,
		type:"POST",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
            async: false,
    	data: JSON.stringify(data),
        success: function(result) {
			if(result) {
				console.log(result);
				$('#examSubject').text(subject);
				
				var examDatas = result.list;
				var times = [];
				var scores = [];
				
				$("#examDetailList").empty();
				var titleDiv = `<div class="list-group-item d-flex justify-content-between px-0">
                    <div class="caption text-white-50">년도 - 학기</div>
                    <div class="caption text-white-50 ms-2">점수</div>
                    </div>` ;
				$("#examDetailList").append(titleDiv);
				
				examDatas.map(exam => {
					var term = exam.examTerm == '1' ? '중간고사' : '기말고사';
					var tempLabel = exam.examYear + " - " + exam.examSemester + " " + term;
					times.push(tempLabel);
					scores.push(exam.examScore);
					
					makeExamDetailList(exam.examCode, tempLabel, exam.examScore, subject);
					
				})   
				
				console.log(times);
				console.log(scores);
				
				const labels = times;
				const data = {
								  labels: labels,
								  datasets: [{
								    label: subject,
								    data: scores,
								    fill: true,
								    borderColor: '#7b68EE',
								    tension: 0.25
								  }]
								};
	
				const chart = Chart.getChart("dashboardAreaChart");
				chart.data = data;
				chart.update();
				console.log(chart.data);
				
    		} else {
				console.log("error");
			}}	
	})
}
var makeLineChart = (ctx, config) => new Chart(ctx,config);
