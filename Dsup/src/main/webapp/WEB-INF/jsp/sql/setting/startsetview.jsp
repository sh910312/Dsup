<%@  taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%	String schemaid = (String)session.getAttribute("schemaid");
	System.out.println("-------------->" + schemaid);
	if(schemaid != null){
		schemaid = schemaid.toUpperCase();
	}
	if(schemaid==null || schemaid.equals("")){%>      
		<script>
			$(function(){
			    var tag =  '<i class="fas fa-power-off fa-4x"></i>';
			    $('#login-success-breath').html(tag);
			})

		</script>
<% }else{%>
	<script>
		$(function(){
			var tag =  '<i class="fas fa-power-off fa-2x ripple" style="color : #fd5581;"></i><i class="fas fa-power-off fa-2x ripple"></i>';
		    $('#login-success-breath').append(tag);
		    $('#connected-schema-nm').text("<%=schemaid%>");
		})
	</script>
<%}%>
<script>
function connection(){
	var request = new XMLHttpRequest();
	var schemaNmae = $("#schema-Name-select option:selected").val();
	var schemaPassword = $("#schema-psw-input").val();
	
 	request.open("GET", "Connection?id=" + encodeURI(schemaNmae) + "&pwd=" + schemaPassword);

	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
			result = request.responseText;
			console.log("Result : " + result);
			if(result == null || result==""){
			    var tag =  '<i class="fas fa-power-off fa-4x"></i>';
			    $('#login-success-breath').html(tag);
			    $('#schema-psw-input').val("");
			}else{
			    var tag =  '<i class="fas fa-power-off fa-2x ripple" style="color : #fd5581;"></i><i class="fas fa-power-off fa-2x ripple"></i>';
			    $('#connected-schema-nm').text(result.toUpperCase());
			    $('#login-success-breath').append(tag);
			}
		}else{
			var tag =  '<i class="fas fa-power-off fa-4x"></i>';
		    $('#login-success-breath').html(tag);
		}
	};

	request.send(null);
}

function disconnection(){
	var request = new XMLHttpRequest();
	
 	request.open("GET", "Disconnection");

	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
			var tag =  '<i class="fas fa-power-off fa-4x"></i>';
		    $('#login-success-breath').html(tag);
		    $('#connected-schema-nm').text("START");
		    //원래대로 로그인 창을 바꾸는 부분
		    $('#schema-Name-select option:eq(0)').prop("selected", true);
		    $('#schema-psw-input').val("");
		    console.log("Schema Disconnection");
		}
	};
	request.send(null);
}
</script>
<jsp:include page="start_include.jsp"></jsp:include>
<div class="limiter">
	<div class="container-login100" style="padding: 0px 5px 0px 5px;">
		<form class="login100-form validate-form">
			<span class="login100-form-avatar"> 
				<span id="login-success-breath" class="intro-banner-vdo-play-btn" 
	 				 style="top:30%;background-size: 100%; top: 30%; background-repeat: repeat;  background-position: center; align-content: center;">
 	 				<i class="fas fa-power-off fa-4x"></i>
	 			<!-- 	<i class="fas fa-power-off fa-2x ripple"></i> -->
				<!-- 	<img src="./resources/js/sql/etc/images/avatar-01.jpg" class="ripple pinkBg"> 
					<img src="./resources/js/sql/etc/images/avatar-01.jpg" class="ripple pinkBg">
					<img src="./resources/js/sql/etc/images/avatar-01.jpg" class="ripple pinkBg"> -->
 				</span>
			</span>
			<span id="connected-schema-nm"class="login100-form-title p-b-10"> START </span>
			<div class="wrap-input100 validate-input m-t-30 m-b-35" data-validate="Enter username">
				<select id="schema-Name-select" class="input100" type="text" name="username" style="color: #999999; border: none;">
					<option value="" disabled="" selected="" hidden="">Schema Name</option>
					<c:forEach var="list" items="${schemaList }">
						<option style="color: #999999;">${list }</option>	
					</c:forEach>
				</select>
			</div>
			<div class="wrap-input100 validate-input m-b-50" data-validate="Enter password">
				<input id="schema-psw-input" class="input100" type="password" name="pass"> 
			</div>
			<div class="container-login100-form-btn p-b-20">
				<button id="sch-login-btn" type = "button" class="login100-form-btn" onclick="connection()">Connect</button>
			</div>
			<div class="container-login100-form-btn">
				<button id="sch-login-btn2" type = "button" class="login100-form-btn" onclick="disconnection()">DisConnect</button>
			</div>
		</form>
	</div>
</div>
