<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>mbtiList</title>
</head>

<script>

document.addEventListener('DOMContentLoaded', function() {
	
    const questions = document.querySelectorAll('.question-group');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');

    let currentQuestionIndex = 0;
    
    // ��� ���� �����
    questions.forEach(q => q.style.display = 'none');
    
    // ù ��° ���� �����ֱ�
    questions[currentQuestionIndex].style.display = 'block';

    
    nextBtn.addEventListener('click', function() {
        // ���� �������� ���õ� ���� ��ư�� �ִ��� Ȯ��
        const currentRadios = questions[currentQuestionIndex].querySelectorAll('input[type="radio"]');
        const isAnswered = Array.from(currentRadios).some(radio => radio.checked);
        
        // üũ�������� ���â ����
        if (!isAnswered) {
            alert("�׸��� ��� üũ���ּ���.");
            return;
        }

        // ���� ���� �����
        questions[currentQuestionIndex].style.display = 'none';
        
        // ���� ���� �ε����� �̵�
        currentQuestionIndex++;
        
        // ���� ������ �����ϸ� �����ֱ�
        if (currentQuestionIndex < questions.length) {
            questions[currentQuestionIndex].style.display = 'block';
        }

        // ������ ������ ��� [����] ����� [����] ���̱�
        if (currentQuestionIndex === questions.length - 1) {
            nextBtn.style.display = 'none';
            submitBtn.style.display = 'block';
        }
    });
});
 
</script>


<body>
<h3 align="center">MBTI ���� �˻�</h3>
<form action="/mbti/resultMBTI.do" method="post">
	<c:forEach var="m" items="${mbtiMap}">
		<div class="question-group">
			<c:forEach var="v" items="${m.value}">
					<h3>${v.boardComment}</h3>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="7" />�ſ� ����</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="6" />����</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="5" />�ణ ����</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="4" />�𸣰���</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="3" />�ణ ����</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="2" />����</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="1" />�ſ� ����</label>
			</c:forEach>
		</div>
	</c:forEach>
	<button type="button" id="nextBtn">����</button>

	<button type="submit" id="submitBtn" style="display: none;">�����ϱ�</button>
</form>
</body>
</html>