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
        <span class="close">&times;</span>                                                               
      	<h3>MyInfo</h3>
		아이디: ${member.userId}<br>
		닉네임: ${member.nickname}<br>
		이메일: ${member.eMail}<br>
		가입날짜: <fmt:parseDate value="${member.userDate}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
		<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/><br>
		<br><br><br><br><br><br><br>
		<button id="myBtn">정보변경</button>
      </div>
    </div>
    
    <div id="myModal2" class="modal">
    	<div class="modal-content">
    		<span class="close">&times;</span> 
    		111111
    	</div>
    </div>
    
<script type="text/javascript">
	// Get the modal
	var modal = document.getElementById('myModal');
	var model2 = document.getElementById('myModal2');
	// Get the button that opens the modal
	var btn = document.getElementById("myBtn");
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];                                          
	// When the user clicks on the button, open the modal 
	btn.onclick = function() {
	    modal.style.display = "block";
	}
	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	    modal.style.display = "none";
	}
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
</script>
</body>
</html>