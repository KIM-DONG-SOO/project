<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>join</title>
</head>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
	
	//�����
	console.log("DOM �ε� �Ϸ�");
	
	//�ߺ�Ȯ�� ���� 
	let checkFlag = false;
	//����ڰ� �ߺ�Ȯ�� ������ id�� �ٲ� �� �ֱ⶧���� userId1�� ���������� ����
	let checkId = '';
	
	
	//�ߺ�Ȯ�� AJAX �Լ�
	document.getElementById('id-btn').addEventListener("click", function(e) {
	
			const userId1 = document.getElementById('user-id').value.trim();
	
			//�����
			console.log("�ߺ�Ȯ�� ��ư Ŭ����");
		  
		  e.preventDefault();
		  
	       if (!userId1) {
	            alert("���̵� �Է��ϰ� �����ּ���.");
	            return;
	        }
		  
		  fetch("/join/joinIdCheckAction.do", {
		    method: "POST",
		    headers: {
		      "Content-Type": "application/json"
		    },
		    body: JSON.stringify(
		      {
		        userId : userId1
		      }
		    )
		  })
		  .then(response => response.json())
		  .then(data => {
	
		    // �����
		    console.log("�������� ������ ������", data);
	
		    const idErrMsg = document.getElementById('id-err-msg');
		    
		    if(data.flag === "Y") {
		      userId1='';
		      idErrMsg.innerHTML = '�̹� ������ ���̵� �ֽ��ϴ�.';
		      checkFlag = false;
		      document.getElementById('user-id').focus();
		    }
		    else {
		      idErrMsg.innerHTML = '��� ������ ���̵��Դϴ�.';
		      checkFlag = true;
		      //�ߺ�Ȯ���� id�� ���������� ����
		      checkId = userId1;

		      
		      document.getElementById('user-pw').focus();
		    }
	
		  })
		  .catch(err => console.error("AJAX ��� ����", err))
	});

		
		
	// ��й�ȣ �ڸ��� üũ�ϴ� �Լ�
	const userPw = document.getElementById('user-pw');
	
	userPw.addEventListener('keyup', function(e) {
	  
	  const userPwText = event.target.value;
	  const pwErrMsg = document.getElementById('pw-err-msg');
	
	  if(userPwText.length < 6 || userPwText.length > 12) {
	    pwErrMsg.innerHTML = 'error - ��й�ȣ�� 6~12�ڸ��� �����մϴ�.';
	  }
	  else {
	    pwErrMsg.innerHTML = '��밡���� ��й�ȣ �Դϴ�.';
	  }
	
	});
	
	
	// ��й�ȣ Ȯ�� �Լ�
	const userPwCheck = document.getElementById('user-pw-check');
	
	userPwCheck.addEventListener('keyup', function(e) {
		
		const userPwCheckText = e.target.value;
		const pwCheckErrMsg1 = document.getElementById('pw-check-err-msg1');
		const pwCheckErrMsg2 = document.getElementById('pw-check-err-msg2');
				

		if(userPwCheckText.length < 6 || userPwCheckText.length > 12) {
			pwCheckErrMsg1.innerHTML = 'error - ��й�ȣ�� 6~12�ڸ��� �����մϴ�.';
		 }
		else {
			if(userPw.value === userPwCheck.value) {
				pwCheckErrMsg2.innerHTML = '��й�ȣ Ȯ�� �Ϸ�.';
			}
			else {
				pwCheckErrMsg2.innerHTML = '��й�ȣ�� �ٸ��ϴ�.';
			}
		}
		

	})
	
	
	// ��ȭ��ȣ 4�ڸ� ���� �˸����� �Լ�
	const phone2 = document.getElementById('phone2');
    const phone3 = document.getElementById('phone3');

    phone2.addEventListener('keyup', (e) => checkPhone(e, 'phone2'));
    phone3.addEventListener('keyup', (e) => checkPhone(e, 'phone3'));
	
	
    // ��ȭ��ȣ ���� �Լ�
    function checkPhone(e, tagId) {
        console.log('checkPhone �Լ� ����');

        const phoneTag = document.getElementById(tagId);
        const phoneAlertMsg = document.getElementById('phone-alert-msg');

        let phoneText = e.target.value;
        console.log('�Էµ� phoneText::', phoneText);

        
        const numOnly = /\D/;
        if (phoneText !== "" && numOnly.test(phoneText)) {
            alert('��ȭ��ȣ�� ���ڸ� �Է� �����մϴ�.');
            phoneText = phoneText.replace(/[^0-9]/g, '');
            phoneTag.value = phoneText;
        }

        if (phoneText.length < 4) {
            phoneAlertMsg.innerHTML = '010-0000-0000 �������� �ۼ����ּ���.';
        } else {
            phoneAlertMsg.innerHTML = '';
            if (tagId === 'phone2' && phoneText.length === 4) {
                document.getElementById('phone3').focus();
            }
        }
    }


	
    const addr1 = document.getElementById('addr1');
    const addrAlertMsg = document.getElementById('addr-alert-msg');

    addr1.addEventListener('input', function(e) {
        let postNoText = e.target.value;
        console.log("�Է��� postNoText::", postNoText);

        // ���ڰ� �ƴ� ���ڰ� ������ alert + ����
        const numOnly = /\D/;
        if (postNoText !== "" && numOnly.test(postNoText)) {
            alert("�����ȣ�� ���ڸ� �Է� �����մϴ�.");
            postNoText = postNoText.replace(/[^0-9]/g, ''); // ���ڸ� �����
        }

        // 000-000 ���� ����
        let formattedText = postNoText;
        if (postNoText.length > 3) {
            formattedText = postNoText.slice(0,3) + '-' + postNoText.slice(3,6);
        }

        e.target.value = formattedText;

        // �ȳ� �޽���
        if (postNoText.length < 6) {
            addrAlertMsg.innerHTML = "�����ȣ�� '000-000' �������� �ۼ����ּ���.";
        } else {
            addrAlertMsg.innerHTML = "";
        }
    });

	
	
	//ȸ������ �� ���� AJAX �Լ�
	document.getElementById('join-form').addEventListener("submit", function(e) {
	
		e.preventDefault();
		
		// �ʼ� �� �����ϱ�
		const userId2 = document.getElementById('user-id').value.trim();
		const userPw = document.getElementById('user-pw').value.trim();
		const userPwCheck = document.getElementById('user-pw-check').value.trim();
		const userName = document.getElementById('user-name').value.trim();
		const phone2 = document.getElementById('phone2').value.trim();
		const phone3 = document.getElementById('phone3').value.trim();
		
		
		if(checkFlag==false || checkId != userId2) {
			alert('�ߺ�Ȯ���� ���ּ���.');
			document.getElementById('user-id').focus();
			return;
		}
		
		if(!userId2) {
			alert('���̵� �Է����ּ���.');
			document.getElementById('user-id').focus();
			return;
		}
		
		if(!userPw) {
			alert('��й�ȣ�� �Է����ּ���.');
			document.getElementById('user-pw').focus();
			return;
		}
		
		if(userPw != userPwCheck) {
			alert('��й�ȣ Ȯ���� ���ּ���.');
			document.getElementById('user-pw-check').focus();
			return;
		}
		
		if(!userName) {
			alert('������ ���ּ���.');
			document.getElementById('user-name').focus();
			return;
		}
		
		if(!phone2) {
			alert('��ȭ��ȣ�� �Է��ϼ���.');
			document.getElementById('phone2').focus();
			return;
		}
		
		if(phone2.length < 4) {
			alert('��ȭ��ȣ�� ���Ŀ� ���� �ʽ��ϴ�.');
			document.getElementById('phone2').focus();
			return;
		}
		
		if(!phone3) {
			alert('��ȭ��ȣ�� �Է����ּ���.');
			document.getElementById('phone3').focus();
			return;
		}
		
		if(phone3.length < 4) {
			alert('��ȭ��ȣ�� ���Ŀ� ���� �ʽ��ϴ�.');
			document.getElementById('phone3').focus();
			return;
		}
		

		
		
		
		
		//�����
		console.log("ȸ������ �� ���� AJAX ��û ����");
		
	  const joinForm = document.getElementById('join-form');
		const formData = new FormData(joinForm);
		
	  userData = {};

		formData.forEach((value, key) => {
			userData[key] = value;
		})
   	// �����
	console.log('json�������� ���� �� ������', userData)
	  
	  fetch("/join/joinAction.do", {
	    method: "POST",
	    headers: {
	      "Content-Type": "application/json"
	    },
	    body: JSON.stringify(userData)
	  })
	  .then(response => response.json())
	  .then(data => {

    // �����
    console.log("�������� ������ ������", data);

	// �÷��װ� success��� ȸ������ ����, fail�̸� ���� 
    if(data.flag === "success") {
      alert('ȸ�������� �����Ͽ����ϴ�.');
	  location.href = '/board/boardList.do';
    }
    else {
		alert('ȸ�������� �����߽��ϴ�.');
    }

	  })
	  .catch(err => console.error("AJAX ��� ����", err))
	});
	
	
	
	/* ========== �ǵ�� �������� �߰��� js�Լ� ========== */

	
	// id�� ����� ���ڸ� �Էµ� �� �ֵ��� �����ϱ�
	const userIdTag = document.getElementById('user-id');
	
	userIdTag.addEventListener('input', function(e) {
	    // �������� �ʱ�ȭ
	    checkFlag = false;
	    checkId = '';
	
	    const userIdText = e.target;
	    const currentText = userIdText.value;
	
	    const EngNum = /^[A-Za-z0-9]+$/;  
	
	    if(currentText !== "" && !EngNum.test(currentText)) {
	        alert('id�� ���� �Ǵ� ���ڸ� �Է� �����մϴ�.');
	    }
	
	    // �߸��� ���� ����
	    userIdText.value = userIdText.value.replace(/[^A-Za-z0-9]/g, '');
	});

	
	
	// name�� '�ѱ�'�� �Էµ� �� �ֵ��� �����ϱ�
	const userNameTag = document.getElementById('user-name');

	userNameTag.addEventListener('input', function(e) {

		const userNameText = e.target;
	    const currentText = userNameText.value;
		
	    const korOnly = /[\uAC00-\uD7A3\u3131-\u318E]/g;
	
	    if(currentText !== "" && !korOnly.test(currentText)) {
	        alert('�̸��� �ѱ۸� �Է� �����մϴ�.');
	    }

		// �ѱ� �����ڵ� ������ ����
		userNameText.value = userNameText.value.replace(/[^\uAC00-\uD7A3\u3131-\u318E]/g, '');

	})
	
	
	
	
	
});
</script>


<body>
<form id="join-form">
	<table align="center">
		<tr>
			<td align="left">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						id*
						</td>
						<td width="400">
						<input id="user-id" name="userId" type="text" size="50" value="${user.userId}"
							maxlength="15">
						<button id="id-btn" type="button">
							�ߺ�Ȯ��
						</button> 
            			<p id="id-err-msg"></p>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						pw*
						</td>
						<td width="400">
			              <input id="user-pw" name="userPw" type="password" size="50" value="${user.userPw}" 
			              	maxlength="16"> 
			              <p id="pw-err-msg"></p>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
							pw check*
						</td>
						<td width="400">
							<input id="user-pw-check" type="password" size="50" 
								maxlength="16"> 
							<p id="pw-check-err-msg1"></p>
							<p id="pw-check-err-msg2"></p>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						name*
						</td>
						<td width="400">
						<input id="user-name" name="userName" type="text" size="50" value="${user.userName}"
							maxlength="4"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						phone*
						</td>
						<td width="400">
						<select name="userPhone1" >
							<c:forEach items="${comCodeVOList}" var="comCodeVO">
								<option value="${comCodeVO.codeId}">${comCodeVO.codeName}</option>
							</c:forEach>
						</select>
						-
						<input id="phone2" name="userPhone2" type="text" value="${user.userPhone2}"
							maxlength="4" >
						-
						<input id="phone3" name="userPhone3" type="text" value="${user.userPhone3}" 
							maxlength="4" >
						<p id="phone-alert-msg"></p>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						postNo
						</td>
						<td width="400">
						<input id="addr1" name="userAddr1" type="text" size="50" value="${user.userAddr1}"
							maxlength="8" > 
						<p id="addr-alert-msg">�����ȣ�� '000-000'�������� �ۼ����ּ���.</p>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						address
						</td>
						<td width="400">
						<input id="addr2" name="userAddr2" type="text" size="50" value="${user.userAddr2}"
							maxlength="150"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						company
						</td>
						<td width="400">
						<input name="userCompany" type="text" size="50" value="${user.userCompany}" 
							maxlength="60"> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<button id="join-btn" type="submit">join</button>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>