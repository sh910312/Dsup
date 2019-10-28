<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/bootstrap.css">
<link rel="stylesheet" href="./resources/css/custom.css">
<script src="./resources/js/sockjs.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
</head>
<body>
<div class="container">
		<div>
			<div class="row">
				<div class="col-xs-13">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>
									<i class="fa fa-circle text-green"></i>D-sup 검색하기
								</h3>
							</div>
							<div class="clearfix">
							</div>
						</div>
							<!-- 대화입력창  -->
							<div class="portlet-footer">
								<div class="row" >
									<form>
									<div class="form-group col-xs-10">
										<input style="height: 40px;" name="title" id="title" class="form-control" placeholder="검색할 내용을 입력하세요." maxlength="20">
									</div>
										<button class="btn btn-default" style="height:40px; width:100px;">검&nbsp;&nbsp;색</button>
									</form>
								</div>
								<form action="deleteSearchList">
								<div class="row">	
			<br>
									<div id="text" class="form-group col-xs-12"> <!-- 검색 완료 후 결과보이게 조건 추가  -->

										<c:forEach items="${searchList }" var="search">
										<div class="form-group col-xs-3">
										
										
										<!-- 삭제권한은 관리자만 -->
										<c:if test="${userId != null}">
										<input id="text" name="searchList" type="checkbox" value="${search.searchId }"/>
										</c:if>
										
										<a href="getSearch?seq=${search.searchId }"> ${search.title }</a>
										${search.userId }
										${search.writeDate }
										</div>
										</c:forEach>


									
									</div>
								</div>
								<div align="center"> <!-- 검색 완료시 (등록/수정) 버튼이 보이게 조건 추가.   -->
								<c:if test="${userId != null}">  <!-- 삭제=관리자권한 -->
 									<button class="btn btn-default" style="height:40px; width:100px;">삭&nbsp;&nbsp;제</button>
 								</c:if>
 								<c:if test="${userId != null}">  <!-- 등록/수정 = 관리자/유저 권한 -->
 									<button type="button" class="btn btn-default" style="height:40px; width:100px;" onclick="javascript:openButton(0);">등&nbsp;&nbsp;록</button>
									<button type="button" class="btn btn-default" style="height:40px; width:100px;" onclick="javascript:openButton(1);">수&nbsp;&nbsp;정</button>
								</c:if>
									<button type="button" class="btn btn-default" style="height:40px; width:100px;" onclick="self.close();">닫&nbsp;&nbsp;기</button>
								</div>
								</form>
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>













































<%-- 
<form>
검색이름 <input name="title">
<button> 검색 </button>
</form>

<form action="deleteSearchList">
<br><br>
<button>선택삭제</button>
	<c:forEach items="${searchList }" var="search">
		<div><input name="searchList" type="checkbox" value="${search.searchId }"/>
		${search.searchId }
		<a href="getSearch?seq=${search.searchId }"> ${search.title }</a>
		${search.userId }
		${search.writeDate }
		</div>
	</c:forEach>
</form> --%>


</body>
</html>