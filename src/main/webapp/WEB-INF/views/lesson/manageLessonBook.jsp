<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>manageLessonBook</title>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.js"></script> -->
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
   crossorigin="anonymous"></script>

<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
   integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
   crossorigin="anonymous">
<!-- jQuery library -->
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<!-- Latest compiled JavaScript -->
<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">

<script type="text/javascript">
   function fncAddLessonBook(e) {
      const p = [];
      p.push('hi')
      const select = $(".lessonbook");
      for (let i = 0; i < select.length; i++) {
         p.push($(select[i]).data('value'))
      }

      var a = $(e).parent().find(".select").val();
      var lessonCode = p[a];

      /* var lesson = $(this).data('value');
      console.log */
      $("#lessonbook").attr("method", "POST").attr("action",
            "/lesson/rest/addLessonBook?lessonCode=" + lessonCode).submit();

   }
   $(function() {
      $("button.btn.btn-outline-success").on("click", function() {
         fncAddLessonBook(this);
      });
   });

   function fncdeleteBook(value) {
	   let code = $(value).attr('value');
	   let isbn = $(value).attr('value2');
	   /* let bookValue = new Map();
	   bookValue.set('lessonCode',code)
	   bookValue.set('isbn',isbn); */
	   let bookValue = {'lessonCode':code, 'isbn':isbn};
	   
	   $.ajax({
		   type: 'POST',
		   enctype: 'multipart/form-data',
		   url: '/lesson/deleteLessonBook',
		   data: bookValue,
		   success:function() {
			   location.href = "/lesson/manageLessonBook";
		   }		   
	   })
	  
      /* $("#booklist").attr("method", "POST").attr("action","/lesson/deleteLessonBook="+bookValue).submit(); */
   }   
</script>

<style>
img {
   display: block;
   margin: 0px auto;
   -webkit-perspective: 1;
   image-rendering: -webkit-optimize-contrast;
   transform: translateZ(0);
   backface-visibility: hidden;
}

.form-control {
   right: 0;
}

*, body {
   font-family: Pretendard, 'Noto Sans KR';
}
</style>

</head>
<body style="background-color: #f5f5f5">

      <div class="mb-3 mr-5 pr-5">
         <form id="lessonbook">
         <c:if test="${user.role eq 'teacher'}">
            <div class="form-group" style="float:right">
                   <label for="lessonCode">수 업 명</label>
                   <select class="select" aria-label="Disabled select example" style="width:180px">
                          <!-- <option value=''> 선택</option> -->
                      <c:set var="i" value="0"/>
                      <c:forEach var="book" items="${book}">
                         <c:set var="i" value ="${i+1}"/>
                          <option class="lessonbook" value="${i}" data-value="${book.lessonCode}">${book.lessonName}</option>
                     </c:forEach>
                  </select>
                  <!-- <div class="col-sm-10">
                    <input type="text" class="form-control" id="lessonCode" name="lessonCode" placeholder="수업코드">
                  </div> -->
                    <!-- <div style="float:right"> -->
                     <input name="isbn" type="search" placeholder="isbn 입력" aria-label="Search">
                     <button class="btn btn-outline-success" type="button" ><i class="bi bi-search-heart"></i></button>
                  <!-- </div> -->
                </div>
            </c:if>
         </form>
      </div>
	<br/><br/><br/>

   
   <!-- <div class="mx-5 p-5"> -->
   <div>
      <div class="row gx-5" id="book">
         <c:set var="i" value="0" />
         <c:forEach var="lesson" items="${list}">
            <c:set var="i" value="${i+1}" />
            <form id="booklist" class="booklist col-md-3" style="margin-bottom: 10px;">
               <!-- <div class="col-md-4 mb-5 mt-3"> -->
                  <div class="card card-rased border border-top border-primary h-100">
                     <img src="${lesson.bookImg}" class="card-img-top embed-responsive-item">
                     
                     <div class="card-body">
                        <div class="overline text-muted mb-1">[${lesson.lessonName}]</div>
                        <h3 class="text-primary mb-3">${lesson.bookTitle}</h3>
                        <table class="table table-sm mb-0">
                                    <tbody>
                                        <tr>
                                            <td><div class="text-muted fst-italic">ISBN</div></td>
                                            <td></td>
                                            <td class="text-end"><div>${lesson.isbn}</div></td>
                                           </tr>
                                        <tr>
                                            <td class="text-muted"><div class="fst-italic">출판사</div></td>
                                            <td></td>
                                            <td class="text-end"><div>${lesson.publisher }</div></td>
                                        </tr>
                                        <tr>
                                            <td class="text-muted">가격</td>
                                            <td></td>
                                            <td class="text-end"><div class="">${lesson.bookPrice}</div></td>
                                        </tr>
                                        <tr>
                                            <td class="text-muted">저자</td>
                                            <td></td>
                                            <td class="text-end"><div class="">${lesson.author }</div></td>
                                        </tr>
                                        <tr>
                                            <td class="text-muted">발행년도</td>
                                            <td></td>
                                            <td class="text-end"><div class="">${lesson.bookYear}</div></td>
                                        </tr>
                                    </tbody>
                          </table>
                         <div style="margin-top:10px; position: absolute; right: 0px; bottom: 0px;">
                           <c:if test="${user.role eq 'teacher'}">
                              <button type="button" class="btn btn-outline-primary btn-sm text-center"
                                 id="btn05" value="${lesson.lessonCode}" value2="${lesson.isbn}" onClick="fncdeleteBook(this);">삭제</button>
                           </c:if>
                        </div>
                     </div>
                  </div>
               <!-- </div> -->
            </form>
         </c:forEach>
      </div>
   </div>
   
   <script src="/resources/javascript/common/prism.js"></script>
   <script src="/resources/javascript/common/material.js"></script>
   <script src="/resources/javascript/common/scripts.js"></script>
</body>
</html>