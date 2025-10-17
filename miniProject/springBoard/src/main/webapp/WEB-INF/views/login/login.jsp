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
				<h2>�α��� ȭ��</h2>
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

	//�α��� AJAX �Լ�
	document.getElementById('login-form').addEventListener("submit", function(e) {
	
		e.preventDefault();
		//�����
		console.log("�α��� �� ���� AJAX ��û ����");
		
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
	
	// �����
	console.log("�������� ������ ������", data);
	
		// �÷��װ� success��� �α��� ����, fail�̸� ���� 
	if(data.flag === "success") {
	  alert('�α����� �����Ͽ����ϴ�.');
			location.href = '/board/boardList.do';
	}
	else {
			alert('�α����� �����߽��ϴ�.');
	}
	
	  })
	  .catch(err => console.error("AJAX ��� ����", err))
	});

</script>




</html>