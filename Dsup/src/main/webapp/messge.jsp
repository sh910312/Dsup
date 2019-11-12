<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>API Demo: Request KakaoTalk friends list - Kakao JavaScript SDK</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

</head>
  <!-- <form action="sendSms.do" method="post" id="smsForm"> -->
  <form method="post" id="smsForm">
    <ul>
      <li>보내는사람 : <input type="text" name="from"/></li>
      <li>내용 : <textarea name="text"></textarea></li>
      <li><input type="button" onclick="sendSMS('sendSms')" value="전송하기" /></li>
    </ul>
  </form>

  <script>
    function sendSMS(pageName){

    	console.log("문자를 전송합니다.");
    	$("#smsForm").attr("action", pageName + ".do");
    	$("#smsForm").submit();
    }
  </script>
</html>