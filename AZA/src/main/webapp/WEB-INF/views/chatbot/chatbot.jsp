<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>chatbot</title>
    <link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/main.css" rel="stylesheet">
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
	<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
    <script src="/resources/javascript/chatbot/chatbot.js" charset="UTF-8"></script>
    <link href="/resources/css/chatbot.css" rel="stylesheet">
    <link href="/resources/css/common.css" rel="stylesheet">
    <link href="/resources/css/styles.css" rel="stylesheet">
</head>
<style>
*, body {
	font-family: Pretendard, 'Noto Sans KR';
}

 *-ms-overflow-style: {
	none;
 }
 
*::-webkit-scrollbar {
  display: none;
} 
</style>
<body id="chatbot_body" class="bg-light">
<div id="main_container" class="container mt-5 position-relative d-flex align-itmes-center justify-content-center">
    <div class="chat bg-white p-5 rounded rounded-1 mt-5">
		<form class="form-inline">
	       <div class="form-group">
	           <button id="connect" class="btn btn-outline-primary btn-sm" type="submit" value="0">깨우기</button>
	           <button id="disconnect" class="btn btn-outline-gray btn-sm" type="submit" disabled="disabled">재우기
	           </button>
	       </div>
    	</form>
    	<div id="chat-box" class="w-100">
        <div id="messages-chat" class="messages-chat">

        </div>
        <div class="d-flex">
	   <img id="gold_basic" style="width:250px;" src="/resources/img/gold_2.gif" class="mb-5 hidden position-absolute bottom-0 col-3"/>
	   <img id="gold_sleep" style="width:200px;" src="/resources/img/gold_sleep.gif" class="mb-5 position-absolute bottom-0 col-3"/>
        </div>
        
        </div>
   </div>
        <div id="inputForm" class="p-1 input-group mb-0 position-absolute bottom-0 col-6 bg-white">
          <input class="form-control input" type="text" id="msg" placeholder="금쪽이와 대화하기" disabled="true"></input>
          <button id="send" class="btn btn-light btn-lg " type="submit"><i class="bi bi-send" disabled="true"></i></button>
        </div>
        	
</div>
    


<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>