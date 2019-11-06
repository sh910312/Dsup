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

        <!-- Login Form -->
        <form class="form panel__login-form" id="login-form" method="post" action="login">
          <div class="form__row">
            <input type="text" id="userId" class="form__input" name="userId" data-validation="userId" data-error="Invalid email address." required autofocus value = "${requestScope.member.userId}">
            <span class="form__bar"></span>
            <label for="userId" class="form__label">아이디</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="password" id="password" class="form__input" name="password" data-validation="length" data-validation-length="8-25" data-error="Password must contain 8-25 characters." required value = "${memberVO.password }">
            <span class="form__bar"></span>
            <label for="password" class="form__label">비밀번호</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="submit" class="form__submit" value="로그인">
            <a href="#password-form" class="form__retrieve-pass" role="button">비밀번호를 잊으셨나요?</a>
          </div>
        </form>

        <!-- Register Form -->
        <form class="form panel__register-form" id="register-form" method="post" action="/">
          <div class="form__row">
            <input type="text" id="register-email" class="form__input" name="register-mail" data-validation="email" data-error="Invalid email address." required>
            <span class="form__bar"></span>
            <label for="register-email" class="form__label">E-mail</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="password" id="register-password" class="form__input" name="register-pass" data-validation="length" data-validation-length="8-25" data-error="Password must contain 8-25 characters" required>
            <span class="form__bar"></span>
            <label for="register-password" class="form__label">Password</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="password" id="register-password-check" class="form__input" name="register-repeat-pass" data-validation="confirmation" data-validation-confirm="register-pass" data-error="Your passwords did not match." required>
            <span class="form__bar"></span>
            <label for="register-password-check" class="form__label">Check password</label>
            <span class="form__error"></span>
          </div>
          <div class="form__row">
            <input type="submit" class="form__submit" value="Register!">
          </div>
        </form>

        <!-- Forgot Password Form -->
        <form class="form panel__password-form" id="password-form" method="post" action="/">
          <div class="form__row">
            <p class="form__info">비밀번호를 찾고자 하는 DBhelper 이메일 ID를 입력해주시면 해당 메일 주소로 비밀번호 재설정 링크를 보내드립니다.</p>
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