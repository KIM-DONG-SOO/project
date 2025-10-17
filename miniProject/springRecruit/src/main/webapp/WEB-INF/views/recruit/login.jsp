<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
</head>

<script>

  	$j(document).ready(function(){

      $j("#login-btn").on("click",function(e){
        e.preventDefault();
        
        const nameVal = $j('#name').val().trim();
        const phoneVal = $j('#phone').val().trim();

        // 폼 제출시 빈값 방지
        if(!nameVal) {
          alert('이름을 입력해주세요.')
          $j('#name').focus();
          return;
        }
        if(!phoneVal) {
          alert('전화번호를 입력해주세요.')
          $j('#phone').focus();
          return;
        }
        if(phoneVal.length < 11) {
          alert('전화번호는 숫자 11자리를 입력해주세요.\n예) 01012345678 (-제외)');
          $j('#phone').focus();
          return;
        }
        
        // 로그인 입사지원 클릭시, Ajax 방식으로 서버와 통신하기
        var $frm = $j('.loginForm :input');
        var param = $frm.serialize();

        console.log("AJAX 요청 serialize 데이터::", param);
        
        $j.ajax({
            url : "/recruit/loginAction.do",
            dataType: "json",
            type: "POST",
            data : param,
            success: function(data)
            {
            alert("로그인완료");
            
            alert("메세지:"+data.success);
            
            location.href = "/recruit/main.do"
            },
            error: function ()
            {
              alert("실패");
            }
        });
      });


      // '이름' 항목은 한글만 입력 가능
      $j("#name").on('input', function() {

        const nameVal = $j('#name').val();

        // 한글이 아닌 문자는 ''처리
        const formattedVal = nameVal.replace(/[^\uAC00-\uD7A3\u3131-\u318E]/g, '');
        
        // 한글이 아닌 문자를 넣었을때 알림
        /* if (formattedVal.length < nameVal.length) {
            alert('이름은 한글만 입력 가능합니다.');
            $j('#name').focus();
        } */
        
     	// formattedVal을 입력값으로 설정
        $j('#name').val(formattedVal);
      })
	    

      // '전화번호' 항목은 숫자만 입력 가능
      $j("#phone").on('input', function() {

        const phoneVal = $j('#phone').val();

        // 숫자가 아닌 문자는 ''처리
        const formattedVal = phoneVal.replace(/[^0-9]/g, '');
        
        // 숫자가 아닌 문자를 넣었을때 알림
        /* if (formattedVal.length < phoneVal.length) {
            alert('전화번호는 숫자만 입력 가능합니다.');
            $j('#phone').focus();
        } */
        
        // formattedVal을 입력값으로 설정
        $j('#phone').val(formattedVal);
      })
	    

	});


  
</script>

<body>
  <form class="loginForm">
    <h2>로그인 페이지</h2>
    <table border="1" align="center">
      <tr>
        <td>
          이름
        </td>
        <td>
          <input type="text" id="name" name="name" maxlength="15">
        </td>
      </tr>
      <tr>
        <td>
          휴대폰번호
        </td>
        <td>
          <input type="text" id="phone" name="phone" maxlength="11">
        </td>
      </tr>
      <tr align="center">
        <td colspan="2">
          <button id="login-btn">
            입사지원
          </button>
        </td>
      </tr>
    </table>
  </form>
	
</body>

</html>