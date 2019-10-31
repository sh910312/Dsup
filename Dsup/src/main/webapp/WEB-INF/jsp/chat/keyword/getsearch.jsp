<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><!-- VO 에 date 타입 날짜형식 바꾸기 링크 http://blog.naver.com/PostView.nhn?blogId=lbiryu&logNo=30037958388  -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %> 

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
 						<form action="insertRe" method="POST" name="frm">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>${search.title }</h3>
							</div>
							<div class="portlet-title pull-right">
								<h3>${search.userId }
									<fmt:formatDate value="${search.writeDate }" pattern="yy-MM-dd" />
								</h3>
							</div>
							<div class="clearfix">
							</div>
						</div>
						<!-- 대화입력창  -->
						<div class="portlet-footer">
							<div class="row">
							</div>
							<input type="hidden" name="searchId" value="${search.searchId }" />
							<div class="row">
								<br>
								<div id="text" class="form-group col-xs-12">
									${search.contents }
								</div>
								<br>
								<br>
								<hr>
									<div class="form-group col-xs-12">
										<c:forEach items="${reList }" var="re">
										${re.userId }  :
										${re.contents } 
										${re.writeDate }
										
											<button type="button" class="btn btn-default btn-xs">신고</button>
											<br>
											<br>
										</c:forEach>
										<div class="form-group col-xs-12" align="center">
										<my:paging paging="${paging}" jsFunc="go_page"/>
										</div>
									</div>
									<div class="form-group col-xs-9">
										<input style="height: 40px;" name="contents" id="contents" class="form-control" placeholder="댓글을 입력하세요." maxlength="20">
									</div>
										<button class="btn btn-default" style="width:100px;height:40px;">등&nbsp;&nbsp;록</button>
										<input type="hidden" name="page" value="1"/> <!-- 페이징 -->
							</div>
							<div align="center">
							
								<!-- 검색 완료시 (등록/수정) 버튼이 보이게 조건 추가.   -->
								<c:if test="${userId != null}"> --%>  <!-- 삭제=관리자권한 -->
									<button type="button" class="btn btn-default" style="height: 40px; width: 100px;">삭&nbsp;&nbsp;제</button>
								</c:if>
								<c:if test="${userId != null}">
									<!-- 등록/수정 = 관리자/유저 권한 -->
									<button type="button" class="btn btn-default" style="height: 40px; width: 100px;" onclick="javascript:openButton(0);">신&nbsp;&nbsp;고</button>
									<button type="button" class="btn btn-default" style="height: 40px; width: 100px;" onclick="javascript:openButton(1);">수&nbsp;&nbsp;정</button>
								</c:if>
								<button type="button" class="btn btn-default" style="height: 40px; width: 100px;" onclick="javascript:openButton(0);">돌아가기</button>
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>


<script type="text/javascript">

function go_page(p){
	document.frm.page.value= p;
	document.frm.submit();
}

</script>



</body>
</html>