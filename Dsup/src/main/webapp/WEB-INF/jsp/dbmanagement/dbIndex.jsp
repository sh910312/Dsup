<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Database Management</title>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

	<style>
	.card { /* [윤정 1105] 카드에 마우스 올리면 마우스 커서 포인터로 */
		cursor:pointer;
	}
	img { /* [윤정 1105] 카드 이미지 흑백 */
		-webkit-filter: grayscale(100%);
		filter: gray;
	}
	.card:hover img { /* [윤정 1105] 카드에 마우스 올리면 이미지 컬러 */
		-webkit-filter: grayscale(0%);
		filter: none;
	}
	</style>
	<script>
	console.log("${payService}");
	</script>
</head>
<body>
<div class = "container">

<br><br><br>

<!-- 왜 안되지?? -->
<c:if test = "${payService!='Y'}">
<div class="alert alert-warning alert-dismissible fade show" role="alert" >
  <strong>종량제를 신청하지 않았습니다!</strong> 테이블 스페이스 관리, 유저 관리, 백업 생성 기능을 이용하실 수 없습니다.<br>
  <a href = "./distributingMain">종량제 신청하기</a>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
</c:if>

<div class="card-deck">

  <div class="card" onclick = "location.href='./storageList'" >
    <img src="./resources/images/db/dbindex_storage.jpg" class="card-img-top" alt="테이블스페이스 관리 이미지">
    <div class="card-body">
      <h5 class="card-title">테이블스페이스 관리</h5>
      <p class="card-text">테이블 스페이스는 테이블이 저장되는 공간입니다. 신청한 종량제 용량만큼 테이블스페이스를 만들 수 있습니다. </p>
    </div>
  </div>
  
  <div class="card" onclick = "location.href='./userList'">
    <img src="./resources/images/db/dbindex_user.jpg" class="card-img-top" alt="유저 관리 이미지">
    <div class="card-body">
      <h5 class="card-title">유저 관리</h5>
      <p class="card-text">유저 스키마를 생성 및 관리 합니다. </p>
    </div>
  </div>
  
  <div class="card" onclick = "location.href='./backupList'">
    <img src="./resources/images/db/dbindex_backup.jpg" class="card-img-top" alt="백업 이미지">
    <div class="card-body">
      <h5 class="card-title">백업</h5>
      <p class="card-text">테이블 스페이스 단위로 백업 할 수 있습니다.</p>
    </div>
  </div>

</div>

</div>
</body>
</html>