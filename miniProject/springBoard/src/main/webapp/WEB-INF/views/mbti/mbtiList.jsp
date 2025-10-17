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
    
    // 모든 질문 숨기기
    questions.forEach(q => q.style.display = 'none');
    
    // 첫 번째 질문 보여주기
    questions[currentQuestionIndex].style.display = 'block';

    
    nextBtn.addEventListener('click', function() {
        // 현재 질문에서 선택된 라디오 버튼이 있는지 확인
        const currentRadios = questions[currentQuestionIndex].querySelectorAll('input[type="radio"]');
        const isAnswered = Array.from(currentRadios).some(radio => radio.checked);
        
        // 체크안했으면 경고창 띄우기
        if (!isAnswered) {
            alert("항목을 모두 체크해주세요.");
            return;
        }

        // 현재 질문 숨기기
        questions[currentQuestionIndex].style.display = 'none';
        
        // 다음 질문 인덱스로 이동
        currentQuestionIndex++;
        
        // 다음 질문이 존재하면 보여주기
        if (currentQuestionIndex < questions.length) {
            questions[currentQuestionIndex].style.display = 'block';
        }

        // 마지막 질문일 경우 [다음] 숨기고 [제출] 보이기
        if (currentQuestionIndex === questions.length - 1) {
            nextBtn.style.display = 'none';
            submitBtn.style.display = 'block';
        }
    });
});
 
</script>


<body>
<h3 align="center">MBTI 유형 검사</h3>
<form action="/mbti/resultMBTI.do" method="post">
	<c:forEach var="m" items="${mbtiMap}">
		<div class="question-group">
			<c:forEach var="v" items="${m.value}">
					<h3>${v.boardComment}</h3>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="7" />매우 동의</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="6" />동의</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="5" />약간 동의</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="4" />모르겠음</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="3" />약간 비동의</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="2" />비동의</label>
					<label><input type="radio" name="${v.boardType}_${v.boardNum}" value="1" />매우 비동의</label>
			</c:forEach>
		</div>
	</c:forEach>
	<button type="button" id="nextBtn">다음</button>

	<button type="submit" id="submitBtn" style="display: none;">제출하기</button>
</form>
</body>
</html>