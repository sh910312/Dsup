<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
		/* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
         .modal2 {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 20%; /* Could be more or less, depending on screen size */                          
        	height: 40%
        }
        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
</style>
</head>
<body>
	<!-- Trigger/Open The Modal -->
    <button id="myBtn">정보변경</button>
 	${sessionScope.member.nickname}
 	<a href="logout">로그아웃</a>
 	
	<br><br><br><br><br><br><br><br><br>
	
	<button>SQL</button><br>
	<button>DB</button><br>
	<button>종량제</button>
	
    <!-- The Modal -->
    <div id="myModal" class="modal">
      <!-- Modal content -->
      <div class="modal-content">
        <div id="myInfo">
	        <span class="close">&times;</span>                                                               
	      	<h3>MyInfo</h3>
			아이디: ${member.userId}<br>
			닉네임: ${member.nickname}<br>
			이메일: ${member.eMail}<br>
			가입날짜: <fmt:parseDate value="${member.userDate}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
				    <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/><br>
			<br><br><br><br><br><br><br>
			
			<button id="myBtn2">정보변경</button>
		</div>
		<div id="modify">
		    <span class="close">&times;</span> 
		    <h3>Modify</h3>
		      아이디: ${member.userId}<br>
			닉네임: <br>
			이메일: <br>
		</div>
      </div>
	</div>
    
    
<script type="text/javascript">
	var modal = document.getElementById('myModal');
	var myInfo = document.getElementById('myInfo');
	var modify = document.getElementById('modify');
	var btn = document.getElementById("myBtn");
	var btn2 = document.getElementById("myBtn2");
	var close = document.getElementsByClassName("close")[0]; 
	
	modify.style.display = "none";
	btn.onclick = function() {
	    modal.style.display = "block";
	}
	btn2.onclick = function(){
		modify.style.display = "block";
	    myInfo.style.display = "none";
	}
	close.onclick = function() {
	    modal.style.display = "none";
	}
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
</script>
</body>
</html>