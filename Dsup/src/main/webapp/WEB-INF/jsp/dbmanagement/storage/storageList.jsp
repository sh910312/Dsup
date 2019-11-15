<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Storage List</title>
<!-- 부트스트랩 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<!-- 토스트 css -->
<link rel = "stylesheet" href="./resources/css/Toast.css">
<script>
	$(document).ready(function() {
		tablespaceList();
		getVolumn();
		btnClickFunc(); // 버튼 클릭 이벤트
		$("#delbtn").click(function() {
			$("#frm").attr("action", "storageDelete");
			$("#frm").submit();
		});
		// 삭제 버튼 클릭

		$("#crebtn").click(function() {
			$("#frm").attr("action", "storageCreateForm");
			$("#frm").submit();
		});
		// 생성 버튼 클릭
		radioCheck();
		delCheck();
	});
	// [윤정 1114] 수정/삭제/조회 버튼 클릭
	function btnClickFunc() {
		$(".yj_btn").click(function() {
			var tablespaceName = $('input:radio[name="tablespaceName"]:checked').val();
			if (typeof tablespaceName == "undefined") { // 체크하지 않았을 경우
				$('#tsError').fadeIn(400).delay(1000).fadeOut(400);
			} else { // 체크했을 경우
				switch( $(this).val() ) {
				case "수정":
					$("#frm").attr("action", "storageUpdateForm");
					$("#frm").submit();
					break;
				case "삭제":
					$("#frm").attr("action", "storageDelete");
					$('#delModal').modal('show')
					break;
				case "조회":
					$("#frm").attr("action", "storageShow");
					$("#frm").submit();
					break;
				} // switch
			} // if else
		});
	}

	// [윤정 1030] 테이블스페이스 리스트 조회 요청
	function tablespaceList() {
		$.ajax({
			url : 'getStorage',
			type : 'GET',
			dataType : "json",
			success : tablespaceListResult
		})
	}

	// [윤정 1030] 테이블스페이스 리스트 출력
	function tablespaceListResult(list) {
		$.each(list,
			function(idx, item) {
				var $radio = $("<td>").html(
							"<input type = 'radio' name = 'tablespaceName' value = '"
									+ (item.tablespaceName) + "'>");
				var $tablespaceName = $("<td>").html(
							"<a href = 'storageShow?tablespaceName="
									+ (item.tablespaceName) + "'>"
									+ (item.tablespaceName) + "</a>");
				var $status = $("<td>").text((item.status));
				var $total = $("<td align='right'>").text((item.total));
				var $used = $("<td align='right'>").text((item.used));
				var $free = $("<td align='right'>").text((item.free));

				$("tbody").append(
					$("<tr>")
						.append($radio).append($tablespaceName).append($status).append($total).append($used).append($free)
					);
					
				$('input:radio[name="tablespaceName"]').eq(0).attr("checked", true);
				// 첫 번째 라디오 자동 체크
			}
		);
	}

	// [윤정1031] tr 클릭시 라디오 체크 ---------- 안됨
	function radioCheck() {
		$("tbody tr").click(function() {
			console.log("클릭!");
			$(this).find("input:radio").attr("checked", true);
		});
	}
	
	// [윤정1105] 삭제시 테이블스페이스명 다시 입력
	function delCheck(){
		$("#delCheck").addClass("is-invalid").val("").focus();
		$("#delbtn").attr("disabled", true);
		
		$("#delCheck").keyup(function(){			
			var name = $("input[name='tablespaceName']:checked").val();
			var inputName = $("#delCheck").val();
			
			if(name == inputName) { // 이름을 똑바로 입력한 경우
				$("#delCheck").removeClass("is-invalid");
				$("#delCheck").addClass("is-valid");
				$("#delbtn").attr("disabled", false);
			} else { // 제대로 입력하지 않은 경우
				$("#delCheck").addClass("is-invalid");
				$("#delCheck").removeClass("is-valid");
				$("#delbtn").attr("disabled", true);
			}
		})
	}
	
	// [윤정1107] volumn 요청
	function getVolumn() {
		$.ajax({
			url : 'tablespaceList',
			type : 'GET',
			dataType : "json",
			success : volumn
		})
	}
	// [윤정1107] volumn 출력
	function volumn(list) {
		// ↓ 차트에 넣을 데이터들은 배열로 만들어야 한다.
		var names = new Array();
		var values = new Array();
		names[0] = "테이블스페이스 명";
		values[0] = "사용량 (GB)";
		$.each(list,
			function(idx, item) {
				names.push((item.tablespaceName));
				values.push((item.volumn));
			}
		);
		
		if(names.length == 1) {
			console.log("no tablespace!");
			names.push("");
			values.push(0);
		}
		
		console.log(names);
		console.log(values);
		
		google.charts.load('current', {packages: ['corechart', 'bar']});
		google.charts.setOnLoadCallback(drawStacked);

		function drawStacked() {
		      var data = google.visualization.arrayToDataTable([
		        names,
		        values,
		      ]);

		      var options = {
		        title: '종량제 사용량 (단위 GB)',
		        chartArea: {width: '95%'},
		        bar: { groupWidth: '70%' },
		        isStacked: true,
		        legend: { position: 'top' },
		        hAxis: { 
		          minValue: 0,
		          maxValue: "${member.payItem}".split("GB")[0]
		        }
		      };
		      var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
		      chart.draw(data, options);
		 }
		
	}
</script>
</head>
<body>
	<%@include file="/WEB-INF/jsp/DBbar.jsp"%>
	<div class="container">
		<div class = "row">
			<h3>이용중인 요금제 : <span id = "service">${member.getPayItem()}</span></h3>
		</div>
		
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<div id="chart_div"></div>
	
		<form id="frm" method="post">

			<div class="btn-group" role="group">
				<input id="updbtn" type="button" value="수정" class="btn btn-outline-info yj_btn">
				<input type="button" value="삭제" class="btn btn-outline-info yj_btn" onclick="delCheck()">
				<input id="crebtn" type="button" value="생성" class="btn btn-outline-info yj_btn">
				<input id="showbtn" type="button" value="조회" class="btn btn-outline-info yj_btn">
			</div>

			<br>
			<br>

			<div class="row">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th></th>
							<th>tablespace name</th>
							<th>status</th>
							<th>total MB</th>
							<th>used MB</th>
							<th>free MB</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>

		</form>


		<!-- [윤정1105] 삭제시 모달 등장 - 확인 -->
		<div class="modal fade" id="delModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">경고</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						테이블 스페이스에 있는 데이터가 모두 사라집니다. <br>
						삭제하려면 테이블스페이스 이름을 입력하세요.
						<br><br>
						<input type = "text" id = "delCheck" class = "form-control" placeholder="테이블스페이스 이름 입력">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-info" id = "delbtn">삭제하기</button>
					</div>
				</div>
			</div>
		</div>

		<!-- [윤정 1115] 테이블스페이스를 선택하지 않았을때 toast 출력 -->
		<div class='yj_error' style='display:none' id="tsError">테이블스페이스를 선택해주세요!</div>
	</div>
</body>
</html>