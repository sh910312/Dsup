<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DBhelper</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.3.26/jquery.form-validator.min.js"></script>
<script src="./resources/js/index.js"></script>
<script src="./resources/js/memberClient.js"></script>
<script src="./resources/json.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,600" rel="stylesheet" type="text/css" >
<link href="./resources/css/index.css" rel="stylesheet" type="text/css" >
</head>
<body> 

<div class="panel_blur"></div>
  <div class="panel">
    <div class="panel__form-wrapper">
      <ul class="panel__headers">
        <li class="panel__header active"><a href="#" class="panel__link" role="button">회원탈퇴 완료</a></li>
      </ul>
      <div class="panel__forms">
		테이블스페이스, 유저 스키마, 백업 파일이 모두 삭제되었습니다. 결제 정보는 한달간 보관 후 삭제됩니다. 그동안 서비스를 이용해주셔서 갑사합니다. (_ _)
      </div>
      <div class="form__row">
            <input type="button" class="form__submit" value="로그인 페이지로 이동" onclick = "parent.location.href='./login'">
          </div>
    </div>
  </div>
</body> 
</html>