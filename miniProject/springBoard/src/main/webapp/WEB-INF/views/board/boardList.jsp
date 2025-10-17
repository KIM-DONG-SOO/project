<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>

<script type="text/javascript">
	window.addEventListener("pageshow", function(event) {
		if(event.persisted) {
			window.location.reload();
		}
	});
	
	//üũ�ڽ� ��� ���� (����) �����ϱ�
	function selectAll(selectAll) {
		
		const checkboxes = document.getElementsByName('boardType');
		
		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		});
	}
	
	// üũ �ڽ��� �ϳ��� Ȯ���ؼ� ��� üũ�� "��ü"�ڽ��� üũ �ǵ���.
	// �ϳ��� üũ�� �ƴ϶�� "��ü"�ڽ��� üũ�� �����ǵ��� ����.
	function checkingBoxes () {
		
		const allSelectingBox = document.getElementById('allSelectingBox');
		const checkboxes = document.querySelectorAll('.c_checkbox');
		
		let allCheckingFlag = true;
		
		for(let i=0 ; i < checkboxes.length ; i++) {
			if(!checkboxes[i].checked) {
				allCheckingFlag = false;
				break;
			}
		}
		allSelectingBox.checked = allCheckingFlag;
	}
	
	
	document.addEventListener("DOMContentLoaded", function() {
		// Ajax ������� ������ ����ϱ�
		document.getElementById("checkboxForm").addEventListener("submit", function(e) {
			
			e.preventDefault();
			
			const checkedBoxes = document.querySelectorAll(".c_checkbox:checked");
			
			let checkedValues = [];
			
			for(let i=0 ; i < checkedBoxes.length ; i++) {
				checkedValues.push(checkedBoxes[i].value);
			}
			
			fetch("/board/boardListAction.do", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(
					{
						boardType : checkedValues
					}
				)
			})
			.then(response => response.json())
			.then(data => {
				
				// �����
				console.log("�������� ������ ������", data);
				
				const totalCnt = document.getElementById("totalCnt");
				totalCnt.textContent = "total : " + data.totalCnt;
				
				
				const tbody = document.getElementById("boardTableBody");
				tbody.innerHTML = "";
	
				data.boardList.forEach(item => {
				    const tr = document.createElement("tr");
					
				    // ��ƽ ��� + ������ ���
				    tr.innerHTML = 
				        "<td>" + item.boardName + "</td>" +
				        "<td>" + item.boardNum + "</td>" +
				        "<td>" +
				            "<a href='/board/" + item.boardType + "/" + item.boardNum + "/boardView.do'>" +
				                item.boardTitle +
				            "</a>" +
				        "</td>";
				    
				    // �����
			        console.log("������ tr HTML:", tr.innerHTML);
			        
				    tbody.appendChild(tr);
				    
				});
			})
			.catch(err => console.error("AJAX ��� ����", err));
		})
	});
	
</script>

<body>
<table  align="center">
	<tr>
		<td align="left">
			<a href="/login/login.do">login</a>
			<a href="/join/joinForm.do">join</a>
		</td>
	</tr>

	<tr>
		<td id="totalCnt" align="right">
			total : ${totalCnt}
		</td>
	</tr>
	
	<tr>
		<td>
			<table id="boardTable" border = "1">
			
				<thead>
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				</thead>
				
				<tbody id="boardTableBody">
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.boardName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
				</tbody>
				
			</table>
		</td>
	</tr>
	
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">�۾���</a>
		</td>
	</tr>
</table>

	
<form id="checkboxForm">

	<label><input type="checkbox" name="boardType" id="allSelectingBox" onclick="selectAll(this)">��ü</label>
	
	<c:forEach items="${comCodeList}" var="comCodeVo">
		<label><input type="checkbox" class="c_checkbox" name="boardType" value="${comCodeVo.codeId}" onclick="checkingBoxes()">${comCodeVo.codeName}</label>
	</c:forEach>
	
	<button type="submit">��ȸ</button>
</form>
<!-- <form action="/board/boardList.do">
	<label><input type="checkbox" name="boardType" onclick="selectAll(this)">��ü</label>
	<label><input type="checkbox" name="boardType" value="a01">�Ϲ�</label>
	<label><input type="checkbox" name="boardType" value="a02">Q&amp;A</label>
	<label><input type="checkbox" name="boardType" value="a03">�͸�</label>
	<label><input type="checkbox" name="boardType" value="a04">����</label>
	<button type="submit">��ȸ</button>
</form> -->
</body>
</html>