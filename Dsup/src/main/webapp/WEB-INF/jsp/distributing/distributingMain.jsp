<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v3.8.5">
<title>Pricing</title>

<!-- <link rel="canonical" href="https://getbootstrap.com/docs/4.3/examples/pricing/"> -->
<!-- <link href="/docs/4.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="./resources/json.min.js"></script>

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}
@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
<!-- <link href="pricing.css" rel="stylesheet"> -->
</head>
<body>
	<div>
		<%@include file="../bar.jsp"%>
	</div>
	
	<div
		class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
		<h1 class="display-4">가격</h1>
		<p class="lead">저장공간이 필요한가요?</p>
	</div>
	<div class="container">
		<div class="card-deck mb-3 text-center">
			<div class="card mb-4 shadow-sm">
				<div class="card-header">
					<h4 class="my-0 font-weight-normal">0.25GB</h4>
				</div>
				<div class="card-body">
					<h1 class="card-title pricing-card-title">
						<span class="paymoney">10</span>원 <small class="text-muted">/ 월</small>
					</h1>
					<ul class="list-unstyled mt-3 mb-4">
						<li>0.25GB의 저장용량</li><br>
						<li>지금 계정을 업그레이드하여</li>
						<li>0.25GB 저장공간을 사용해보세요.</li>
					</ul>
					<button type="button" class="paybtn btn btn-lg btn-block btn-primary">업그레이드</button>
				</div>
			</div>
			<div class="card mb-4 shadow-sm">
				<div class="card-header">
					<h4 class="my-0 font-weight-normal">0.5GB</h4>
				</div>
				<div class="card-body">
					<h1 class="card-title pricing-card-title">
						<span class="paymoney">200</span>원 <small class="text-muted">/ 월</small>
					</h1>
					<ul class="list-unstyled mt-3 mb-4">
						<li>0.5GB의 저장용량</li><br>
						<li>지금 계정을 업그레이드하여</li>
						<li>0.5GB 저장공간을 사용해보세요.</li>
					</ul>
					<button type="button" class="paybtn btn btn-lg btn-block btn-primary">업그레이드</button>
				</div>
			</div>
			<div class="card mb-4 shadow-sm">
				<div class="card-header">
					<h4 class="my-0 font-weight-normal">1GB</h4>
				</div>
				<div class="card-body">
					<h1 class="card-title pricing-card-title">
						<span class="paymoney">300</span>원 <small class="text-muted">/ 월</small>
					</h1>
					<ul class="list-unstyled mt-3 mb-4">
						<li>1GB의 저장용량</li><br>
						<li>지금 계정을 업그레이드하여</li>
						<li>1GB 저장공간을 사용해보세요.</li>
					</ul>
					<button type="button" class="paybtn btn btn-lg btn-block btn-primary">업그레이드</button>
				</div>
			</div>
		</div>
	</div>
<!-- 결제 api -->

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
	var IMP = window.IMP; // 생략가능
	IMP.init('imp51227222'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	$('.paybtn').click(function(){
		//결제 테스트용
		/* var amount = $(this).closest(".card-body").find(".paymoney").text()
		var payItem = $(this).closest(".card").find("h4").text()
		$.ajax({
	        	url:"pays",
	        	type:"POST",
	        	contentType:'application/json',
	        	data:JSON.stringify({"payPrice":amount, "payItem":payItem, "payType":'card'}),
	        	success: function(data) {
	        		console.log(data);
	        	}
	        });  
		  return; */
	var amount = $(this).closest(".card-body").find(".paymoney").text()
	var payItem = $(this).closest(".card").find("h4").text()
		IMP.request_pay({
		    pg : 'html5_inicis', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '종량제 결제',
		    amount : amount,
		    buyer_name : '${member.userId}',
		    buyer_nickname : '${member.nickname}',
		    buyer_email : '${member.eMail}',
		    /* m_redirect_url : 'http://localhost/dsup/distributingMain2' 모바일에서 결제시 페이지이동*/
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.\n테이블스페이스를 생성해주세요.';
		        window.location.href = 'http://39.116.34.40/Dsup/storageList';
		       /*  msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num; */
		        
		        $.ajax({
		        	url:"pays",
		        	type:"POST",
		        	contentType:'application/json',
		        	data:JSON.stringify({"payPrice":amount, "payItem":payItem, "payType":'card'}),
		        	success: function(data) {
		        		console.log(data);
		        	}
		        }); 
		        
		    } else {
		        var msg = '결제에 실패하였습니다.';
		       /*  msg += '에러내용 : ' + rsp.error_msg; */
		    }
		    alert(msg);
		});
	
	});
</script>
</body>
</html>
