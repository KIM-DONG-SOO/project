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
	
	//디버깅
	console.log("DOM 로드 완료");
	
	//중복확인 여부 
	let checkFlag = false;
	//사용자가 중복확인 누르고 id를 바꿀 수 있기때문에 userId1를 전역변수로 관리
	let checkId = '';
	
	
	//중복확인 AJAX 함수
	document.getElementById('id-btn').addEventListener("click", function(e) {
	
			const userId1 = document.getElementById('user-id').value.trim();
	
			//디버깅
			console.log("중복확인 버튼 클릭됨");
		  
		  e.preventDefault();
		  
	       if (!userId1) {
	            alert("아이디를 입력하고 눌러주세요.");
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
	
		    // 디버깅
		    console.log("서버에서 응답한 데이터", data);
	
		    const idErrMsg = document.getElementById('id-err-msg');
		    
		    if(data.flag === "Y") {
		      userId1='';
		      idErrMsg.innerHTML = '이미 동일한 아이디가 있습니다.';
		      checkFlag = false;
		      document.getElementById('user-id').focus();
		    }
		    else {
		      idErrMsg.innerHTML = '사용 가능한 아이디입니다.';
		      checkFlag = true;
		      //중복확인한 id를 전역변수로 저장
		      checkId = userId1;

		      
		      document.getElementById('user-pw').focus();
		    }
	
		  })
		  .catch(err => console.error("AJAX 통신 실패", err))
	});

		
		
	// 비밀번호 자리수 체크하는 함수
	const userPw = document.getElementById('user-pw');
	
	userPw.addEventListener('keyup', function(e) {
	  
	  const userPwText = event.target.value;
	  const pwErrMsg = document.getElementById('pw-err-msg');
	
	  if(userPwText.length < 6 || userPwText.length > 12) {
	    pwErrMsg.innerHTML = 'error - 비밀번호는 6~12자리만 가능합니다.';
	  }
	  else {
	    pwErrMsg.innerHTML = '사용가능한 비밀번호 입니다.';
	  }
	
	});
	
	
	// 비밀번호 확인 함수
	const userPwCheck = document.getElementById('user-pw-check');
	
	userPwCheck.addEventListener('keyup', function(e) {
		
		const userPwCheckText = e.target.value;
		const pwCheckErrMsg1 = document.getElementById('pw-check-err-msg1');
		const pwCheckErrMsg2 = document.getElementById('pw-check-err-msg2');
				

		if(userPwCheckText.length < 6 || userPwCheckText.length > 12) {
			pwCheckErrMsg1.innerHTML = 'error - 비밀번호는 6~12자리만 가능합니다.';
		 }
		else {
			if(userPw.value === userPwCheck.value) {
				pwCheckErrMsg2.innerHTML = '비밀번호 확인 완료.';
			}
			else {
				pwCheckErrMsg2.innerHTML = '비밀번호가 다릅니다.';
			}
		}
		

	})
	
	
	// 전화번호 4자리 형식 알림문구 함수
	const phone2 = document.getElementById('phone2');
    const phone3 = document.getElementById('phone3');

    phone2.addEventListener('keyup', (e) => checkPhone(e, 'phone2'));
    phone3.addEventListener('keyup', (e) => checkPhone(e, 'phone3'));
	
	
    // 전화번호 검증 함수
    function checkPhone(e, tagId) {
        console.log('checkPhone 함수 실행');

        const phoneTag = document.getElementById(tagId);
        const phoneAlertMsg = document.getElementById('phone-alert-msg');

        let phoneText = e.target.value;
        console.log('입력된 phoneText::', phoneText);

        
        const numOnly = /\D/;
        if (phoneText !== "" && numOnly.test(phoneText)) {
            alert('전화번호는 숫자만 입력 가능합니다.');
            phoneText = phoneText.replace(/[^0-9]/g, '');
            phoneTag.value = phoneText;
        }

        if (phoneText.length < 4) {
            phoneAlertMsg.innerHTML = '010-0000-0000 형식으로 작성해주세요.';
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
        console.log("입력한 postNoText::", postNoText);

        // 숫자가 아닌 문자가 들어오면 alert + 제거
        const numOnly = /\D/;
        if (postNoText !== "" && numOnly.test(postNoText)) {
            alert("우편번호는 숫자만 입력 가능합니다.");
            postNoText = postNoText.replace(/[^0-9]/g, ''); // 숫자만 남기기
        }

        // 000-000 형식 적용
        let formattedText = postNoText;
        if (postNoText.length > 3) {
            formattedText = postNoText.slice(0,3) + '-' + postNoText.slice(3,6);
        }

        e.target.value = formattedText;

        // 안내 메시지
        if (postNoText.length < 6) {
            addrAlertMsg.innerHTML = "우편번호는 '000-000' 형식으로 작성해주세요.";
        } else {
            addrAlertMsg.innerHTML = "";
        }
    });

	
	
	//회원가입 폼 제출 AJAX 함수
	document.getElementById('join-form').addEventListener("submit", function(e) {
	
		e.preventDefault();
		
		// 필수 값 검증하기
		const userId2 = document.getElementById('user-id').value.trim();
		const userPw = document.getElementById('user-pw').value.trim();
		const userPwCheck = document.getElementById('user-pw-check').value.trim();
		const userName = document.getElementById('user-name').value.trim();
		const phone2 = document.getElementById('phone2').value.trim();
		const phone3 = document.getElementById('phone3').value.trim();
		
		
		if(checkFlag==false || checkId != userId2) {
			alert('중복확인을 해주세요.');
			document.getElementById('user-id').focus();
			return;
		}
		
		if(!userId2) {
			alert('아이디를 입력해주세요.');
			document.getElementById('user-id').focus();
			return;
		}
		
		if(!userPw) {
			alert('비밀번호를 입력해주세요.');
			document.getElementById('user-pw').focus();
			return;
		}
		
		if(userPw != userPwCheck) {
			alert('비밀번호 확인을 해주세요.');
			document.getElementById('user-pw-check').focus();
			return;
		}
		
		if(!userName) {
			alert('성함을 해주세요.');
			document.getElementById('user-name').focus();
			return;
		}
		
		if(!phone2) {
			alert('전화번호를 입력하세요.');
			document.getElementById('phone2').focus();
			return;
		}
		
		if(phone2.length < 4) {
			alert('전화번호가 형식에 맞지 않습니다.');
			document.getElementById('phone2').focus();
			return;
		}
		
		if(!phone3) {
			alert('전화번호를 입력해주세요.');
			document.getElementById('phone3').focus();
			return;
		}
		
		if(phone3.length < 4) {
			alert('전화번호가 형식에 맞지 않습니다.');
			document.getElementById('phone3').focus();
			return;
		}
		

		
		
		
		
		//디버깅
		console.log("회원가입 폼 제출 AJAX 요청 시작");
		
	  const joinForm = document.getElementById('join-form');
		const formData = new FormData(joinForm);
		
	  userData = {};

		formData.forEach((value, key) => {
			userData[key] = value;
		})
   	// 디버깅
	console.log('json형식으로 만든 폼 데이터', userData)
	  
	  fetch("/join/joinAction.do", {
	    method: "POST",
	    headers: {
	      "Content-Type": "application/json"
	    },
	    body: JSON.stringify(userData)
	  })
	  .then(response => response.json())
	  .then(data => {

    // 디버깅
    console.log("서버에서 응답한 데이터", data);

	// 플래그가 success라면 회원가입 성공, fail이면 실패 
    if(data.flag === "success") {
      alert('회원가입이 성공하였습니다.');
	  location.href = '/board/boardList.do';
    }
    else {
		alert('회원가입이 실패했습니다.');
    }

	  })
	  .catch(err => console.error("AJAX 통신 실패", err))
	});
	
	
	
	/* ========== 피드백 바탕으로 추가한 js함수 ========== */

	
	// id는 영어와 숫자만 입력될 수 있도록 구현하기
	const userIdTag = document.getElementById('user-id');
	
	userIdTag.addEventListener('input', function(e) {
	    // 변역변수 초기화
	    checkFlag = false;
	    checkId = '';
	
	    const userIdText = e.target;
	    const currentText = userIdText.value;
	
	    const EngNum = /^[A-Za-z0-9]+$/;  
	
	    if(currentText !== "" && !EngNum.test(currentText)) {
	        alert('id는 영문 또는 숫자만 입력 가능합니다.');
	    }
	
	    // 잘못된 문자 제거
	    userIdText.value = userIdText.value.replace(/[^A-Za-z0-9]/g, '');
	});

	
	
	// name은 '한글'만 입력될 수 있도록 구현하기
	const userNameTag = document.getElementById('user-name');

	userNameTag.addEventListener('input', function(e) {

		const userNameText = e.target;
	    const currentText = userNameText.value;
		
	    const korOnly = /[\uAC00-\uD7A3\u3131-\u318E]/g;
	
	    if(currentText !== "" && !korOnly.test(currentText)) {
	        alert('이름은 한글만 입력 가능합니다.');
	    }

		// 한글 유니코드 범위로 변경
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
							중복확인
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
						<p id="addr-alert-msg">우편번호는 '000-000'형식으로 작성해주세요.</p>
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