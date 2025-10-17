<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
</head>

<body>
<form id="login-form" action="/login/login.do">
	<table>
		<tr>
			<td>
				<h2>로그인 화면</h2>
					<table align="center" border='1'>
						<tr>
							<td>
								id
							</td>
							<td>
								<input type="text" id="user-id" name="userId">
							</td>
						</tr>
						<tr>
							<td>
								pw
							</td>
							<td>
								<input type="text" id="user-pw" name="userPw">
							</td>
						</tr>
					</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<button id="login-btn" type="submit">login</button>
			</td>
		</tr>
	</table>
</form>	
</body>

<script type="text/javascript">

	//로그인 AJAX 함수
	document.getElementById('login-form').addEventListener("submit", function(e) {
	
		e.preventDefault();
		//디버깅
		console.log("로그인 폼 제출 AJAX 요청 시작");
		
	  const userIdValue = document.getElementById('user-id').value;
	  const userPwValue = document.getElementById('user-pw').value;
	
	  
	  fetch("/login/loginAction.do", {
	    method: "POST",
	    headers: {
	      "Content-Type": "application/json"
	    },
	    body: JSON.stringify({
				"userId" : userIdValue,
				"userPw" : userPwValue
			})
	  })
	  .then(response => response.json())
	  .then(data => {
	
	// 디버깅
	console.log("서버에서 응답한 데이터", data);
	
		// 플래그가 success라면 로그인 성공, fail이면 실패 
	if(data.flag === "success") {
	  alert('로그인이 성공하였습니다.');
			location.href = '/board/boardList.do';
	}
	else {
			alert('로그인이 실패했습니다.');
	}
	
	  })
	  .catch(err => console.error("AJAX 통신 실패", err))
	});

</script>




</html>