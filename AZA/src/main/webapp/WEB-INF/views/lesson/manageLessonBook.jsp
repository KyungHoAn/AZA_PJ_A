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
      console.log(p)

      var a = $(e).parent().find(".select").val();
      console.log(a)
      var lessonCode = p[a];
      console.log(lessonCode)

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

   function fncdeleteBook() {
      
      $("#booklist").attr("method", "GET").attr("action","/lesson/deleteLessonBook").submit();
   }
   $(function() {
      $("#booklist").on("click",function() {
         fncdeleteBook();
      });
   });
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

<br>
<div class="mx-5 px-5">
   <div class="mx-5 px-5">
      
         <div class="row row-cols-1 row-cols-md-4 mt-5 g-4" id="book">
               <c:set var="i" value="0"/>
                  <c:forEach var="lesson" items="${list}">
                     <c:set var="i" value="${i+1}"/>
                     <form id="booklist" class="booklist">
                  <div class="col">
                   <div class="card h-100" align="center" >

                        
                       <div class="embed-responsive embed-responsive-4by3">
                       <!-- class="card-img-top" style="width:240px; height:240px;" -->
                        <img src="${lesson.bookImg}" class="card-img-top embed-responsive-item">
                     </div>
                     <div class="card-body">
                       <h5 class="card-title">교재 정보</h5>
                       <div class="input-group">
                           <p class="btn btn-outline-primary" style="font-size:15px; border:0;">isbn : 
                            <input type="text" name="isbn" id="isbn" value="${lesson.isbn}" aria-label="Example text with button addon" 
                             style="font-size:15px; background-color:white;border:0;"aria-describedby="button-addon1" readOnly="true"></p>
                       </div>
                       <div class="input-group">   
                           <p class="btn btn-outline-primary" style="font-size:15px; border:0;">책제목 : 
                            <input type="text" value="${lesson.bookTitle}" aria-label="Example text with button addon" 
                             style="font-size:15px; background-color:white;border:0; width:300px"aria-describedby="button-addon1" readOnly="true"></p>
                       </div>
                       <div class="input-group">
                           <p class="btn btn-outline-primary" style="font-size:15px; border:0;">출판사 : 
                            <input type="text" value="${lesson.publisher}" aria-label="Example text with button addon" 
                             style="font-size:15px; background-color:white;border:0;" aria-describedby="button-addon1" readOnly="true"></p>
                       </div> 
                       <div class="input-group">
                           <p class="btn btn-outline-primary" style="font-size:15px; border:0;">가격 : 
                            <input type="text" value="${lesson.bookPrice}" aria-label="Example text with button addon" 
                             style="font-size:15px; background-color:white;border:0;" aria-describedby="button-addon1" readOnly="true"></p>
                       </div>
                       <div class="input-group">
                           <p class="btn btn-outline-primary" style="font-size:15px; border:0;">저자 : 
                            <input type="text" value="${lesson.author}" aria-label="Example text with button addon" 
                             style="font-size:15px; background-color:white;border:0;" aria-describedby="button-addon1" readOnly="true"></p>
                       </div> 
                       <div class="input-group">
                           <p class="btn btn-outline-primary" style="font-size:15px; border:0;">발행년도 : 
                            <input  type="text" value="${lesson.bookYear}" aria-label="Example text with button addon" 
                             style="font-size:15px; background-color:white;border:0;" aria-describedby="button-addon1" readOnly="true"></p>
                       </div>
                       <div class="input-group">
                           <p class="btn btn-outline-primary" style="font-size:15px; border:0;">수업명 : 
                            <input type="text" value="${lesson.lessonName}" aria-label="Example text with button addon" 
                             style="font-size:15px; background-color:white;border:0;" aria-describedby="button-addon1" readOnly="true"></p>
                       </div>
                          <%-- <p data-value="${lesson.lessonCode}"> --%>
                            <input type="hidden" value="${lesson.lessonCode}" name="lessonCode" class="lessonCode" readOnly="true">
                            
                       <c:if test="${user.role eq 'teacher'}">
                        <button type="hidden" class="btn btn-outline-primary" id="btn05">삭제</button>
                        <%-- <p class="card-text"><button type="button" class="ct_btn01" id="ct_btn01" isbn="${lesson.isbn}">삭제</button></p> --%>
                     </c:if>
                       
                       <%-- <p class="card-text" name="isbn" id="isbn">isbn = ${lesson.isbn}</p>
                     <p class="card-text">책제목 = ${lesson.bookTitle}</p>
                     <p class="card-text">출판사 = ${lesson.publisher}</p>
                     <p class="card-text">가격 = ${lesson.bookPrice}</p>
                     <p class="card-text">저자 = ${lesson.author}</p>
                     <p class="card-text">발행년도 = ${lesson.bookYear}</p>
                     <p class="card-text">수업명 = ${lesson.lessonName}</p>
                     <c:if test="${user.role eq 'teacher'}">
                        <button type="button" class="ct_btn01" id="ct_btn01" data-value="${lesson.isbn}">삭제</button>
                     </c:if> --%>
                     </div>
                   </div>
                 </div>
                 </form>
            </c:forEach>
         </div>
         
         <!-- <div id = "bookDataSimple">
         </div> -->
      
   </div>
</div>
<%--    <div class="mb-3 mr-5 pr-5">
      <form id="lessonbook" class="text-center">
         <c:if test="${user.role eq 'teacher'}">
            <div class="form-group form-group pr-5 mb-3 col-3" style="float: right">
               <label for="lessonCode" class="mr-3">수업명</label> <select class="select"
                  aria-label="Disabled select example" style="width: 180px">
                  <!-- <option value=''> 선택</option> -->
                  <c:set var="i" value="0" />
                  <c:forEach var="book" items="${book}">
                     <c:set var="i" value="${i+1}" />
                     <option class="lessonbook text-muted" value="${i}"
                        data-value="${book.lessonCode}">${book.lessonName}</option>
                  </c:forEach>
               </select>
               <div class="input-group input-group-sm mb-3">
                    <input placeholder="isbn 입력" name="isbn" type="search" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
                  <button id="addLessonBookBtn" class="btn btn-sm btn-outline-success" type="button"><i class="bi bi-search-heart"></i></button>
               </div>
               
            </div>
         </c:if>
      </form>
   </div>

   <br>
   <br/>

   
   <div class="mx-5 p-5">
      <div class="row gx-5" id="book">
         <c:set var="i" value="0" />
         <c:forEach var="lesson" items="${list}">
            <c:set var="i" value="${i+1}" />
            <form id="booklist" class="booklist">
               <div class="col-md-4 mb-5 mt-3">
                  <div class="card card-rased border border-top border-primary h-100">
                     <img src="${lesson.bookImg}" class="card-img-top embed-responsive-item">
                     
                     <div class="card-body">
                        <div class="overline text-muted mb-1">[${lesson.lessonName}]</div>
                        <h2 class="text-primary mb-3">${lesson.bookTitle}</h2>
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
                                <div class="text-end mt-3">
                           <c:if test="${user.role eq 'teacher'}">
                              <button type="button" class="btn btn-outline-primary btn-sm  text-center"
                                 id="btn05" lessonCode1="${lesson.lessonCode}"
                                 data-ttta="${lesson.lessonCode}">삭제</button>
                           </c:if>
                        </div>
                     </div>
                  </div>
               </div>
            </form>
         </c:forEach>
      </div>
   </div> --%>
   
   <script src="/resources/javascript/common/prism.js"></script>
   <script src="/resources/javascript/common/material.js"></script>
   <script src="/resources/javascript/common/scripts.js"></script>
</body>
</html>