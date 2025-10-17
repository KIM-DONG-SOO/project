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

        // �� ����� �� ����
        if(!nameVal) {
          alert('�̸��� �Է����ּ���.')
          $j('#name').focus();
          return;
        }
        if(!phoneVal) {
          alert('��ȭ��ȣ�� �Է����ּ���.')
          $j('#phone').focus();
          return;
        }
        if(phoneVal.length < 11) {
          alert('��ȭ��ȣ�� ���� 11�ڸ��� �Է����ּ���.\n��) 01012345678 (-����)');
          $j('#phone').focus();
          return;
        }
        
        // �α��� �Ի����� Ŭ����, Ajax ������� ������ ����ϱ�
        var $frm = $j('.loginForm :input');
        var param = $frm.serialize();

        console.log("AJAX ��û serialize ������::", param);
        
        $j.ajax({
            url : "/recruit/loginAction.do",
            dataType: "json",
            type: "POST",
            data : param,
            success: function(data)
            {
            alert("�α��οϷ�");
            
            alert("�޼���:"+data.success);
            
            location.href = "/recruit/main.do"
            },
            error: function ()
            {
              alert("����");
            }
        });
      });


      // '�̸�' �׸��� �ѱ۸� �Է� ����
      $j("#name").on('input', function() {

        const nameVal = $j('#name').val();

        // �ѱ��� �ƴ� ���ڴ� ''ó��
        const formattedVal = nameVal.replace(/[^\uAC00-\uD7A3\u3131-\u318E]/g, '');
        
        // �ѱ��� �ƴ� ���ڸ� �־����� �˸�
        /* if (formattedVal.length < nameVal.length) {
            alert('�̸��� �ѱ۸� �Է� �����մϴ�.');
            $j('#name').focus();
        } */
        
     	// formattedVal�� �Է°����� ����
        $j('#name').val(formattedVal);
      })
	    

      // '��ȭ��ȣ' �׸��� ���ڸ� �Է� ����
      $j("#phone").on('input', function() {

        const phoneVal = $j('#phone').val();

        // ���ڰ� �ƴ� ���ڴ� ''ó��
        const formattedVal = phoneVal.replace(/[^0-9]/g, '');
        
        // ���ڰ� �ƴ� ���ڸ� �־����� �˸�
        /* if (formattedVal.length < phoneVal.length) {
            alert('��ȭ��ȣ�� ���ڸ� �Է� �����մϴ�.');
            $j('#phone').focus();
        } */
        
        // formattedVal�� �Է°����� ����
        $j('#phone').val(formattedVal);
      })
	    

	});


  
</script>

<body>
  <form class="loginForm">
    <h2>�α��� ������</h2>
    <table border="1" align="center">
      <tr>
        <td>
          �̸�
        </td>
        <td>
          <input type="text" id="name" name="name" maxlength="15">
        </td>
      </tr>
      <tr>
        <td>
          �޴�����ȣ
        </td>
        <td>
          <input type="text" id="phone" name="phone" maxlength="11">
        </td>
      </tr>
      <tr align="center">
        <td colspan="2">
          <button id="login-btn">
            �Ի�����
          </button>
        </td>
      </tr>
    </table>
  </form>
	
</body>

</html>