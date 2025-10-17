<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>main</title>
</head>

<script>

  	$j(document).ready(function(){


      /*****  함수  *****/

       // index 재설정하는 함수
      function makeNewIndex(tableId) {

        //테이블셀렉터+tr로 요소들을 가져와서 .each로 반복
        $j(tableId + " tr").each(function(rowIndex) {

          //<th>는 건너뛰기
          if(rowIndex === 0) {
            return;
          }

          const newIndex = rowIndex - 1;

          // tr안에 있는 input,select 요소들을 찾기위해 each로 중첩반복.
          $j(this).find("input, select").each(function() {
            let name = $j(this).attr("name");
            let id = $j(this).attr("id");

            //기존 인덱스를 재설정.
            if(name) {
              name = name.replace(/\[\d+\]/, "[" + newIndex + "]");
              $j(this).attr("name", name);
            }
            if(id) {
              id = id.replace(/\d+$/, newIndex);
              $j(this).attr("id", id);
            }

          })
        });
      };
      
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
       

        
        // YYYY-MM 공통 검증 함수
        function validYM(idString) {
        		
        		let thisVal = $j(idString).val();
           		let today = new Date();
           		
           		let year = today.getFullYear();
           		
           		inputYear = thisVal.slice(0, 4);
           		inputMonth = thisVal.slice(5, 7);
           		/* inputDate = thisVal.slice(-2); */
           		
           		if(inputYear < 1950 || inputYear > year) {
           			alert("Year 날짜 형식에 맞지 않습니다.");
           			$j(idString).val("");
           			$j(idString).focus();
           			return;
           		}
           		if(inputMonth < 1 || inputMonth > 12) {
           			alert("Month 날짜 형식에 맞지 않습니다.");
           			$j(idString).val("");
           			$j(idString).focus();
           			return;
           		}
           		/* if(inputDate < 1 || inputDate > 31) {
           			alert("Date 날짜 형식에 맞지 않습니다.");
           			$j(idString).val("");
           			$j(idString).focus();
           			return;
           		} */
        }
        
        // 생년월알 유효성 검사 함수. (윤년, YYYY-MM-DD형식, 오늘날짜보다 빠르면 안됨, )
        function birthValid(birthVal) {
		  // 입력이 없으면 통과시키지 않음
		  if (!birthVal) {
			  alert('생년월일을 입력해주세요.');
			  return false;
		  }
		
		  // YYYY-MM-DD 형식 체크
		  if (!/^\d{4}-\d{2}-\d{2}$/.test(birthVal)) {
			  alert("날짜 형식이 'YYYY-MM-DD'에 맞지 않습니다.");
			  return false;
		  }
		
		  const [year, month, day] = birthVal.split('-').map(Number);

		  // 윤년 검사 -> Date 객체로 검증
		  const date = new Date(year, month - 1, day);
		  if (
		    date.getFullYear() !== year ||
		    date.getMonth() + 1 !== month ||
		    date.getDate() !== day
		  ) {
		    alert("존재하지 않는 날짜입니다.");
		    return false;
		  }

		  // 생년월일은 오늘보다 빠른 날짜여야함.
		  const today = new Date();
		  const inputDate = new Date(year, month - 1, day);
		  if (inputDate > today) {
		    alert("생년월일은 오늘보다 빠른 날짜여야 합니다.");
		    return false;
		  }
		
		  return true;
		}
        
        // YYYY-DD 유료성 검사 함수
        function periodValid(inputVal) {
        	
       	 if(inputVal.length < 7 || !/^\d{4}-\d{2}$/.test(inputVal)) {
        	  alert("YYYY-MM 형식에 맞지 않습니다.")
              return false;
       	 }
  		  const [year, month] = inputVal.split('-').map(Number);
  		  const date = new Date(year, month - 1);
		  if (
		    date.getFullYear() !== year ||
		    date.getMonth() + 1 !== month
		  ) {
		    alert("존재하지 않는 날짜입니다.");
		    return false;
		  }
		  return true;
        }
        
        
        function removeEmptyRows() {
            
            // 경력 테이블의 빈 행 삭제
            $j("#car-table tr").each(function(index) {
                if(index === 0 || index === 1) return; // 헤더와 첫행은 제외
                
                const carStartPeriod = $j(this).find("input[id^='car-startPeriod']").val().trim();
                const carEndPeriod = $j(this).find("input[id^='car-endPeriod']").val().trim();
                const compName = $j(this).find("input[id^='compName']").val().trim();
                const task = $j(this).find("input[id^='task']").val().trim();
                const carLocation = $j(this).find("select[id^='car-location']").val();
                
                // 모든 필드가 비어있으면 해당 행 삭제
                if(!carStartPeriod && !carEndPeriod && !compName && !task) {
                    $j(this).remove();
                }
            });
            
            // 자격증 테이블의 빈 행 삭제
            $j("#cert-table tr").each(function(index) {
                if(index === 0 || index === 1) return; // 헤더와 첫행은 제외
                
                const qualifiName = $j(this).find("input[id^='qualifiName']").val().trim();
                const acquDate = $j(this).find("input[id^='acquDate']").val().trim();
                const organizeName = $j(this).find("input[id^='organizeName']").val().trim();
                
                // 모든 필드가 비어있으면 해당 행 삭제
                if(!qualifiName && !acquDate && !organizeName) {
                    $j(this).remove();
                }
            });
            
            // 삭제 후 인덱스 재정렬
            makeNewIndex("#car-table");
            makeNewIndex("#cert-table");
        }

        
        
        // 공통 Ajax 처리 함수
        function saveOrSubmit(actionUrl, successMsg) {
          var $frm = $j('.recruitForm :input');
          var param = $frm.serialize();

          $j.ajax({
            url: actionUrl,
            dataType: "json",
            type: "POST",
            data: param,
            success: function(data) {
              if (data.status === "success") {
                alert(successMsg);

                // recruitVO
                const recruit = data.recruitVO;
                $j("#seq").val(recruit.seq);
                $j("#submit").val(recruit.submit);
                $j("#name").val(recruit.name);
                $j("#birth").val(recruit.birth);
                $j("#phone").val(recruit.phone);
                $j("#email").val(recruit.email);
                $j("#addr").val(recruit.addr);
                $j("#location").val(recruit.location);
                $j("#workType").val(recruit.workType);

                // eduList
                $j.each(data.eduList, function(i, edu) {
                  $j("#eduSeq" + i).val(edu.eduSeq);
                  $j("#edu-Seq" + i).val(edu.seq);
                  $j("#startPeriod" + i).val(edu.startPeriod);
                  $j("#endPeriod" + i).val(edu.endPeriod);
                  $j("#division" + i).val(edu.division);
                  $j("#schoolName" + i).val(edu.schoolName);
                  $j("#edu-location" + i).val(edu.location);
                  $j("#major" + i).val(edu.major);
                  $j("#grade" + i).val(edu.grade);
                });

                // carList
                $j.each(data.carList, function(i, car) {
                  $j("#carSeq" + i).val(car.carSeq);
                  $j("#car-Seq" + i).val(car.seq);
                  $j("#car-startPeriod" + i).val(car.startPeriod);
                  $j("#car-endPeriod" + i).val(car.endPeriod);
                  $j("#compName" + i).val(car.compName);
                  $j("#task" + i).val(car.task);
                  $j("#car-location" + i).val(car.location);
                });

                // certList
                $j.each(data.certList, function(i, cert) {
                  $j("#certSeq" + i).val(cert.certSeq);
                  $j("#cert-Seq" + i).val(cert.seq);
                  $j("#qualifiName" + i).val(cert.qualifiName);
                  $j("#acquDate" + i).val(cert.acquDate);
                  $j("#organizeName" + i).val(cert.organizeName);
                });

              } else {
                alert("저장 실패: " + data.status);
              }
            },
            error: function() {
              alert("오류 발생");
            }
          });
        }
        
        
     	// 저장 버튼 클릭시
        $j("#save-btn").on("click", function(e) {
          e.preventDefault();
          
          //만약 사용자가 '추가'버튼을 눌러 빈 행을 열어놓고 저장하면 경력 년월수 계산시 에러.
          //저장되기 직전에 해당 tr을 삭제처리
          
          //만든 함수 사용
          removeEmptyRows();

          
       	  // 필수값 체크
          const nameVal = $j('#name').val().trim();
          const birthVal = $j('#birth').val().trim();
          const phoneVal = $j('#phone').val().trim();
          const emailVal = $j('#email').val().trim();
          const addrVal = $j('#addr').val().trim();
          
          if(!nameVal) {
            alert('이름을 입력해주세요.');
            $j('#name').focus();
            return;
          }
          if(!birthVal) {
            alert('생년월일을 입력해주세요.');
            $j('#birth').focus();
            return;
          }
          if(!phoneVal) {
            alert('전화번호를 입력해주세요.');
            $j('#phone').focus();
            return;
          }
          if(!emailVal) {
            alert('이메일을 입력해주세요.');
            $j('#email').focus();
            return;
          }
          if(!addrVal) {
            alert('주소를 입력해주세요.');
            $j('#addr').focus();
            return;
          }
       	  // 생년월일 유효성 검사 함수 사용
          if (!birthValid(birthVal)) {
        	  $j('#birth').focus();
        	  return;
          }
       	  // 이메일 유효성 검사
          let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
          if (!emailPattern.test(emailVal)) {
        	  alert("적합하지 않은 이메일 형식입니다.\n아이디@도메인주소 형식으로 입력해주세요.\n예) recruit123@gmail.com");
        	  $j("#email").focus();
        	  return;
          }
          
       	  // Education(학력) 유효성 검사
          let eduValid = true;
          $j("#edu-table tr").each(function(index) {
            if(index === 0) return; // 헤더 건너뛰기
            
            const startPeriod = $j(this).find("input[id^='startPeriod']").val().trim();
            const endPeriod = $j(this).find("input[id^='endPeriod']").val().trim();
            const schoolName = $j(this).find("input[id^='schoolName']").val().trim();
            const major = $j(this).find("input[id^='major']").val().trim();
            const grade = $j(this).find("input[id^='grade']").val().trim();
            
            // 빈값 먼저 검사하기
            const fields = [
				  { val: startPeriod, selector: "input[id^='startPeriod']", msg: "재학 시작 기간을 입력해주세요." },
				  { val: endPeriod, selector: "input[id^='endPeriod']", msg: "재학 종료 기간을 입력해주세요." },
				  { val: schoolName, selector: "input[id^='schoolName']", msg: "학교명을 입력해주세요." },
				  { val: major, selector: "input[id^='major']", msg: "전공을 입력해주세요." },
				  { val: grade, selector: "input[id^='grade']", msg: "학점을 입력해주세요." }
			];
			for (let field of fields) {
			    if (!field.val) {
			        alert(field.msg);
			        $j(this).find(field.selector).focus();
			        eduValid = false;
			        return false;
			    }
			}
            
			// periodValid 함수사용
            if(!periodValid(startPeriod)) {
              $j(this).find("input[id^='startPeriod']").focus();
              eduValid = false;
              return false;
            }
            if(!periodValid(endPeriod)) {
              $j(this).find("input[id^='endPeriod']").focus();
              eduValid = false;
              return false;
            }
            
         	// 재학기간 시작과 생일 비교 
            if(startPeriod <= birthVal) {
            	alert("재학기간의 시작일이 생년월일보다 빠릅니다.")
            	$j(this).find("input[id^='startPeriod']").focus();
            	eduValid = false;
                return false;
            }
         	// 재학기간 시작과 종료 비교
            if(startPeriod >= endPeriod) {
            	alert("재학기간의 종료일이 시작일보다 빠릅니다.")
            	$j(this).find("input[id^='endPeriod']").focus();
            	eduValid = false;
                return false;
            }
            //학교명 : 한글만 허용
            if(!/^[\uAC00-\uD7A3\u3131-\u318E]+$/.test(schoolName)) {
                alert("학교명은 한글만 입력가능합니다.");
                $j(this).find("input[id^='schoolName']").focus();
                eduValid = false;
                return false;
            }
            //학교명 : OOO고등학교, OOO전문대학교, OOO대학교
            if(!/(고등학교|전문대학교|대학교)$/.test(schoolName)) {
			    alert("학교명은 '고등학교', '전문대학교', '대학교'로 끝나야 합니다.");
			    $j(this).find("input[id^='schoolName']").focus();
			    eduValid = false;
			    return false;
			}
            //학과 : 한글만 입력가능
            if(!/^[\uAC00-\uD7A3\u3131-\u318E]+$/.test(major)) {
            	alert("전공은 한글만 입력 가능합니다.");
            	$j(this).find("input[id^='major']").focus();
			    eduValid = false;
			    return false;
            }
			//학과 : OOO학과
            if(!/학과$/.test(major)) {
			    alert("전공은 '학과'로 끝나야 합니다.");
			    $j(this).find("input[id^='major']").focus();
			    eduValid = false;
			    return false;
			}
            //학점 : 숫자만 허용, 3글자, 3.3 형태
			if(!/^[0-9]\.[0-9]$/.test(grade)) {
				alert("학점이 형식과 다릅니다.\n형식] 4.5\n 숫자만 입력 가능합니다.")
				$j(this).find("input[id^='grade']").focus();
			    eduValid = false;
			    return false;
			}
            
			

            
            
          });
          
          
       	  // Career(경력) 유효성 검사
       	  let carValid = true;
          $j("#car-table tr").each(function(index) {
        	  if(index === 0) return; // 헤더 건너뛰기
              
              const carStartPeriod = $j(this).find("input[id^='car-startPeriod']").val().trim();
              const carEndPeriod = $j(this).find("input[id^='car-endPeriod']").val().trim();
              const compName = $j(this).find("input[id^='compName']").val().trim();
              const task = $j(this).find("input[id^='task']").val().trim();
              const carLocation = $j(this).find("input[id^='car-location']").val();
              
              // 만약에 입력값이 하나라도 있다면, 빈값 먼저 검사하기
              if(carStartPeriod || carEndPeriod || compName || task || carLocation) {
            	  
	              const fields = [
	  				  { val: carStartPeriod, selector: "input[id^='car-startPeriod']", msg: "경력 시작 기간을 입력해주세요." },
	  				  { val: carEndPeriod, selector: "input[id^='car-endPeriod']", msg: "경력 종료 기간을 입력해주세요." },
	  				  { val: compName, selector: "input[id^='compName']", msg: "회사명을 입력해주세요." },
	  				  { val: task, selector: "input[id^='task']", msg: "부서/직급/직책을 입력해주세요." },
  					];
					for (let field of fields) {
					    if (!field.val) {
					        alert(field.msg);
					        $j(this).find(field.selector).focus();
					        carValid = false;
					        return false;
					    }
					}
					// periodValid 함수를 이용
		            if(!periodValid(carStartPeriod)) {
		              $j(this).find("input[id^='car-startPeriod']").focus();
		              carValid = false;
		              return false;
		            }
		            if(!periodValid(carEndPeriod)) {
		              $j(this).find("input[id^='car-endPeriod']").focus();
		              carValid = false;
		              return false;
		            }
		          // 경력기간 시작과 교육기간 종료 비교
		          let eduEndPeriod=new Date("1900-01-01");
		          $j("#edu-table tr").each(function(index) {
		        	  if(index===0) return;
			          const iEndPeriod = $j(this).find("input[id^='endPeriod']").val().trim();
			          iEndDate = new Date(iEndPeriod);
			          eduEndDate = new Date(eduEndPeriod);
			          if(iEndDate > eduEndDate) {
			        	  eduEndPeriod = iEndDate;
			          }
		          });
		          const eduEndYear = eduEndPeriod.getFullYear();
		          const eduEndMonth = String(eduEndPeriod.getMonth() + 1).padStart(2, '0');
		          eduEndPeriod = eduEndYear + '-' + eduEndMonth;
	              if(carStartPeriod <= eduEndPeriod) {
	              	alert("경력기간의 시작일이 재학기간 종료일보다 빠릅니다.");
	              	$j(this).find("input[id^='car-startPeriod']").focus();
	              	carValid = false;
	                return false;
	              }
	           	  // 경력기간 시작과 종료 비교
	              if(carStartPeriod >= carEndPeriod) {
	              	alert("경력기간의 종료일이 시작일보다 빠릅니다.");
	              	$j(this).find("input[id^='car-endPeriod']").focus();
	              	carValid = false;
	                return false;
	              }
	           	  // 부서/직급/직책
	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+\/[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+\/[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(task)) {
					alert("부서/직급/직책이 형식에 맞지 않습니다.\n형식) SI사업부/주니어/사원\n특수문자는 /만 사용가능");
					$j(this).find("input[id^='task']").focus();
					carValid = false;
					return false;
	           	  }
              }
          });
  			
  	
       	  // Certificate(자격증) 유효성 검사
       	  let certValid = true;
          $j("#cert-table tr").each(function(index) {
        	  if(index === 0) return; // 헤더 건너뛰기
              
              const qualifiName = $j(this).find("input[id^='qualifiName']").val().trim();
              const acquDate = $j(this).find("input[id^='acquDate']").val().trim();
              const organizeName = $j(this).find("input[id^='organizeName']").val().trim();
              
              // 만약에 입력값이 하나라도 있다면, 빈값 먼저 검사하기
              if(qualifiName || acquDate || organizeName) {
            	  
	              const fields = [
	  				  { val: qualifiName, selector: "input[id^='qualifiName']", msg: "자격증명을 입력해주세요." },
	  				  { val: acquDate, selector: "input[id^='acquDate']", msg: "자격증 취득일을 입력해주세요." },
	  				  { val: organizeName, selector: "input[id^='organizeName']", msg: "자격증 발행처를 입력해주세요." },
  					];
					for (let field of fields) {
					    if (!field.val) {
					        alert(field.msg);
					        $j(this).find(field.selector).focus();
					        certValid = false;
					        return false;
					    }
					}
					
	           	  // 자격증명 특수문자 불가
	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(qualifiName)) {
					alert("자격증명에 특수문자는 입력할 수 없습니다.");
					$j(this).find("input[id^='qualifiName']").focus();
					certValid = false;
					return false;
	           	  }
	          		 // periodValid 함수를 이용
		            if(!periodValid(acquDate)) {
		              $j(this).find("input[id^='acquDate']").focus();
		              certValid = false;
		              return false;
		            }
	           	  // 발행처 특수문자 불가
	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(organizeName)) {
					alert("자격증 발행처에 특수문자는 입력할 수 없습니다.");
					$j(this).find("input[id^='organizeName']").focus();
					certValid = false;
					return false;
	           	  }
              }
          });
          
  	
          // 만약 유효성 검사 실패하면 여기서 멈춤. 저장X
          if(!eduValid) return;
          if(!carValid) return;
          if(!certValid) return;
          
          saveOrSubmit("/recruit/saveAction.do", "저장이 완료되었습니다.");
        });


        // 제출 버튼 클릭시
        $j("#submit-btn").on("click", function(e) {
          e.preventDefault();
          
          removeEmptyRows();

          const submitVal = $j("#submit").val();

          if (submitVal === "N") {
        	  
        	  // 필수값 체크
              const nameVal = $j('#name').val().trim();
              const birthVal = $j('#birth').val().trim();
              const phoneVal = $j('#phone').val().trim();
              const emailVal = $j('#email').val().trim();
              const addrVal = $j('#addr').val().trim();
              
              if(!nameVal) {
                alert('이름을 입력해주세요.');
                $j('#name').focus();
                return;
              }
              
              // 생년월일 유효성 검사 함수사용
              if (!birthValid(birthVal)) {
            	  $j('#birth').focus();
            	  return;
              }
              
              if(!phoneVal) {
                alert('전화번호를 입력해주세요.');
                $j('#phone').focus();
                return;
              }
              if(!emailVal) {
                alert('이메일을 입력해주세요.');
                $j('#email').focus();
                return;
              }
              // 이메일 유효성 검사
              let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
              if (!emailPattern.test(emailVal)) {
            	  alert("적합하지 않은 이메일 형식입니다.\n아이디@도메인주소 형식으로 입력해주세요.\n예) recruit123@gmail.com");
            	  $j(this).focus();
            	  return;
              }
              
              if(!addrVal) {
                alert('주소를 입력해주세요.');
                $j('#addr').focus();
                return;
              }
              
           	  // 학력 유효성 검사
              let eduValid = true;
              $j("#edu-table tr").each(function(index) {
                if(index === 0) return; // 헤더 건너뛰기
                
                const startPeriod = $j(this).find("input[id^='startPeriod']").val().trim();
                if(!periodValid(startPeriod)) {
                  $j(this).find("input[id^='startPeriod']").focus();
                  eduValid = false;
                  return false;
                }
                const endPeriod = $j(this).find("input[id^='endPeriod']").val().trim();
                if(!periodValid(endPeriod)) {
                  $j(this).find("input[id^='endPeriod']").focus();
                  eduValid = false;
                  return false;
                }
                // 재학기간 시작과 종료 비교
                if(startPeriod >= endPeriod) {
                	alert("재학기간의 종료일이 시작일보다 빠릅니다.")
                	eduValid = false;
                    return false;
                }
                //학교명 : 한글이나 영어 문자만 허용
                const schoolName = $j(this).find("input[id^='schoolName']").val().trim();
                if(!/^[\uAC00-\uD7A3\u3131-\u318E]+$/.test(schoolName)) {
                    alert("학교명은 한글만 입력가능합니다.");
                    $j(this).find("input[id^='schoolName']").focus();
                    eduValid = false;
                    return false;
                }
              	//학교명 : OOO고등학교, OOO전문대학교, OOO대학교
                if(!/(고등학교|전문대학교|대학교)$/.test(schoolName)) {
    			    alert("학교명은 '고등학교', '전문대학교', '대학교'로 끝나야 합니다.");
    			    $j(this).find("input[id^='schoolName']").focus();
    			    eduValid = false;
    			    return false;
    			}
                //학과 : 전공은 한글만 허용
                const major = $j(this).find("input[id^='major']").val().trim();
                if(!/^[\uAC00-\uD7A3\u3131-\u318E]+$/.test(major)) {
                	alert("전공은 한글만 입력 가능합니다.");
                	$j(this).find("input[id^='major']").focus();
    			    eduValid = false;
    			    return false;
                }
              	//학과 : OOO학과
                if(!/학과$/.test(major)) {
    			    alert("전공은 '학과'로 끝나야 합니다.");
    			    $j(this).find("input[id^='major']").focus();
    			    eduValid = false;
    			    return false;
    			}
              	//학점 : 숫자만 허용, 3글자, 3.3 형태
	            const grade = $j(this).find("input[id^='grade']").val().trim();
				if(!/^[0-9]\.[0-9]$/.test(grade)) {
					alert("학점이 형식과 다릅니다.\n형식] 4.5\n 숫자만 입력 가능합니다.")
					$j(this).find("input[id^='grade']").focus();
				    eduValid = false;
				    return false;
				}
                
                if(!startPeriod || !endPeriod || !schoolName || !major || !grade) {
                  alert('학력 정보를 모두 입력해주세요.');
                  eduValid = false;
                  return false;
                }
              });
              
              
           	  // Career(경력) 유효성 검사
           	  let carValid = true;
              $j("#car-table tr").each(function(index) {
            	  if(index === 0) return; // 헤더 건너뛰기
                  
                  const carStartPeriod = $j(this).find("input[id^='car-startPeriod']").val().trim();
                  const carEndPeriod = $j(this).find("input[id^='car-endPeriod']").val().trim();
                  const compName = $j(this).find("input[id^='compName']").val().trim();
                  const task = $j(this).find("input[id^='task']").val().trim();
                  const carLocation = $j(this).find("input[id^='car-location']").val();
                  
                  // 만약에 입력값이 하나라도 있다면, 빈값 먼저 검사하기
                  if(carStartPeriod || carEndPeriod || compName || task || carLocation) {
                	  
    	              const fields = [
    	  				  { val: carStartPeriod, selector: "input[id^='car-startPeriod']", msg: "경력 시작 기간을 입력해주세요." },
    	  				  { val: carEndPeriod, selector: "input[id^='car-endPeriod']", msg: "경력 종료 기간을 입력해주세요." },
    	  				  { val: compName, selector: "input[id^='compName']", msg: "회사명을 입력해주세요." },
    	  				  { val: task, selector: "input[id^='task']", msg: "부서/직급/직책을 입력해주세요." },
      					];
    					for (let field of fields) {
    					    if (!field.val) {
    					        alert(field.msg);
    					        $j(this).find(field.selector).focus();
    					        carValid = false;
    					        return false;
    					    }
    					}
    					// periodValid 함수를 이용
    		            if(!periodValid(carStartPeriod)) {
    		              $j(this).find("input[id^='car-startPeriod']").focus();
    		              carValid = false;
    		              return false;
    		            }
    		            if(!periodValid(carEndPeriod)) {
    		              $j(this).find("input[id^='car-endPeriod']").focus();
    		              carValid = false;
    		              return false;
    		            }
    		          // 경력기간 시작과 교육기간 종료 비교
   			          let eduEndPeriod=new Date("1900-01-01");
   			          $j("#edu-table tr").each(function(index) {
   			        	  if(index===0) return;
   				          const iEndPeriod = $j(this).find("input[id^='endPeriod']").val().trim();
   				          iEndDate = new Date(iEndPeriod);
   				          eduEndDate = new Date(eduEndPeriod);
   				          if(iEndDate > eduEndDate) {
   				        	  eduEndPeriod = iEndDate;
   				          }
   			          });
   			          const eduEndYear = eduEndPeriod.getFullYear();
   			          const eduEndMonth = String(eduEndPeriod.getMonth() + 1).padStart(2, '0');
   			          eduEndPeriod = eduEndYear + '-' + eduEndMonth;
   		              if(carStartPeriod <= eduEndPeriod) {
   		              	alert("경력기간의 시작일이 재학기간 종료일보다 빠릅니다.");
   		              	$j(this).find("input[id^='car-startPeriod']").focus();
   		              	carValid = false;
   		                return false;
   		              }
	               	  // 경력기간 시작과 종료 비교
	                  if(carStartPeriod >= carEndPeriod) {
	                  	alert("경력기간의 종료일이 시작일보다 빠릅니다.");
	                  	$j(this).find("input[id^='car-endPeriod']").focus();
	                  	carValid = false;
	                    return false;
	                  }
	               	  // 부서/직급/직책
	               	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+\/[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+\/[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(task)) {
	    				alert("부서/직급/직책이 형식에 맞지 않습니다.\n형식) SI사업부/주니어/사원\n특수문자는 /만 사용가능");
	    				$j(this).find("input[id^='task']").focus();
	    				carValid = false;
	    				return false;
	               	  }
                  }
              });
              
           // Certificate(자격증) 유효성 검사
           	  let certValid = true;
              $j("#cert-table tr").each(function(index) {
            	  if(index === 0) return; // 헤더 건너뛰기
                  
                  const qualifiName = $j(this).find("input[id^='qualifiName']").val().trim();
                  const acquDate = $j(this).find("input[id^='acquDate']").val().trim();
                  const organizeName = $j(this).find("input[id^='organizeName']").val().trim();
                  
                  // 만약에 입력값이 하나라도 있다면, 빈값 먼저 검사하기
                  if(qualifiName || acquDate || organizeName) {
                	  
    	              const fields = [
    	  				  { val: qualifiName, selector: "input[id^='qualifiName']", msg: "자격증명을 입력해주세요." },
    	  				  { val: acquDate, selector: "input[id^='acquDate']", msg: "자격증 취득일을 입력해주세요." },
    	  				  { val: organizeName, selector: "input[id^='organizeName']", msg: "자격증 발행처를 입력해주세요." },
      					];
    					for (let field of fields) {
    					    if (!field.val) {
    					        alert(field.msg);
    					        $j(this).find(field.selector).focus();
    					        certValid = false;
    					        return false;
    					    }
    					}
    					
    	           	  // 자격증명 특수문자 불가
    	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(qualifiName)) {
    					alert("자격증명에 특수문자는 입력할 수 없습니다.");
    					$j(this).find("input[id^='qualifiName']").focus();
    					certValid = false;
    					return false;
    	           	  }
    	           // periodValid 함수를 이용
    		            if(!periodValid(acquDate)) {
    		              $j(this).find("input[id^='acquDate']").focus();
    		              certValid = false;
    		              return false;
    		            }
    	           	  // 발행처 특수문자 불가
    	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(organizeName)) {
    					alert("자격증 발행처에 특수문자는 입력할 수 없습니다.");
    					$j(this).find("input[id^='organizeName']").focus();
    					certValid = false;
    					return false;
    	           	  }
                  }
              });
      	
      	
      	
      	
      	
              // 만약 유효성 검사 실패하면 여기서 멈춤. 저장X
              if(!eduValid) return;
              if(!carValid) return;
              if(!certValid) return;
        	  
            saveOrSubmit("/recruit/submitAction.do", "제출이 완료되었습니다.\n제출 후에는 수정할 수 없습니다.");
            
            // 제출 후 수정할 수 없게 전부 disabled 처리하기
            const allForm = $j("#recruitForm").find('input, select, button');
            allForm.each(function(){
            	this.disabled = true;
            });
            
            
          } else if (submitVal === "Y") {
            alert("이미 제출이 완료되었습니다. (수정불가)");
          } else {
            alert("저장을 먼저 진행해주세요.");
          }
        });
  	
  	
  	
  	
  	
      
      
      // "추가"버튼 누르면 '학력' 양식추가
      $j('#edu-add-btn').on('click', function(e) {
        e.preventDefault();
        
        console.log("학력 추가 버튼 클릭됨");

        // 현재 tr개수로 인덱스 숫자를 먼저 판단하고 삽입.
        const newIndex = $j("#edu-table tr").length - 1;

        console.log("추가된 index",newIndex);

        const newRow =
          '<tr>' +
            '<td><input type="checkbox" ><input type="hidden" id="eduSeq' + newIndex + '" name="eduList[' + newIndex + '].eduSeq"><input type="hidden" id="edu-Seq' + newIndex + '" name="eduList[' + newIndex + '].seq" ></td>' +
            '<td><input type="text" name="eduList[' + newIndex + '].startPeriod" id="startPeriod' + newIndex + '"> <br>' +
            ' ~ <br>' +
            '<input type="text" name="eduList[' + newIndex + '].endPeriod" id="endPeriod' + newIndex + '"></td>' +
            '<td>' +
              '<select name="eduList[' + newIndex + '].division" id="division' + newIndex + '">' +
                '<option value="졸업">졸업</option>' +
                '<option value="재학">재학</option>' +
                '<option value="중퇴">중퇴</option>' +
              '</select>' +
            '</td>' +
            '<td><input type="text" name="eduList[' + newIndex + '].schoolName" id="schoolName' + newIndex + '"> <br>' +
              '<select name="eduList[' + newIndex + '].location" id="edu-location' + newIndex + '">' +
                '<c:forEach var="loc" items="${locList}">' +
                  '<option value="${loc.codeName}" ${eduVO.location == loc.codeName ? 'selected' : ''}>${loc.codeName}</option>' +
                '</c:forEach>' +
              '</select></td>' +
            '<td><input type="text" name="eduList[' + newIndex + '].major" id="major' + newIndex + '"></td>' +
            '<td><input type="text" name="eduList[' + newIndex + '].grade" id="grade' + newIndex + '" maxlength="3"></td>' +
          '</tr>';

        $j('#edu-table').append(newRow);
        makeNewIndex("#edu-table");

      });

      // 삭제 버튼 클릭시, 체크된 박스만 삭제
      $j("#edu-del-btn").on("click", function(e) {
        e.preventDefault();
        
        // 체크된 tr갯수
        let checkedTr = $j('#edu-table').find('input[type="checkbox"]:checked').length;
        // 현재 tr갯수 (-1은 th빼기 위함.)
        let nowTr = $j('#edu-table').find('tr').length - 1;
        
        if(checkedTr >= nowTr) {
        	alert("적어도 1개의 항목은 남겨두어야합니다.");
        	return;
        }
        else {
        	
        // 체크박스 하나씩 찾아서 체크된것만 remove
        $j('#edu-table').find('input[type="checkbox"]:checked').each(function() {
            $j(this).closest('tr').remove();
          });

          // 삭제 후 인덱스 재정렬,  삭제는 함수를 만들어 사용.
          makeNewIndex("#edu-table");
        }
      });

      
      
   	  // "추가"버튼 누르면 '경력' 양식추가
      $j('#car-add-btn').on('click', function(e) {
        e.preventDefault();
        
        console.log("경력 추가 버튼 클릭됨");
        

        const newIndex = $j("#car-table tr").length - 1;

        const newRow = 
          '<tr>' +
            '<td><input type="checkbox" ><input type="hidden" id="carSeq' + newIndex + '" name="carList[' + newIndex + '].carSeq"><input type="hidden" id="car-Seq' + newIndex + '" name="carList[' + newIndex + '].seq"></td>' +
            '<td><input type="text" name="carList[' + newIndex + '].startPeriod" id="car-startPeriod' + newIndex + '"> <br>' +
            ' ~ <br>' +
            '<input type="text" name="carList[' + newIndex + '].endPeriod" id="car-endPeriod' + newIndex + '"></td>' +
            '<td><input type="text" name="carList[' + newIndex + '].compName" id="compName' + newIndex + '"></td>' +
            '<td><input type="text" name="carList[' + newIndex + '].task" id="task' + newIndex + '"></td>' +
            '<td><select name="carList[' + newIndex + '].location" id="car-location' + newIndex + '">' +
            '<c:forEach var="loc" items="${locList}">' +
                '<option value="${loc.codeName}" ${carVO.location == loc.codeName ? 'selected' : ''}>' +
                    '${loc.codeName}' +
                '</option>' +
            '</c:forEach>' +
        '</select></td>' + 
          '</tr>';


        $j('#car-table').append(newRow);
        makeNewIndex("#car-table");
      });
      
      
   	  // 삭제 버튼 클릭시, 체크된 박스만 삭제
      $j("#car-del-btn").on("click", function(e) {
        e.preventDefault();
        
        let checkedTr = $j('#car-table').find('input[type="checkbox"]:checked').length;
        let nowTr = $j('#car-table').find('tr').length - 1;
        
        if(checkedTr >= nowTr) {
        	alert("적어도 1개의 항목은 남겨두어야합니다.");
        	return;
        }
        else {
        	
        // 체크박스 하나씩 찾아서 체크된것만 remove
        $j('#car-table').find('input[type="checkbox"]:checked').each(function() {
            $j(this).closest('tr').remove();
          });

          // 삭제 후 인덱스 재정렬,  삭제는 함수를 만들어 사용.
          makeNewIndex("#car-table");
        }
      });
   	  
   	  
   	  // "추가"버튼 누르면 '자격증' 양식추가
      $j('#cert-add-btn').on('click', function(e) {
        e.preventDefault();
        
        console.log("자격증 추가 버튼 클릭됨");
        

        const newIndex = $j("#cert-table tr").length - 1;

        const newRow = 
        '<tr>' +
          '<td><input type="checkbox"><input type="hidden" id="certSeq' + newIndex + '" name="certList[' + newIndex + '].certSeq"><input type="hidden" id="cert-Seq' + newIndex + '" name="certList[' + newIndex + '].seq"></td>' +
          '<td><input type="text" name="certList[' + newIndex + '].qualifiName" id="qualifiName' + newIndex + '"></td>' +
          '<td><input type="text" name="certList[' + newIndex + '].acquDate" id="acquDate' + newIndex + '"></td>' +
          '<td><input type="text" name="certList[' + newIndex + '].organizeName" id="organizeName' + newIndex + '"></td>' +
        '</tr>';


        $j('#cert-table').append(newRow);
        makeNewIndex("#cert-table");
      });
      
      
   	  // 삭제 버튼 클릭시, 체크된 박스만 삭제
      $j("#cert-del-btn").on("click", function(e) {
        e.preventDefault();
        
        let checkedTr = $j('#cert-table').find('input[type="checkbox"]:checked').length;
        let nowTr = $j('#cert-table').find('tr').length - 1;
        
        if(checkedTr >= nowTr) {
        	alert("적어도 1개의 항목은 남겨두어야합니다.");
        	return;
        }
        else {
        	
        // 체크박스 하나씩 찾아서 체크된것만 remove
        $j('#cert-table').find('input[type="checkbox"]:checked').each(function() {
            $j(this).closest('tr').remove();
          });

          // 삭제 후 인덱스 재정렬,  삭제는 함수를 만들어 사용.
          makeNewIndex("#cert-table");
        }
      });
      
      /*=============================================================================*/
      
      // YYYY-MM-DD 자동 포맷
      let previousValue = "";
      
      $j("#birth").on("input", function() {
		    let birthVal = $j(this).val();
		    birthVal = birthVal.replace(/[^0-9]/g, '');
		
		    // 바로 위 코드에서 숫자만 남겨두었으므로, YYYYMMDD 최대 8자리까지임
		    if (birthVal.length > 8) {
		        birthVal = birthVal.slice(0, 8);
		    }
		
		    // 삭제 중인지 확인 (이전 값보다 짧으면 삭제 중)
		    let isDeleting = birthVal.length < previousValue.replace(/[^0-9]/g, '').length;
		
		    // 4자리: YYYY-
		    if (birthVal.length === 4 && !isDeleting) {
		        birthVal = birthVal + "-";
		    }
		    // 5~6자리: YYYY-MM 또는 YYYY-MM-
		    else if (birthVal.length > 4 && birthVal.length <= 6) {
		        birthVal = birthVal.slice(0, 4) + "-" + birthVal.slice(4);
		        if (birthVal.length === 7 && !isDeleting) {
		            birthVal = birthVal + "-";
		        }
		    }
		    // 7~8자리: YYYY-MM-DD
		    else if (birthVal.length > 6) {
		        birthVal = birthVal.slice(0, 4) + "-" + birthVal.slice(4, 6) + "-" + birthVal.slice(6);
		    }
		
		    previousValue = birthVal;
		    $j(this).val(birthVal);
		});
      
   	  
   	  // 이메일 형식 입력 체크 (영어+특수문자만 가능)
      $j("#email").on("input", function() {
    	  
    	  let emailVal = $j(this).val();
          let emailPattern = /[^a-zA-Z0-9._\-@]/;
          
          if(emailVal !== '' && emailPattern.test(emailVal)) {
        	  $j(this).val("");
        	  /* alert("이메일은 영문, 숫자, .,_,-,@ 만 입력가능합니다.") */
          }

    	  
      });
   	  

      // 재학기간 시작일, 종료일 자동 포멧
      $j("#edu-table").on("input", "input[id^='startPeriod'], input[id^='endPeriod']", function() {
          let inputVal = $j(this).val();
      	  // 이 input의 이전 값 (data 속성에 저장)
          let prevVal = $j(this).data('prevVal') || '';
          inputVal = inputVal.replace(/[^0-9]/g, '');
          
          // 삭제 중인지 확인
          let isDeleting = inputVal.length < prevVal.replace(/[^0-9]/g, '').length;
          
          if (inputVal.length === 4 && !isDeleting) {
              inputVal = inputVal.slice(0, 4) + '-';
          }
          else if(inputVal.length > 4) {
        	  inputVal = inputVal.slice(0, 4) + '-' + inputVal.slice(4, 6);
          }
          
          $j(this).data('prevVal', inputVal);
          $j(this).val(inputVal);
          
      });
      
      // 경력기간 시작일, 종료일 자동 포멧
      let carPrevVal = "";
      
      $j("#car-table").on("input", "input[id^='car-startPeriod'], input[id^='car-endPeriod']", function() {
          let inputVal = $j(this).val();
       	  // 이 input의 이전 값 (data 속성에 저장)
          let prevVal = $j(this).data('prevVal') || '';
          inputVal = inputVal.replace(/[^0-9]/g, '');
          
          // 삭제 중인지 확인
          let isDeleting = inputVal.length < prevVal.replace(/[^0-9]/g, '').length;
          
          if (inputVal.length === 4 && !isDeleting) {
              inputVal = inputVal.slice(0, 4) + '-';
          }
          else if(inputVal.length > 4) {
        	  inputVal = inputVal.slice(0, 4) + '-' + inputVal.slice(4, 6);
          }
          
          $j(this).data('prevVal', inputVal);
          $j(this).val(inputVal);
          
      });
      
      
      // 자격증 취득일 자동 포멧
      let certPrevVal = "";
      
      $j("#cert-table").on("input", "input[id^='acquDate']", function() {
          let inputVal = $j(this).val();
          inputVal = inputVal.replace(/[^0-9]/g, '');
          
          // 삭제 중인지 확인
          let isDeleting = inputVal.length < certPrevVal.replace(/[^0-9]/g, '').length;
          
          
          if (inputVal.length === 4 && !isDeleting) {
              inputVal = inputVal.slice(0, 4) + '-';
          }
          else if(inputVal.length === 4 && isDeleting) {
        	  inputVal = inputVal.slice(0, 4);
          }
          else if(inputVal.length > 4) {
        	  inputVal = inputVal.slice(0, 4) + '-' + inputVal.slice(4, 6);
          }
          
          certPrevVal = inputVal;
          $j(this).val(inputVal);
          
      });
      
      
      
      
      /*==========================================================================*/
      
      
      // sum-table에 들어갈 학력사항.
      // schoolName 마지막 글자로 '고등학교', '전문대학교', '대학교' 분류
      // endPeriod - startPeriod = 대학교()안에 기간 표시
      // division으로 '졸업', '재학', '중퇴' 
      
      let schoolType = "";
      let schoolPeriod = "";
      let schoolDivision = "";
      
      // 제일 최근 학력 인덱스
      let latestIndex = -1;
      // 임시변수
      let tempdiff = Infinity;
      let latestElement = null;
      
      // 현재날짜를 기준으로 제일 최근 학력사항을 가져오기
      $j("[id^='endPeriod']").each(function(index){
    	  const recentEduDate = $j(this).val()
    	  let recentDate = new Date(recentEduDate + "-01");
    	  
    	  // 현재 날짜를 YYYY-MM-01 형식으로 통일시킴
    	  let currentDate = new Date();
    	  currentDate.setDate(1);
    	  
    	  //현재날짜와 교육종료일의 차이
    	  diff = currentDate - recentDate;
    	  console.log(diff);
    	  
    	  if (diff >= 0 && diff < tempdiff) { 
   	        tempdiff = diff;
   	        // 해당 인덱스 (제일 차이가 작은 날짜=최근날짜)
   	        latestIndex = index;
   	        // 해당 DOM요소 변수에 담기
   	     	latestElement = $j(this);
    	  }
      });
      
      
      // 학교타입 추출
      if(latestElement) {
	      const recentSchoolName = latestElement.closest("tr").find("input[id^='schoolName']").val();
	      console.log("recentSchoolName::",recentSchoolName);
    	  
	   	  if(recentSchoolName.endsWith("고등학교")) {
	    	  schoolType = "고등학교";
	   	  }
	   	  else if(recentSchoolName.endsWith("전문대학교")) {
	    	  schoolType = "전문대학교";
	   	  }
	   	  else if(recentSchoolName.endsWith("대학교")) {
	    	  schoolType = "대학교";
	   	  }
      }
      
      sPeriod = "";
      ePeriod = "";
      
      $j("[id^='startPeriod']").each(function(){
    	  thisPeriod = $j(this).val();
    	  if(thisPeriod > sPeriod) {
    		  sPeriod = thisPeriod;
    	  }
      });
      $j("[id^='endPeriod']").each(function(){
    	  thisPeriod = $j(this).val();
    	  if(thisPeriod > ePeriod) {
    		  ePeriod = thisPeriod;
    	  }
      });
      let sDate = new Date(sPeriod);
      let eDate = new Date(ePeriod);
      let startYear = sDate.getFullYear();
      let endYear = eDate.getFullYear();
      let startMonth = sDate.getMonth()+1;
      let endMonth = eDate.getMonth()+1;
      
      let diffYear = endYear - startYear;
      let diffMonth = endMonth - startMonth;

      // 월이 음수이면 연도에서 1을 빼고, 월에 12를 더하기
      if (diffMonth < 0) {
          diffYear--;
          diffMonth += 12;
      }
      
      let periodText = "";

      if (diffYear > 0) {
          periodText += diffYear + "년 ";
      }
      else if (diffYear > 4) {
    	  periodText = "4년";
      }
      
      
      if (diffMonth > 0) {
          periodText += diffMonth + "개월";
      }

      if (periodText === "") {
          periodText = "0개월"; 
      }
      
      //만약 4년 이상이면 그냥 "4년"
      if (diffYear > 4) {
    	  periodText = "4년";
      }

      schoolPeriod = periodText.trim();
      
      
      $j("[id^='division']").each(function() {
    	  thisDivi = $j(this).val();
    	  if(schoolType === "고등학교") {
    		  schoolDivision = thisDivi;
    		  return false;
    	  }
    	  else if(schoolType === "전문대학교") {
    		  schoolDivision = thisDivi;
    		  return false;
    	  }
    	  else if(schoolType === "대학교") {
    		  schoolDivision = thisDivi;
    		  return false;
    	  }
      });
      
      // sum-table 학력사항 조립하기
      const sumEdu = schoolType + "(" + schoolPeriod + ")" + schoolDivision;
      // value값으로 집어넣기
      $j("#sum-edu").text(sumEdu);

   	  
   	  
      // sum-table 경력사항 만들기
      let careerPeriod;
      
      carStartPeriod = "9999-12-31";
      carEndPeriod = "";
      
      $j("[id^='car-startPeriod']").each(function(){
    	  thisPeriod = $j(this).val();
	      console.log("thisPeriod::",thisPeriod);
    	  if(thisPeriod < carStartPeriod) {
    		  carStartPeriod = thisPeriod;
    	  }
      });
      console.log("경력제일첫날carStartPeriod::",carStartPeriod);
      $j("[id^='car-endPeriod']").each(function(){
    	  thisPeriod = $j(this).val();
    	  if(thisPeriod > carEndPeriod) {
    		  carEndPeriod = thisPeriod;
    	  }
      });
      console.log("경력제일마지막날carEndPeriod::",carEndPeriod);
      
      if(carStartPeriod !== "9999-12-31" && carEndPeriod) {
    	  
      let carStartDate = new Date(carStartPeriod);
      let carEndDate = new Date(carEndPeriod);
      let carStartYear = carStartDate.getFullYear();
      let carEndYear = carEndDate.getFullYear();
      let carStartMonth = carStartDate.getMonth()+1;
      let carEndMonth = carEndDate.getMonth()+1;
      
      let carDiffYear = carEndYear - carStartYear;
      let carDiffMonth = carEndMonth - carStartMonth;

      // 월이 음수이면 연도에서 1을 빼고, 월에 12를 더하기
      if (carDiffMonth < 0) {
    	  carDiffYear--;
    	  carDiffMonth += 12;
      }
      
      let carPeriodText = "";

      if (carDiffYear > 0) {
    	  carPeriodText += carDiffYear + "년 ";
      }
      
      
      if (carDiffMonth > 0) {
    	  carPeriodText += carDiffMonth + "개월";
      }

      if (carPeriodText === "") {
    	  carPeriodText = "0개월"; 
      }
      
      careerPeriod = carPeriodText.trim();
      }
      
      
      // sumCar 조립하기
      const sumCar = careerPeriod ? "경력" + careerPeriod : "경력없음";
      $j("#sum-car").text(sumCar);
      
      
      // sumLocation , sumWorkType
      let sumLocWork = "";
      
      let locVal = $j("#location").val();
      let workVal = $j("#workType").val();
      sumLocWork = locVal+"전체" + "<br>" + workVal;
      
      $j("#sum-loc-type").html(sumLocWork);
      
      
      
      const submitValue = $j("#submit").val();
   	  // 제출 후 다시 로그인해도 수정할 수 없게 전부 disabled 처리하기
   	  if(submitValue === 'Y') {
   		  
	      const allForm = $j("#recruitForm").find('input, select, button');
	      allForm.each(function(){
	      	this.disabled = true;
	      });
   	  };
      
      
      

	});


  
</script>

<body>
  <form class="recruitForm" id="recruitForm">
    <h2 align="center">입사지원서</h2>
    <table border="1" align="center">
      <tr>
        <td>이름</td>
        <td>
        	<input type="hidden" id="seq" name="seq" value="${recruitVO.seq}" >
        	<input type="hidden" id="submit" name="submit" value="${recruitVO.submit}" >
        	<input type="text" id="name" name="name" maxlength="15" value="${name}" readonly>
        </td>
        <td>생년월일</td>
        <td><input type="text" id="birth" name="birth" maxlength="10" value="${recruitVO.birth}"></td>
      </tr>
      <tr>
        <td>성별</td>
        <td>
          <select id="gender">
            <option value="남자">남자</option>
            <option value="여자">여자</option>
          </select>
        </td>
        <td>연락처</td>
        <td><input type="text" id="phone" name="phone"  value="${phone}" readonly></td>
      </tr>
      <tr>
        <td>email</td>
        <td><input type="text" id="email" name="email" maxlength="30" value="${recruitVO.email}"></td>
        <td>주소</td>
        <td><input type="text" id="addr" name="addr" maxlength="50" value="${recruitVO.addr}"></td>
      </tr>
      <tr>
        <td>희망근무지</td>
        <td>
          <select id="location" name="location">
          	<c:forEach var="loc" items="${locList}">
	            <option value="${loc.codeName}"
	            	<c:if test="${loc.codeName eq recruitVO.location}">selected</c:if>
	            >
	            	${loc.codeName}
	            	</option>      	
          	</c:forEach>
          </select>
        </td>
        <td>근무형태</td>
        <td>
          <select id="workType" name="workType">
	          <option value="계약직" ${recruitVO.workType == '계약직' ? 'selected' : ''}>계약직</option>
	          <option value="정규직" ${recruitVO.workType == '정규직' ? 'selected' : ''}>정규직</option>
          </select>
        </td>
      </tr>
    </table>
    
    <br>
    
    
    <c:if test="${recruitVO.submit eq 'N'}">
    <table border="1" align="center" width="800" id="sum-table">
      <tr>
        <th>학력사항</th>
        <th>경력사항</th>
        <th>희망연봉</th>
        <th>희망근무지/근무형태</th>
      </tr>
      
	    <tr>
	        <td>
	        	<span id="sum-edu" ></span>
	        </td>
	        <td>
	        	<span id="sum-car" ></span>
	        </td>
	        <td>
	        	회사 내규에 따름
	        </td>
	        <td>
	        	<span id="sum-loc-type" ></span>
	        </td>
	      </tr>
	  </table>
	  </c:if>
	  
    

    <h2>학력</h2>
    <div align="right">
	    <button id="edu-add-btn">추가</button>
	    <button id="edu-del-btn">삭제</button>
    </div>
    <table border="1" align="center" width="800" id="edu-table">
      <tr>
        <th> </th>
        <th>재학기간</th>
        <th>구분</th>
        <th>학교명(소재지)</th>
        <th>전공</th>
        <th>학점</th>
      </tr>
      
      <c:if test="${empty eduList}">
	    <tr>
	        <td>
	        	<input type="checkbox"  >
	        	<input type="hidden" id="eduSeq0" name="eduList[0].eduSeq">
	        	<input type="hidden" id="edu-Seq0" name="eduList[0].seq">
	        </td>
	        <td><input type="text" name="eduList[0].startPeriod" id="startPeriod0" maxlength="7"> <br>
	        ~ <br>
	        <input type="text" name="eduList[0].endPeriod" id="endPeriod0" maxlength="7"></td>
	        <td>
	          <select name="eduList[0].division" id="division0">
	            <option value="졸업">졸업</option>
	            <option value="재학">재학</option>
	            <option value="중퇴">중퇴</option>
	          </select>
	        </td>
	        <td><input type="text" name="eduList[0].schoolName" id="schoolName0"> <br>
	 	        <select name="eduList[0].location" id="edu-location0">
		          	<c:forEach var="loc" items="${locList}">
			            <option value="${loc.codeName}">
			            	${loc.codeName}
			            </option>      	
		          	</c:forEach>
	          </select></td>
	        <td><input type="text" name="eduList[0].major" id="major0"></td>
	        <td><input type="text" name="eduList[0].grade" id="grade0" maxlength="3"></td>
	      </tr>
	  </c:if>

      <c:forEach items="${eduList}" var="eduVO" varStatus="status">
		<tr>
		    <td>
		        <input type="checkbox" >
		        <input type="hidden" id="eduSeq${status.index}" name="eduList[${status.index}].eduSeq" value="${eduVO.eduSeq}">
		        <input type="hidden" id="edu-Seq${status.index}" name="eduList[${status.index}].seq" value="${eduVO.seq}">
		    </td>
		    <td><input type="text" name="eduList[${status.index}].startPeriod" id="startPeriod${status.index}" value="${eduVO.startPeriod}" maxlength="7"> <br> ~ <br> <input type="text" name="eduList[${status.index}].endPeriod" id="endPeriod${status.index}" value="${eduVO.endPeriod}" maxlength="7"></td>
		    <td>
		        <select name="eduList[${status.index}].division" id="division${status.index}">
		            <option value="졸업" ${eduVO.division == '졸업' ? 'selected' : ''}>졸업</option>
		            <option value="재학" ${eduVO.division == '재학' ? 'selected' : ''}>재학</option>
		            <option value="중퇴" ${eduVO.division == '중퇴' ? 'selected' : ''}>중퇴</option>
		        </select>
		    </td>
		    <td><input type="text" name="eduList[${status.index}].schoolName" id="schoolName${status.index}" value="${eduVO.schoolName}"> <br>
		        <select name="eduList[${status.index}].location" id="edu-location${status.index}">
		            <c:forEach var="loc" items="${locList}">
		                <option value="${loc.codeName}" ${eduVO.location == loc.codeName ? 'selected' : ''}>
		                    ${loc.codeName}
		                </option>
		            </c:forEach>
		        </select></td>
		    <td><input type="text" name="eduList[${status.index}].major" id="major${status.index}" value="${eduVO.major}"></td>
		    <td><input type="text" name="eduList[${status.index}].grade" id="grade${status.index}" value="${eduVO.grade}" maxlength="3"></td>
		</tr>
		</c:forEach>
      
    </table>


    <h2>경력</h2>
    <div align="right">
	    <button id="car-add-btn">추가</button>
	    <button id="car-del-btn">삭제</button>
    </div>
    <table border="1" align="center" width="800" id="car-table">
      <tr>
        <th> </th>
        <th>근무기간</th>
        <th>회사명</th>
        <th>부서/직급/직책</th>
        <th>지역</th>
      </tr>
      
      <c:if test="${empty carList}">
	    <tr>
	        <td>
	        	<input type="checkbox"  >
	        	<input type="hidden" id="carSeq0" name="carList[0].carSeq">
	        	<input type="hidden" id="car-Seq0" name="carList[0].seq">
	        </td>
	        <td><input type="text" name="carList[0].startPeriod" id="car-startPeriod0" maxlength="7"> <br>
	        ~ <br>
	        <input type="text" name="carList[0].endPeriod" id="car-endPeriod0" maxlength="7"></td>
	        <td><input type="text" name="carList[0].compName" id="compName0"></td>
	        <td><input type="text" name="carList[0].task" id="task0"></td>
	        <td><select name="carList[0].location" id="car-location0">
		            <c:forEach var="loc" items="${locList}">
		                <option value="${loc.codeName}" ${carVO.location == loc.codeName ? 'selected' : ''}>
		                    ${loc.codeName}
		                </option>
		            </c:forEach>
		        </select></td>
	      </tr>
	  </c:if>
      
      <c:forEach items="${carList}" var="carVO" varStatus="status">
		<tr>
		    <td>
		        <input type="checkbox" >
		        <input type="hidden" id="carSeq${status.index}" name="carList[${status.index}].carSeq" value="${carVO.carSeq}">
		        <input type="hidden" id="car-Seq${status.index}" name="carList[${status.index}].seq" value="${carVO.seq}">
		    </td>
		    <td><input type="text" name="carList[${status.index}].startPeriod" id="car-startPeriod${status.index}" value="${carVO.startPeriod}" maxlength="7"> <br> ~ <br> <input type="text" name="carList[${status.index}].endPeriod" id="car-endPeriod${status.index}" value="${carVO.endPeriod}" maxlength="7"></td>
		    <td><input type="text" name="carList[${status.index}].compName" id="compName${status.index}" value="${carVO.compName}"></td>
		    <td><input type="text" name="carList[${status.index}].task" id="task${status.index}" value="${carVO.task}"></td>
		    <td><select name="carList[${status.index}].location" id="car-location${status.index}">
		            <c:forEach var="loc" items="${locList}">
		                <option value="${loc.codeName}" ${carVO.location == loc.codeName ? 'selected' : ''}>
		                    ${loc.codeName}
		                </option>
		            </c:forEach>
		        </select></td>
		</tr>
		</c:forEach>

    </table>


    <h2>자격증</h2>
    <div align="right">
	    <button id="cert-add-btn">추가</button>
	    <button id="cert-del-btn">삭제</button>
    </div>
    <table border="1" align="center" width="800" id="cert-table">
      <tr>
        <th> </th>
        <th>자격증명</th>
        <th>취득일</th>
        <th>발행처</th>
      </tr>
      
      <c:if test="${empty certList}">
	    <tr>
	        <td>
	        	<input type="checkbox"  >
	        	<input type="hidden" id="certSeq0" name="certList[0].certSeq">
	        	<input type="hidden" id="cert-Seq0" name="certList[0].seq">
	        </td>
	        <td><input type="text" name="certList[0].qualifiName" id="qualifiName0"></td>
	        <td><input type="text" name="certList[0].acquDate" id="acquDate0"></td>
	        <td><input type="text" name="certList[0].organizeName" id="organizeName0"></td>
	      </tr>
	  </c:if>
      
      <c:forEach items="${certList}" var="certVO" varStatus="status">
		<tr>
		    <td>
		        <input type="checkbox" >
		        <input type="hidden" id="certSeq${status.index}" name="certList[${status.index}].certSeq" value="${certVO.certSeq}">
		        <input type="hidden" id="cert-Seq${status.index}" name="certList[${status.index}].seq" value="${certVO.seq}">
		    </td>
		    <td><input type="text" name="certList[${status.index}].qualifiName" id="qualifiName${status.index}" value="${certVO.qualifiName}"></td>
		    <td><input type="text" name="certList[${status.index}].acquDate" id="acquDate${status.index}" value="${certVO.acquDate}"></td>
		    <td><input type="text" name="certList[${status.index}].organizeName" id="organizeName${status.index}" value="${certVO.organizeName}"></td>
		</tr>
		</c:forEach>

    </table>
    
    <div>
    	<button id="save-btn">저장</button>
    	<button id="submit-btn">제출</button>
    	<a href="/recruit/login.do">로그인으로 돌아가기</a>
    </div>

  </form>
	
</body>

</html>