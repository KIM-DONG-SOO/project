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


      /*****  �Լ�  *****/

       // index �缳���ϴ� �Լ�
      function makeNewIndex(tableId) {

        //���̺�����+tr�� ��ҵ��� �����ͼ� .each�� �ݺ�
        $j(tableId + " tr").each(function(rowIndex) {

          //<th>�� �ǳʶٱ�
          if(rowIndex === 0) {
            return;
          }

          const newIndex = rowIndex - 1;

          // tr�ȿ� �ִ� input,select ��ҵ��� ã������ each�� ��ø�ݺ�.
          $j(this).find("input, select").each(function() {
            let name = $j(this).attr("name");
            let id = $j(this).attr("id");

            //���� �ε����� �缳��.
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
       

        
        // YYYY-MM ���� ���� �Լ�
        function validYM(idString) {
        		
        		let thisVal = $j(idString).val();
           		let today = new Date();
           		
           		let year = today.getFullYear();
           		
           		inputYear = thisVal.slice(0, 4);
           		inputMonth = thisVal.slice(5, 7);
           		/* inputDate = thisVal.slice(-2); */
           		
           		if(inputYear < 1950 || inputYear > year) {
           			alert("Year ��¥ ���Ŀ� ���� �ʽ��ϴ�.");
           			$j(idString).val("");
           			$j(idString).focus();
           			return;
           		}
           		if(inputMonth < 1 || inputMonth > 12) {
           			alert("Month ��¥ ���Ŀ� ���� �ʽ��ϴ�.");
           			$j(idString).val("");
           			$j(idString).focus();
           			return;
           		}
           		/* if(inputDate < 1 || inputDate > 31) {
           			alert("Date ��¥ ���Ŀ� ���� �ʽ��ϴ�.");
           			$j(idString).val("");
           			$j(idString).focus();
           			return;
           		} */
        }
        
        // ������� ��ȿ�� �˻� �Լ�. (����, YYYY-MM-DD����, ���ó�¥���� ������ �ȵ�, )
        function birthValid(birthVal) {
		  // �Է��� ������ �����Ű�� ����
		  if (!birthVal) {
			  alert('��������� �Է����ּ���.');
			  return false;
		  }
		
		  // YYYY-MM-DD ���� üũ
		  if (!/^\d{4}-\d{2}-\d{2}$/.test(birthVal)) {
			  alert("��¥ ������ 'YYYY-MM-DD'�� ���� �ʽ��ϴ�.");
			  return false;
		  }
		
		  const [year, month, day] = birthVal.split('-').map(Number);

		  // ���� �˻� -> Date ��ü�� ����
		  const date = new Date(year, month - 1, day);
		  if (
		    date.getFullYear() !== year ||
		    date.getMonth() + 1 !== month ||
		    date.getDate() !== day
		  ) {
		    alert("�������� �ʴ� ��¥�Դϴ�.");
		    return false;
		  }

		  // ��������� ���ú��� ���� ��¥������.
		  const today = new Date();
		  const inputDate = new Date(year, month - 1, day);
		  if (inputDate > today) {
		    alert("��������� ���ú��� ���� ��¥���� �մϴ�.");
		    return false;
		  }
		
		  return true;
		}
        
        // YYYY-DD ���Ἲ �˻� �Լ�
        function periodValid(inputVal) {
        	
       	 if(inputVal.length < 7 || !/^\d{4}-\d{2}$/.test(inputVal)) {
        	  alert("YYYY-MM ���Ŀ� ���� �ʽ��ϴ�.")
              return false;
       	 }
  		  const [year, month] = inputVal.split('-').map(Number);
  		  const date = new Date(year, month - 1);
		  if (
		    date.getFullYear() !== year ||
		    date.getMonth() + 1 !== month
		  ) {
		    alert("�������� �ʴ� ��¥�Դϴ�.");
		    return false;
		  }
		  return true;
        }
        
        
        function removeEmptyRows() {
            
            // ��� ���̺��� �� �� ����
            $j("#car-table tr").each(function(index) {
                if(index === 0 || index === 1) return; // ����� ù���� ����
                
                const carStartPeriod = $j(this).find("input[id^='car-startPeriod']").val().trim();
                const carEndPeriod = $j(this).find("input[id^='car-endPeriod']").val().trim();
                const compName = $j(this).find("input[id^='compName']").val().trim();
                const task = $j(this).find("input[id^='task']").val().trim();
                const carLocation = $j(this).find("select[id^='car-location']").val();
                
                // ��� �ʵ尡 ��������� �ش� �� ����
                if(!carStartPeriod && !carEndPeriod && !compName && !task) {
                    $j(this).remove();
                }
            });
            
            // �ڰ��� ���̺��� �� �� ����
            $j("#cert-table tr").each(function(index) {
                if(index === 0 || index === 1) return; // ����� ù���� ����
                
                const qualifiName = $j(this).find("input[id^='qualifiName']").val().trim();
                const acquDate = $j(this).find("input[id^='acquDate']").val().trim();
                const organizeName = $j(this).find("input[id^='organizeName']").val().trim();
                
                // ��� �ʵ尡 ��������� �ش� �� ����
                if(!qualifiName && !acquDate && !organizeName) {
                    $j(this).remove();
                }
            });
            
            // ���� �� �ε��� ������
            makeNewIndex("#car-table");
            makeNewIndex("#cert-table");
        }

        
        
        // ���� Ajax ó�� �Լ�
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
                alert("���� ����: " + data.status);
              }
            },
            error: function() {
              alert("���� �߻�");
            }
          });
        }
        
        
     	// ���� ��ư Ŭ����
        $j("#save-btn").on("click", function(e) {
          e.preventDefault();
          
          //���� ����ڰ� '�߰�'��ư�� ���� �� ���� ������� �����ϸ� ��� ����� ���� ����.
          //����Ǳ� ������ �ش� tr�� ����ó��
          
          //���� �Լ� ���
          removeEmptyRows();

          
       	  // �ʼ��� üũ
          const nameVal = $j('#name').val().trim();
          const birthVal = $j('#birth').val().trim();
          const phoneVal = $j('#phone').val().trim();
          const emailVal = $j('#email').val().trim();
          const addrVal = $j('#addr').val().trim();
          
          if(!nameVal) {
            alert('�̸��� �Է����ּ���.');
            $j('#name').focus();
            return;
          }
          if(!birthVal) {
            alert('��������� �Է����ּ���.');
            $j('#birth').focus();
            return;
          }
          if(!phoneVal) {
            alert('��ȭ��ȣ�� �Է����ּ���.');
            $j('#phone').focus();
            return;
          }
          if(!emailVal) {
            alert('�̸����� �Է����ּ���.');
            $j('#email').focus();
            return;
          }
          if(!addrVal) {
            alert('�ּҸ� �Է����ּ���.');
            $j('#addr').focus();
            return;
          }
       	  // ������� ��ȿ�� �˻� �Լ� ���
          if (!birthValid(birthVal)) {
        	  $j('#birth').focus();
        	  return;
          }
       	  // �̸��� ��ȿ�� �˻�
          let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
          if (!emailPattern.test(emailVal)) {
        	  alert("�������� ���� �̸��� �����Դϴ�.\n���̵�@�������ּ� �������� �Է����ּ���.\n��) recruit123@gmail.com");
        	  $j("#email").focus();
        	  return;
          }
          
       	  // Education(�з�) ��ȿ�� �˻�
          let eduValid = true;
          $j("#edu-table tr").each(function(index) {
            if(index === 0) return; // ��� �ǳʶٱ�
            
            const startPeriod = $j(this).find("input[id^='startPeriod']").val().trim();
            const endPeriod = $j(this).find("input[id^='endPeriod']").val().trim();
            const schoolName = $j(this).find("input[id^='schoolName']").val().trim();
            const major = $j(this).find("input[id^='major']").val().trim();
            const grade = $j(this).find("input[id^='grade']").val().trim();
            
            // �� ���� �˻��ϱ�
            const fields = [
				  { val: startPeriod, selector: "input[id^='startPeriod']", msg: "���� ���� �Ⱓ�� �Է����ּ���." },
				  { val: endPeriod, selector: "input[id^='endPeriod']", msg: "���� ���� �Ⱓ�� �Է����ּ���." },
				  { val: schoolName, selector: "input[id^='schoolName']", msg: "�б����� �Է����ּ���." },
				  { val: major, selector: "input[id^='major']", msg: "������ �Է����ּ���." },
				  { val: grade, selector: "input[id^='grade']", msg: "������ �Է����ּ���." }
			];
			for (let field of fields) {
			    if (!field.val) {
			        alert(field.msg);
			        $j(this).find(field.selector).focus();
			        eduValid = false;
			        return false;
			    }
			}
            
			// periodValid �Լ����
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
            
         	// ���бⰣ ���۰� ���� �� 
            if(startPeriod <= birthVal) {
            	alert("���бⰣ�� �������� ������Ϻ��� �����ϴ�.")
            	$j(this).find("input[id^='startPeriod']").focus();
            	eduValid = false;
                return false;
            }
         	// ���бⰣ ���۰� ���� ��
            if(startPeriod >= endPeriod) {
            	alert("���бⰣ�� �������� �����Ϻ��� �����ϴ�.")
            	$j(this).find("input[id^='endPeriod']").focus();
            	eduValid = false;
                return false;
            }
            //�б��� : �ѱ۸� ���
            if(!/^[\uAC00-\uD7A3\u3131-\u318E]+$/.test(schoolName)) {
                alert("�б����� �ѱ۸� �Է°����մϴ�.");
                $j(this).find("input[id^='schoolName']").focus();
                eduValid = false;
                return false;
            }
            //�б��� : OOO����б�, OOO�������б�, OOO���б�
            if(!/(����б�|�������б�|���б�)$/.test(schoolName)) {
			    alert("�б����� '����б�', '�������б�', '���б�'�� ������ �մϴ�.");
			    $j(this).find("input[id^='schoolName']").focus();
			    eduValid = false;
			    return false;
			}
            //�а� : �ѱ۸� �Է°���
            if(!/^[\uAC00-\uD7A3\u3131-\u318E]+$/.test(major)) {
            	alert("������ �ѱ۸� �Է� �����մϴ�.");
            	$j(this).find("input[id^='major']").focus();
			    eduValid = false;
			    return false;
            }
			//�а� : OOO�а�
            if(!/�а�$/.test(major)) {
			    alert("������ '�а�'�� ������ �մϴ�.");
			    $j(this).find("input[id^='major']").focus();
			    eduValid = false;
			    return false;
			}
            //���� : ���ڸ� ���, 3����, 3.3 ����
			if(!/^[0-9]\.[0-9]$/.test(grade)) {
				alert("������ ���İ� �ٸ��ϴ�.\n����] 4.5\n ���ڸ� �Է� �����մϴ�.")
				$j(this).find("input[id^='grade']").focus();
			    eduValid = false;
			    return false;
			}
            
			

            
            
          });
          
          
       	  // Career(���) ��ȿ�� �˻�
       	  let carValid = true;
          $j("#car-table tr").each(function(index) {
        	  if(index === 0) return; // ��� �ǳʶٱ�
              
              const carStartPeriod = $j(this).find("input[id^='car-startPeriod']").val().trim();
              const carEndPeriod = $j(this).find("input[id^='car-endPeriod']").val().trim();
              const compName = $j(this).find("input[id^='compName']").val().trim();
              const task = $j(this).find("input[id^='task']").val().trim();
              const carLocation = $j(this).find("input[id^='car-location']").val();
              
              // ���࿡ �Է°��� �ϳ��� �ִٸ�, �� ���� �˻��ϱ�
              if(carStartPeriod || carEndPeriod || compName || task || carLocation) {
            	  
	              const fields = [
	  				  { val: carStartPeriod, selector: "input[id^='car-startPeriod']", msg: "��� ���� �Ⱓ�� �Է����ּ���." },
	  				  { val: carEndPeriod, selector: "input[id^='car-endPeriod']", msg: "��� ���� �Ⱓ�� �Է����ּ���." },
	  				  { val: compName, selector: "input[id^='compName']", msg: "ȸ����� �Է����ּ���." },
	  				  { val: task, selector: "input[id^='task']", msg: "�μ�/����/��å�� �Է����ּ���." },
  					];
					for (let field of fields) {
					    if (!field.val) {
					        alert(field.msg);
					        $j(this).find(field.selector).focus();
					        carValid = false;
					        return false;
					    }
					}
					// periodValid �Լ��� �̿�
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
		          // ��±Ⱓ ���۰� �����Ⱓ ���� ��
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
	              	alert("��±Ⱓ�� �������� ���бⰣ �����Ϻ��� �����ϴ�.");
	              	$j(this).find("input[id^='car-startPeriod']").focus();
	              	carValid = false;
	                return false;
	              }
	           	  // ��±Ⱓ ���۰� ���� ��
	              if(carStartPeriod >= carEndPeriod) {
	              	alert("��±Ⱓ�� �������� �����Ϻ��� �����ϴ�.");
	              	$j(this).find("input[id^='car-endPeriod']").focus();
	              	carValid = false;
	                return false;
	              }
	           	  // �μ�/����/��å
	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+\/[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+\/[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(task)) {
					alert("�μ�/����/��å�� ���Ŀ� ���� �ʽ��ϴ�.\n����) SI�����/�ִϾ�/���\nƯ�����ڴ� /�� ��밡��");
					$j(this).find("input[id^='task']").focus();
					carValid = false;
					return false;
	           	  }
              }
          });
  			
  	
       	  // Certificate(�ڰ���) ��ȿ�� �˻�
       	  let certValid = true;
          $j("#cert-table tr").each(function(index) {
        	  if(index === 0) return; // ��� �ǳʶٱ�
              
              const qualifiName = $j(this).find("input[id^='qualifiName']").val().trim();
              const acquDate = $j(this).find("input[id^='acquDate']").val().trim();
              const organizeName = $j(this).find("input[id^='organizeName']").val().trim();
              
              // ���࿡ �Է°��� �ϳ��� �ִٸ�, �� ���� �˻��ϱ�
              if(qualifiName || acquDate || organizeName) {
            	  
	              const fields = [
	  				  { val: qualifiName, selector: "input[id^='qualifiName']", msg: "�ڰ������� �Է����ּ���." },
	  				  { val: acquDate, selector: "input[id^='acquDate']", msg: "�ڰ��� ������� �Է����ּ���." },
	  				  { val: organizeName, selector: "input[id^='organizeName']", msg: "�ڰ��� ����ó�� �Է����ּ���." },
  					];
					for (let field of fields) {
					    if (!field.val) {
					        alert(field.msg);
					        $j(this).find(field.selector).focus();
					        certValid = false;
					        return false;
					    }
					}
					
	           	  // �ڰ����� Ư������ �Ұ�
	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(qualifiName)) {
					alert("�ڰ����� Ư�����ڴ� �Է��� �� �����ϴ�.");
					$j(this).find("input[id^='qualifiName']").focus();
					certValid = false;
					return false;
	           	  }
	          		 // periodValid �Լ��� �̿�
		            if(!periodValid(acquDate)) {
		              $j(this).find("input[id^='acquDate']").focus();
		              certValid = false;
		              return false;
		            }
	           	  // ����ó Ư������ �Ұ�
	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(organizeName)) {
					alert("�ڰ��� ����ó�� Ư�����ڴ� �Է��� �� �����ϴ�.");
					$j(this).find("input[id^='organizeName']").focus();
					certValid = false;
					return false;
	           	  }
              }
          });
          
  	
          // ���� ��ȿ�� �˻� �����ϸ� ���⼭ ����. ����X
          if(!eduValid) return;
          if(!carValid) return;
          if(!certValid) return;
          
          saveOrSubmit("/recruit/saveAction.do", "������ �Ϸ�Ǿ����ϴ�.");
        });


        // ���� ��ư Ŭ����
        $j("#submit-btn").on("click", function(e) {
          e.preventDefault();
          
          removeEmptyRows();

          const submitVal = $j("#submit").val();

          if (submitVal === "N") {
        	  
        	  // �ʼ��� üũ
              const nameVal = $j('#name').val().trim();
              const birthVal = $j('#birth').val().trim();
              const phoneVal = $j('#phone').val().trim();
              const emailVal = $j('#email').val().trim();
              const addrVal = $j('#addr').val().trim();
              
              if(!nameVal) {
                alert('�̸��� �Է����ּ���.');
                $j('#name').focus();
                return;
              }
              
              // ������� ��ȿ�� �˻� �Լ����
              if (!birthValid(birthVal)) {
            	  $j('#birth').focus();
            	  return;
              }
              
              if(!phoneVal) {
                alert('��ȭ��ȣ�� �Է����ּ���.');
                $j('#phone').focus();
                return;
              }
              if(!emailVal) {
                alert('�̸����� �Է����ּ���.');
                $j('#email').focus();
                return;
              }
              // �̸��� ��ȿ�� �˻�
              let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
              if (!emailPattern.test(emailVal)) {
            	  alert("�������� ���� �̸��� �����Դϴ�.\n���̵�@�������ּ� �������� �Է����ּ���.\n��) recruit123@gmail.com");
            	  $j(this).focus();
            	  return;
              }
              
              if(!addrVal) {
                alert('�ּҸ� �Է����ּ���.');
                $j('#addr').focus();
                return;
              }
              
           	  // �з� ��ȿ�� �˻�
              let eduValid = true;
              $j("#edu-table tr").each(function(index) {
                if(index === 0) return; // ��� �ǳʶٱ�
                
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
                // ���бⰣ ���۰� ���� ��
                if(startPeriod >= endPeriod) {
                	alert("���бⰣ�� �������� �����Ϻ��� �����ϴ�.")
                	eduValid = false;
                    return false;
                }
                //�б��� : �ѱ��̳� ���� ���ڸ� ���
                const schoolName = $j(this).find("input[id^='schoolName']").val().trim();
                if(!/^[\uAC00-\uD7A3\u3131-\u318E]+$/.test(schoolName)) {
                    alert("�б����� �ѱ۸� �Է°����մϴ�.");
                    $j(this).find("input[id^='schoolName']").focus();
                    eduValid = false;
                    return false;
                }
              	//�б��� : OOO����б�, OOO�������б�, OOO���б�
                if(!/(����б�|�������б�|���б�)$/.test(schoolName)) {
    			    alert("�б����� '����б�', '�������б�', '���б�'�� ������ �մϴ�.");
    			    $j(this).find("input[id^='schoolName']").focus();
    			    eduValid = false;
    			    return false;
    			}
                //�а� : ������ �ѱ۸� ���
                const major = $j(this).find("input[id^='major']").val().trim();
                if(!/^[\uAC00-\uD7A3\u3131-\u318E]+$/.test(major)) {
                	alert("������ �ѱ۸� �Է� �����մϴ�.");
                	$j(this).find("input[id^='major']").focus();
    			    eduValid = false;
    			    return false;
                }
              	//�а� : OOO�а�
                if(!/�а�$/.test(major)) {
    			    alert("������ '�а�'�� ������ �մϴ�.");
    			    $j(this).find("input[id^='major']").focus();
    			    eduValid = false;
    			    return false;
    			}
              	//���� : ���ڸ� ���, 3����, 3.3 ����
	            const grade = $j(this).find("input[id^='grade']").val().trim();
				if(!/^[0-9]\.[0-9]$/.test(grade)) {
					alert("������ ���İ� �ٸ��ϴ�.\n����] 4.5\n ���ڸ� �Է� �����մϴ�.")
					$j(this).find("input[id^='grade']").focus();
				    eduValid = false;
				    return false;
				}
                
                if(!startPeriod || !endPeriod || !schoolName || !major || !grade) {
                  alert('�з� ������ ��� �Է����ּ���.');
                  eduValid = false;
                  return false;
                }
              });
              
              
           	  // Career(���) ��ȿ�� �˻�
           	  let carValid = true;
              $j("#car-table tr").each(function(index) {
            	  if(index === 0) return; // ��� �ǳʶٱ�
                  
                  const carStartPeriod = $j(this).find("input[id^='car-startPeriod']").val().trim();
                  const carEndPeriod = $j(this).find("input[id^='car-endPeriod']").val().trim();
                  const compName = $j(this).find("input[id^='compName']").val().trim();
                  const task = $j(this).find("input[id^='task']").val().trim();
                  const carLocation = $j(this).find("input[id^='car-location']").val();
                  
                  // ���࿡ �Է°��� �ϳ��� �ִٸ�, �� ���� �˻��ϱ�
                  if(carStartPeriod || carEndPeriod || compName || task || carLocation) {
                	  
    	              const fields = [
    	  				  { val: carStartPeriod, selector: "input[id^='car-startPeriod']", msg: "��� ���� �Ⱓ�� �Է����ּ���." },
    	  				  { val: carEndPeriod, selector: "input[id^='car-endPeriod']", msg: "��� ���� �Ⱓ�� �Է����ּ���." },
    	  				  { val: compName, selector: "input[id^='compName']", msg: "ȸ����� �Է����ּ���." },
    	  				  { val: task, selector: "input[id^='task']", msg: "�μ�/����/��å�� �Է����ּ���." },
      					];
    					for (let field of fields) {
    					    if (!field.val) {
    					        alert(field.msg);
    					        $j(this).find(field.selector).focus();
    					        carValid = false;
    					        return false;
    					    }
    					}
    					// periodValid �Լ��� �̿�
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
    		          // ��±Ⱓ ���۰� �����Ⱓ ���� ��
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
   		              	alert("��±Ⱓ�� �������� ���бⰣ �����Ϻ��� �����ϴ�.");
   		              	$j(this).find("input[id^='car-startPeriod']").focus();
   		              	carValid = false;
   		                return false;
   		              }
	               	  // ��±Ⱓ ���۰� ���� ��
	                  if(carStartPeriod >= carEndPeriod) {
	                  	alert("��±Ⱓ�� �������� �����Ϻ��� �����ϴ�.");
	                  	$j(this).find("input[id^='car-endPeriod']").focus();
	                  	carValid = false;
	                    return false;
	                  }
	               	  // �μ�/����/��å
	               	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+\/[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+\/[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(task)) {
	    				alert("�μ�/����/��å�� ���Ŀ� ���� �ʽ��ϴ�.\n����) SI�����/�ִϾ�/���\nƯ�����ڴ� /�� ��밡��");
	    				$j(this).find("input[id^='task']").focus();
	    				carValid = false;
	    				return false;
	               	  }
                  }
              });
              
           // Certificate(�ڰ���) ��ȿ�� �˻�
           	  let certValid = true;
              $j("#cert-table tr").each(function(index) {
            	  if(index === 0) return; // ��� �ǳʶٱ�
                  
                  const qualifiName = $j(this).find("input[id^='qualifiName']").val().trim();
                  const acquDate = $j(this).find("input[id^='acquDate']").val().trim();
                  const organizeName = $j(this).find("input[id^='organizeName']").val().trim();
                  
                  // ���࿡ �Է°��� �ϳ��� �ִٸ�, �� ���� �˻��ϱ�
                  if(qualifiName || acquDate || organizeName) {
                	  
    	              const fields = [
    	  				  { val: qualifiName, selector: "input[id^='qualifiName']", msg: "�ڰ������� �Է����ּ���." },
    	  				  { val: acquDate, selector: "input[id^='acquDate']", msg: "�ڰ��� ������� �Է����ּ���." },
    	  				  { val: organizeName, selector: "input[id^='organizeName']", msg: "�ڰ��� ����ó�� �Է����ּ���." },
      					];
    					for (let field of fields) {
    					    if (!field.val) {
    					        alert(field.msg);
    					        $j(this).find(field.selector).focus();
    					        certValid = false;
    					        return false;
    					    }
    					}
    					
    	           	  // �ڰ����� Ư������ �Ұ�
    	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(qualifiName)) {
    					alert("�ڰ����� Ư�����ڴ� �Է��� �� �����ϴ�.");
    					$j(this).find("input[id^='qualifiName']").focus();
    					certValid = false;
    					return false;
    	           	  }
    	           // periodValid �Լ��� �̿�
    		            if(!periodValid(acquDate)) {
    		              $j(this).find("input[id^='acquDate']").focus();
    		              certValid = false;
    		              return false;
    		            }
    	           	  // ����ó Ư������ �Ұ�
    	           	  if(!/^[\uAC00-\uD7A3\u3131-\u318Ea-zA-Z0-9]+$/.test(organizeName)) {
    					alert("�ڰ��� ����ó�� Ư�����ڴ� �Է��� �� �����ϴ�.");
    					$j(this).find("input[id^='organizeName']").focus();
    					certValid = false;
    					return false;
    	           	  }
                  }
              });
      	
      	
      	
      	
      	
              // ���� ��ȿ�� �˻� �����ϸ� ���⼭ ����. ����X
              if(!eduValid) return;
              if(!carValid) return;
              if(!certValid) return;
        	  
            saveOrSubmit("/recruit/submitAction.do", "������ �Ϸ�Ǿ����ϴ�.\n���� �Ŀ��� ������ �� �����ϴ�.");
            
            // ���� �� ������ �� ���� ���� disabled ó���ϱ�
            const allForm = $j("#recruitForm").find('input, select, button');
            allForm.each(function(){
            	this.disabled = true;
            });
            
            
          } else if (submitVal === "Y") {
            alert("�̹� ������ �Ϸ�Ǿ����ϴ�. (�����Ұ�)");
          } else {
            alert("������ ���� �������ּ���.");
          }
        });
  	
  	
  	
  	
  	
      
      
      // "�߰�"��ư ������ '�з�' ����߰�
      $j('#edu-add-btn').on('click', function(e) {
        e.preventDefault();
        
        console.log("�з� �߰� ��ư Ŭ����");

        // ���� tr������ �ε��� ���ڸ� ���� �Ǵ��ϰ� ����.
        const newIndex = $j("#edu-table tr").length - 1;

        console.log("�߰��� index",newIndex);

        const newRow =
          '<tr>' +
            '<td><input type="checkbox" ><input type="hidden" id="eduSeq' + newIndex + '" name="eduList[' + newIndex + '].eduSeq"><input type="hidden" id="edu-Seq' + newIndex + '" name="eduList[' + newIndex + '].seq" ></td>' +
            '<td><input type="text" name="eduList[' + newIndex + '].startPeriod" id="startPeriod' + newIndex + '"> <br>' +
            ' ~ <br>' +
            '<input type="text" name="eduList[' + newIndex + '].endPeriod" id="endPeriod' + newIndex + '"></td>' +
            '<td>' +
              '<select name="eduList[' + newIndex + '].division" id="division' + newIndex + '">' +
                '<option value="����">����</option>' +
                '<option value="����">����</option>' +
                '<option value="����">����</option>' +
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

      // ���� ��ư Ŭ����, üũ�� �ڽ��� ����
      $j("#edu-del-btn").on("click", function(e) {
        e.preventDefault();
        
        // üũ�� tr����
        let checkedTr = $j('#edu-table').find('input[type="checkbox"]:checked').length;
        // ���� tr���� (-1�� th���� ����.)
        let nowTr = $j('#edu-table').find('tr').length - 1;
        
        if(checkedTr >= nowTr) {
        	alert("��� 1���� �׸��� ���ܵξ���մϴ�.");
        	return;
        }
        else {
        	
        // üũ�ڽ� �ϳ��� ã�Ƽ� üũ�Ȱ͸� remove
        $j('#edu-table').find('input[type="checkbox"]:checked').each(function() {
            $j(this).closest('tr').remove();
          });

          // ���� �� �ε��� ������,  ������ �Լ��� ����� ���.
          makeNewIndex("#edu-table");
        }
      });

      
      
   	  // "�߰�"��ư ������ '���' ����߰�
      $j('#car-add-btn').on('click', function(e) {
        e.preventDefault();
        
        console.log("��� �߰� ��ư Ŭ����");
        

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
      
      
   	  // ���� ��ư Ŭ����, üũ�� �ڽ��� ����
      $j("#car-del-btn").on("click", function(e) {
        e.preventDefault();
        
        let checkedTr = $j('#car-table').find('input[type="checkbox"]:checked').length;
        let nowTr = $j('#car-table').find('tr').length - 1;
        
        if(checkedTr >= nowTr) {
        	alert("��� 1���� �׸��� ���ܵξ���մϴ�.");
        	return;
        }
        else {
        	
        // üũ�ڽ� �ϳ��� ã�Ƽ� üũ�Ȱ͸� remove
        $j('#car-table').find('input[type="checkbox"]:checked').each(function() {
            $j(this).closest('tr').remove();
          });

          // ���� �� �ε��� ������,  ������ �Լ��� ����� ���.
          makeNewIndex("#car-table");
        }
      });
   	  
   	  
   	  // "�߰�"��ư ������ '�ڰ���' ����߰�
      $j('#cert-add-btn').on('click', function(e) {
        e.preventDefault();
        
        console.log("�ڰ��� �߰� ��ư Ŭ����");
        

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
      
      
   	  // ���� ��ư Ŭ����, üũ�� �ڽ��� ����
      $j("#cert-del-btn").on("click", function(e) {
        e.preventDefault();
        
        let checkedTr = $j('#cert-table').find('input[type="checkbox"]:checked').length;
        let nowTr = $j('#cert-table').find('tr').length - 1;
        
        if(checkedTr >= nowTr) {
        	alert("��� 1���� �׸��� ���ܵξ���մϴ�.");
        	return;
        }
        else {
        	
        // üũ�ڽ� �ϳ��� ã�Ƽ� üũ�Ȱ͸� remove
        $j('#cert-table').find('input[type="checkbox"]:checked').each(function() {
            $j(this).closest('tr').remove();
          });

          // ���� �� �ε��� ������,  ������ �Լ��� ����� ���.
          makeNewIndex("#cert-table");
        }
      });
      
      /*=============================================================================*/
      
      // YYYY-MM-DD �ڵ� ����
      let previousValue = "";
      
      $j("#birth").on("input", function() {
		    let birthVal = $j(this).val();
		    birthVal = birthVal.replace(/[^0-9]/g, '');
		
		    // �ٷ� �� �ڵ忡�� ���ڸ� ���ܵξ����Ƿ�, YYYYMMDD �ִ� 8�ڸ�������
		    if (birthVal.length > 8) {
		        birthVal = birthVal.slice(0, 8);
		    }
		
		    // ���� ������ Ȯ�� (���� ������ ª���� ���� ��)
		    let isDeleting = birthVal.length < previousValue.replace(/[^0-9]/g, '').length;
		
		    // 4�ڸ�: YYYY-
		    if (birthVal.length === 4 && !isDeleting) {
		        birthVal = birthVal + "-";
		    }
		    // 5~6�ڸ�: YYYY-MM �Ǵ� YYYY-MM-
		    else if (birthVal.length > 4 && birthVal.length <= 6) {
		        birthVal = birthVal.slice(0, 4) + "-" + birthVal.slice(4);
		        if (birthVal.length === 7 && !isDeleting) {
		            birthVal = birthVal + "-";
		        }
		    }
		    // 7~8�ڸ�: YYYY-MM-DD
		    else if (birthVal.length > 6) {
		        birthVal = birthVal.slice(0, 4) + "-" + birthVal.slice(4, 6) + "-" + birthVal.slice(6);
		    }
		
		    previousValue = birthVal;
		    $j(this).val(birthVal);
		});
      
   	  
   	  // �̸��� ���� �Է� üũ (����+Ư�����ڸ� ����)
      $j("#email").on("input", function() {
    	  
    	  let emailVal = $j(this).val();
          let emailPattern = /[^a-zA-Z0-9._\-@]/;
          
          if(emailVal !== '' && emailPattern.test(emailVal)) {
        	  $j(this).val("");
        	  /* alert("�̸����� ����, ����, .,_,-,@ �� �Է°����մϴ�.") */
          }

    	  
      });
   	  

      // ���бⰣ ������, ������ �ڵ� ����
      $j("#edu-table").on("input", "input[id^='startPeriod'], input[id^='endPeriod']", function() {
          let inputVal = $j(this).val();
      	  // �� input�� ���� �� (data �Ӽ��� ����)
          let prevVal = $j(this).data('prevVal') || '';
          inputVal = inputVal.replace(/[^0-9]/g, '');
          
          // ���� ������ Ȯ��
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
      
      // ��±Ⱓ ������, ������ �ڵ� ����
      let carPrevVal = "";
      
      $j("#car-table").on("input", "input[id^='car-startPeriod'], input[id^='car-endPeriod']", function() {
          let inputVal = $j(this).val();
       	  // �� input�� ���� �� (data �Ӽ��� ����)
          let prevVal = $j(this).data('prevVal') || '';
          inputVal = inputVal.replace(/[^0-9]/g, '');
          
          // ���� ������ Ȯ��
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
      
      
      // �ڰ��� ����� �ڵ� ����
      let certPrevVal = "";
      
      $j("#cert-table").on("input", "input[id^='acquDate']", function() {
          let inputVal = $j(this).val();
          inputVal = inputVal.replace(/[^0-9]/g, '');
          
          // ���� ������ Ȯ��
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
      
      
      // sum-table�� �� �з»���.
      // schoolName ������ ���ڷ� '����б�', '�������б�', '���б�' �з�
      // endPeriod - startPeriod = ���б�()�ȿ� �Ⱓ ǥ��
      // division���� '����', '����', '����' 
      
      let schoolType = "";
      let schoolPeriod = "";
      let schoolDivision = "";
      
      // ���� �ֱ� �з� �ε���
      let latestIndex = -1;
      // �ӽú���
      let tempdiff = Infinity;
      let latestElement = null;
      
      // ���糯¥�� �������� ���� �ֱ� �з»����� ��������
      $j("[id^='endPeriod']").each(function(index){
    	  const recentEduDate = $j(this).val()
    	  let recentDate = new Date(recentEduDate + "-01");
    	  
    	  // ���� ��¥�� YYYY-MM-01 �������� ���Ͻ�Ŵ
    	  let currentDate = new Date();
    	  currentDate.setDate(1);
    	  
    	  //���糯¥�� ������������ ����
    	  diff = currentDate - recentDate;
    	  console.log(diff);
    	  
    	  if (diff >= 0 && diff < tempdiff) { 
   	        tempdiff = diff;
   	        // �ش� �ε��� (���� ���̰� ���� ��¥=�ֱٳ�¥)
   	        latestIndex = index;
   	        // �ش� DOM��� ������ ���
   	     	latestElement = $j(this);
    	  }
      });
      
      
      // �б�Ÿ�� ����
      if(latestElement) {
	      const recentSchoolName = latestElement.closest("tr").find("input[id^='schoolName']").val();
	      console.log("recentSchoolName::",recentSchoolName);
    	  
	   	  if(recentSchoolName.endsWith("����б�")) {
	    	  schoolType = "����б�";
	   	  }
	   	  else if(recentSchoolName.endsWith("�������б�")) {
	    	  schoolType = "�������б�";
	   	  }
	   	  else if(recentSchoolName.endsWith("���б�")) {
	    	  schoolType = "���б�";
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

      // ���� �����̸� �������� 1�� ����, ���� 12�� ���ϱ�
      if (diffMonth < 0) {
          diffYear--;
          diffMonth += 12;
      }
      
      let periodText = "";

      if (diffYear > 0) {
          periodText += diffYear + "�� ";
      }
      else if (diffYear > 4) {
    	  periodText = "4��";
      }
      
      
      if (diffMonth > 0) {
          periodText += diffMonth + "����";
      }

      if (periodText === "") {
          periodText = "0����"; 
      }
      
      //���� 4�� �̻��̸� �׳� "4��"
      if (diffYear > 4) {
    	  periodText = "4��";
      }

      schoolPeriod = periodText.trim();
      
      
      $j("[id^='division']").each(function() {
    	  thisDivi = $j(this).val();
    	  if(schoolType === "����б�") {
    		  schoolDivision = thisDivi;
    		  return false;
    	  }
    	  else if(schoolType === "�������б�") {
    		  schoolDivision = thisDivi;
    		  return false;
    	  }
    	  else if(schoolType === "���б�") {
    		  schoolDivision = thisDivi;
    		  return false;
    	  }
      });
      
      // sum-table �з»��� �����ϱ�
      const sumEdu = schoolType + "(" + schoolPeriod + ")" + schoolDivision;
      // value������ ����ֱ�
      $j("#sum-edu").text(sumEdu);

   	  
   	  
      // sum-table ��»��� �����
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
      console.log("�������ù��carStartPeriod::",carStartPeriod);
      $j("[id^='car-endPeriod']").each(function(){
    	  thisPeriod = $j(this).val();
    	  if(thisPeriod > carEndPeriod) {
    		  carEndPeriod = thisPeriod;
    	  }
      });
      console.log("������ϸ�������carEndPeriod::",carEndPeriod);
      
      if(carStartPeriod !== "9999-12-31" && carEndPeriod) {
    	  
      let carStartDate = new Date(carStartPeriod);
      let carEndDate = new Date(carEndPeriod);
      let carStartYear = carStartDate.getFullYear();
      let carEndYear = carEndDate.getFullYear();
      let carStartMonth = carStartDate.getMonth()+1;
      let carEndMonth = carEndDate.getMonth()+1;
      
      let carDiffYear = carEndYear - carStartYear;
      let carDiffMonth = carEndMonth - carStartMonth;

      // ���� �����̸� �������� 1�� ����, ���� 12�� ���ϱ�
      if (carDiffMonth < 0) {
    	  carDiffYear--;
    	  carDiffMonth += 12;
      }
      
      let carPeriodText = "";

      if (carDiffYear > 0) {
    	  carPeriodText += carDiffYear + "�� ";
      }
      
      
      if (carDiffMonth > 0) {
    	  carPeriodText += carDiffMonth + "����";
      }

      if (carPeriodText === "") {
    	  carPeriodText = "0����"; 
      }
      
      careerPeriod = carPeriodText.trim();
      }
      
      
      // sumCar �����ϱ�
      const sumCar = careerPeriod ? "���" + careerPeriod : "��¾���";
      $j("#sum-car").text(sumCar);
      
      
      // sumLocation , sumWorkType
      let sumLocWork = "";
      
      let locVal = $j("#location").val();
      let workVal = $j("#workType").val();
      sumLocWork = locVal+"��ü" + "<br>" + workVal;
      
      $j("#sum-loc-type").html(sumLocWork);
      
      
      
      const submitValue = $j("#submit").val();
   	  // ���� �� �ٽ� �α����ص� ������ �� ���� ���� disabled ó���ϱ�
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
    <h2 align="center">�Ի�������</h2>
    <table border="1" align="center">
      <tr>
        <td>�̸�</td>
        <td>
        	<input type="hidden" id="seq" name="seq" value="${recruitVO.seq}" >
        	<input type="hidden" id="submit" name="submit" value="${recruitVO.submit}" >
        	<input type="text" id="name" name="name" maxlength="15" value="${name}" readonly>
        </td>
        <td>�������</td>
        <td><input type="text" id="birth" name="birth" maxlength="10" value="${recruitVO.birth}"></td>
      </tr>
      <tr>
        <td>����</td>
        <td>
          <select id="gender">
            <option value="����">����</option>
            <option value="����">����</option>
          </select>
        </td>
        <td>����ó</td>
        <td><input type="text" id="phone" name="phone"  value="${phone}" readonly></td>
      </tr>
      <tr>
        <td>email</td>
        <td><input type="text" id="email" name="email" maxlength="30" value="${recruitVO.email}"></td>
        <td>�ּ�</td>
        <td><input type="text" id="addr" name="addr" maxlength="50" value="${recruitVO.addr}"></td>
      </tr>
      <tr>
        <td>����ٹ���</td>
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
        <td>�ٹ�����</td>
        <td>
          <select id="workType" name="workType">
	          <option value="�����" ${recruitVO.workType == '�����' ? 'selected' : ''}>�����</option>
	          <option value="������" ${recruitVO.workType == '������' ? 'selected' : ''}>������</option>
          </select>
        </td>
      </tr>
    </table>
    
    <br>
    
    
    <c:if test="${recruitVO.submit eq 'N'}">
    <table border="1" align="center" width="800" id="sum-table">
      <tr>
        <th>�з»���</th>
        <th>��»���</th>
        <th>�������</th>
        <th>����ٹ���/�ٹ�����</th>
      </tr>
      
	    <tr>
	        <td>
	        	<span id="sum-edu" ></span>
	        </td>
	        <td>
	        	<span id="sum-car" ></span>
	        </td>
	        <td>
	        	ȸ�� ���Կ� ����
	        </td>
	        <td>
	        	<span id="sum-loc-type" ></span>
	        </td>
	      </tr>
	  </table>
	  </c:if>
	  
    

    <h2>�з�</h2>
    <div align="right">
	    <button id="edu-add-btn">�߰�</button>
	    <button id="edu-del-btn">����</button>
    </div>
    <table border="1" align="center" width="800" id="edu-table">
      <tr>
        <th> </th>
        <th>���бⰣ</th>
        <th>����</th>
        <th>�б���(������)</th>
        <th>����</th>
        <th>����</th>
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
	            <option value="����">����</option>
	            <option value="����">����</option>
	            <option value="����">����</option>
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
		            <option value="����" ${eduVO.division == '����' ? 'selected' : ''}>����</option>
		            <option value="����" ${eduVO.division == '����' ? 'selected' : ''}>����</option>
		            <option value="����" ${eduVO.division == '����' ? 'selected' : ''}>����</option>
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


    <h2>���</h2>
    <div align="right">
	    <button id="car-add-btn">�߰�</button>
	    <button id="car-del-btn">����</button>
    </div>
    <table border="1" align="center" width="800" id="car-table">
      <tr>
        <th> </th>
        <th>�ٹ��Ⱓ</th>
        <th>ȸ���</th>
        <th>�μ�/����/��å</th>
        <th>����</th>
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


    <h2>�ڰ���</h2>
    <div align="right">
	    <button id="cert-add-btn">�߰�</button>
	    <button id="cert-del-btn">����</button>
    </div>
    <table border="1" align="center" width="800" id="cert-table">
      <tr>
        <th> </th>
        <th>�ڰ�����</th>
        <th>�����</th>
        <th>����ó</th>
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
    	<button id="save-btn">����</button>
    	<button id="submit-btn">����</button>
    	<a href="/recruit/login.do">�α������� ���ư���</a>
    </div>

  </form>
	
</body>

</html>