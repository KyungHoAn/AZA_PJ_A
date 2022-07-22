function submitPost() {

	  const noteContent = $("#summernote").val()
	  const noteTitle = $("#noteTitle").val()
	  // 값을 불러올 땐 document.get으로 받아오기
	  if(noteTitle == "" || noteTitle.lenght < 1){
		  Swal.fire({
		    title: '저런...',
		    text: '제목은 필수 입력사항입니다',
		    icon: 'error',
		    confirmButtonColor: '#9966FF',
		    confirmButtonText: '확인'
	 	})
	  } else  if(noteContent == "" || noteTitle.lenght < 1) {
		  Swal.fire({
			    title: '이런...',
			    text: '내용없는 노트...? 흠...🤔',
			    icon: 'error',
			    confirmButtonColor: '#9966FF',
			    confirmButtonText: '확인'
		 	})
	  } else {
      $("form").attr("method","POST").attr("action" , "/students/addStudentsNote").submit();
		
	}
   
	  
}

$(function() {
	
	$( "button.btn.btn-outline-primary:contains('취소')").on("click" , function() {
		history.go(-1);
	});
});	


$(document).ready(function() {

var toolbar = [
	    // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 표만들기
	    ['table', ['table']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
	    ['insert',['picture','link','video']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ];

var setting = {
        height : 300,
        minHeight : null,
        maxHeight : null,
        focus : true,
        lang : 'ko-KR',
        toolbar : toolbar,
        callbacks : { //여기 부분이 이미지를 첨부하는 부분
        onImageUpload : function(files, editor,
        welEditable) {
        for (var i = files.length - 1; i >= 0; i--) {
        uploadSummernoteImageFile(files[i],
        this);
        		}
        	}
        },
		onPaste: function (e) {
			var clipboardData = e.originalEvent.clipboardData;
			if (clipboardData && clipboardData.items && clipboardData.items.length) {
				var item = clipboardData.items[0];
				if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
					e.preventDefault();
				}
			}
		}
     };

$('#summernote').summernote(setting);
});

function uploadSummernoteImageFile(file, editor) {
	data = new FormData();
	data.append("file", file);
	$.ajax({
		data : data,
		type : "POST",
		url : "/uploadSummernoteImageFile",
		contentType : false,
		processData : false,
		success : function(data) {
        	//항상 업로드된 파일의 url이 있어야 한다.
			$(editor).summernote('insertImage', data.url);
		}
	});
}

$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '노트 작성란'	//placeholder 설정

	});
});	


// updateStudentsNote.js 
function updateBtn() {
	
	  const noteContent = $("#summernote").val()
	  const noteTitle = $("#noteTitle").val()
	  // 값을 불러올 땐 document.get으로 받아오기
	  if(noteTitle == "" || noteTitle.lenght < 1){
		  Swal.fire({
		    title: '저런...',
		    text: '제목은 필수 입력사항입니다',
		    icon: 'error',
		    confirmButtonColor: '#9966FF',
		    confirmButtonText: '확인'
	 	})
	 	//return;
	  } else if(noteContent == "" || noteTitle.lenght < 1) {
		  Swal.fire({
			    title: '이런...',
			    text: '내용없는 노트...? 흠...🤔',
			    icon: 'error',
			    confirmButtonColor: '#9966FF',
			    confirmButtonText: '확인'
		 	})
		 	//return;
	  } else {
		
      $("form").attr("method","POST").attr("action" , "/students/updateStudentsNote").submit();
	}

	 		  
}

function deleteBtn() {
	
	Swal.fire({
	  title: '삭제하시겠습니까?',
	  icon: 'question',
	  showDenyButton: true,
	  confirmButtonText: '삭제',
	  confirmButtonColor: "#d33",
	  denyButtonText: `취소`,
	  denyButtonColor: `gray`,
	}).then((result) => {
	  /* Read more about isConfirmed, isDenied below */
	  if (result.isConfirmed) {
	    $("form").attr("method", "POST").attr("action","/students/deleteStudentsNote").submit();
	  } else if (result.isDenied) {
	    Swal.fire('삭제가 취소되었습니다', '', 'info')
	  }
	})
	


}

$(function() {
	
	$( "button.btn.btn-outline-primary:contains('뒤로')").on("click" , function() {
		history.go(-1);
	});
});	



