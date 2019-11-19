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
        <li class="panel__header"><a href="#register-form" class="panel__link" role="button">회원가입</a></li>
        <li class="panel__header active"><a href="#login-form" class="panel__link" role="button">로그인</a></li>
      </ul>
      <div class="panel__forms">

        <!-- 로그인 폼 -->
        <form class="form panel__login-form" id="login-form" method="post" action="login">
          <div class="form__row">
            <input type="text" id="login-userId" class="form__input" name="userId" data-validation="userId" 
            	   data-error="" required value="${member.userId}">
            <span class="form__bar"></span>
            <label for="userId" class="form__label">아이디</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="password" id="login-password" class="form__input" name="password" data-validation="password" 
            	   data-error="" required>
            <span class="form__bar"></span>
            <label for="password" class="form__label">비밀번호</label>
            <span class="form__error">${msg}</span>
          </div>
          <div class="form__row">
            <input type="submit" id="checkValue" class="form__submit" value="로그인">
            <a href="#password-form" class="form__retrieve-pass" role="button">비밀번호를 잊으셨나요?</a>
          </div>
        </form>

        <!-- 회원가입 폼 -->
        <form class="form panel__register-form" id="register-form" method="post"  >
          <div class="form__row">
            <input type="text" id="userId" class="form__input" name="userId" data-validation="userId" data-error="" required>
            <span class="form__bar"></span>
            <label for="userId" class="form__label">아이디</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="text" id="nickname" class="form__input" name="nickname" data-validation="nickname" data-error="" required>
            <span class="form__bar"></span>
            <label for="nickname" class="form__label">닉네임</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="password" id="password" class="form__input" name="password" data-validation="password" data-validation="password" data-error="" required>
            <span class="form__bar"></span>
            <label for="password" class="form__label">비밀번호</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="password" id="password-check" class="form__input" name="password2" data-validation="confirmation" data-validation-confirm="register-pass" data-error="" required>
            <span class="form__bar"></span>
            <label for="password-check" class="form__label">비밀번호 확인</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="text" id="email" class="form__input" name="eMail" data-validation="email" data-error="" required>
            <span class="form__bar"></span>
            <label for="email" class="form__label">이메일</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="text" id="phonenumber" class="form__input" name="phonenumber" data-validation="phonenumber" data-error="" required>
            <span class="form__bar"></span>
            <label for="phonenumber" class="form__label">전화번호</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="button" class="form__submit" value="회원가입" id="btnInsert">
          </div>
        </form>

        <!-- 비밀번호 찾기 폼 -->
        <form class="form panel__password-form" id="password-form" method="post" action="logina">
          <div class="form__row">
            <p class="form__info">DBhelper에 등록된 이메일 주소를 입력해주시면 해당 메일 주소로 임시비밀번호를 보내드립니다.</p>
          </div>
          <div class="form__row">
            <input type="text" id="retrieve-pass-email" class="form__input" name="retrieve-mail" data-validation="email" data-error="Invalid email address." required>
            <span class="form__bar"></span>
            <label for="retrieve-pass-email" class="form__label">이메일 주소</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="submit" class="form__submit" value="이메일 보내기">
          </div>
        </form>
      </div>
    </div>
  </div>
</body> 
</html>