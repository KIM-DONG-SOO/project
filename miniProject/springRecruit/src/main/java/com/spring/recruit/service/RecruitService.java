package com.spring.recruit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.recruit.dao.CareerDAO;
import com.spring.recruit.dao.CertificateDAO;
import com.spring.recruit.dao.EducationDAO;
import com.spring.recruit.dao.RecruitDAO;
import com.spring.recruit.vo.CareerVO;
import com.spring.recruit.vo.CertificateVO;
import com.spring.recruit.vo.EducationVO;
import com.spring.recruit.vo.RecruitVO;

@Service
public class RecruitService {
	
	@Autowired
	RecruitDAO recruitDAO;
	@Autowired
	EducationDAO educationDAO;
	@Autowired
	CareerDAO careerDAO;
	@Autowired
	CertificateDAO certificateDAO;
	
	public List<RecruitVO> selectLocList() throws Exception {
		
		return recruitDAO.selectLocList();
	}
	
	
	public RecruitVO selectRecruit(String phone) throws Exception {
		
		return recruitDAO.selectRecruit(phone);
	}
	public List<EducationVO> selectEduList(String seq) throws Exception {
		
		return educationDAO.selectEduList(seq);
	}
	public List<CareerVO> selectCarList(String seq) throws Exception {
		
		return careerDAO.selectCarList(seq);
	}
	public List<CertificateVO> selectCertList(String seq) throws Exception {
		
		return certificateDAO.selectCertList(seq);
	}
	
	
	// 서비스단에서 트랜젝션 처리하기
	@Transactional
	public void insertRecruitAll(RecruitVO recruitVO) throws Exception {
		
		System.out.println("insertRecruitAll 함수 실행 시작");
		
		// submit컬럼 "N"으로 처리
		recruitVO.setSubmit("N");
		// 메인 테이블 insert 먼저 진행 (이때 서브테이블 insert보다 먼저 실행되었기 때문에, 시퀀스가 먼저 생성됨)
		recruitDAO.insertRecruit(recruitVO);
		System.out.println("recruit 인서트 완료");
		// 생성된 기본키 Seq 가져오기
		String recruitSeq = recruitVO.getSeq();
		
		
		for(EducationVO eduVO : recruitVO.getEduList()) {
			//외래키로 설정해주기 (아래 나머지 서브테이블도 동일)
			eduVO.setSeq(recruitSeq);
			educationDAO.insertEducation(eduVO);
		}
		System.out.println("eduList 인서트 완료");
		
		
		// 경력 항목이 null값이면 실행안함
		for(CareerVO carVO : recruitVO.getCarList()) {
			if(carVO.getCompName() == null || carVO.getCompName().isEmpty()) {
				System.out.println("경력항목이 없으므로 insert하지 않음");
			}
			else {
				carVO.setSeq(recruitSeq);
				careerDAO.insertCareer(carVO);
				System.out.println("carList 인서트 완료");
			}
		}			
		
		// 자격증 항목이 null값이면 실행안함
		for(CertificateVO certVO : recruitVO.getCertList()) {
			if(certVO.getQualifiName() == null || certVO.getQualifiName().isEmpty()) {
				System.out.println("자격증항목이 없으므로 insert하지 않음");
			}
			else {
				certVO.setSeq(recruitSeq);
				certificateDAO.insertCertificate(certVO);
				System.out.println("certList 인서트 완료");
			}
		}			
		
	}
	
	
	@Transactional
	public void updateRecruitAll(RecruitVO recruitVO) throws Exception {
		
		System.out.println("updateRecruitAll 함수 실행 시작");
		
		recruitDAO.updateRecruit(recruitVO);
		System.out.println("recruit 업데이트 완료");
		
		//아래 insert문에서 외래키 삽입용
		String recruitSeq = recruitVO.getSeq();
		
		//현재 프론트에서 넘어온 VO는 외래키가 없다.
		//따라서 외래키가 없으면 insert, 있다면, 기존DB에 있다는 거니까,update // 아래 나머지 동일 로직.
		for(EducationVO eduVO : recruitVO.getEduList()) {
			if(eduVO.getSeq() == null || eduVO.getSeq().isEmpty()) {
				eduVO.setSeq(recruitSeq);
				educationDAO.insertEducation(eduVO);
			}
			else {
				eduVO.setSeq(recruitSeq);
				educationDAO.updateEducation(eduVO);
			}
		
		}
		// + 수정 : ""빈값이 DB에 저장되는 문제 발생. ->  빈값 방지 if문, continue 추가
		// + 다시 수정 : 수정할때는 빈값을 허용해줘야함. 사용자가 삭제하는 것 처럼 입력값을 지우고 저장 -> 빈값으로 저장
		for(CareerVO carVO : recruitVO.getCarList()) {
			// compName이 비어 있으면 insert/update 모두 스킵
		    if (carVO.getCompName() == null || carVO.getCompName().isEmpty()) {
		        System.out.println("경력항목이 빈 값");
		        // 그런데 만약에 기존에 DB에 있다면? -> 빈값 저장 가능
		        if(carVO.getCarSeq() != null || !carVO.getCarSeq().isEmpty()) {
		        	careerDAO.updateCareer(carVO);
			        System.out.println("carVO update함 ");
		        }
		        continue;
		    }

		    // 외래키 세팅
		    carVO.setSeq(recruitSeq);

		    // seq가 비어 있으면 insert, 아니면 update
		    if (carVO.getSeq() == null || carVO.getSeq().isEmpty()) {
		        careerDAO.insertCareer(carVO);
		        System.out.println("carVO insert함");	
		    } else {
		        careerDAO.updateCareer(carVO);
		        System.out.println("carVO update함 ");
		    }
		
		}
		
		for(CertificateVO certVO : recruitVO.getCertList()) {
			
			if(certVO.getQualifiName() == null || certVO.getQualifiName().isEmpty()) {
				System.out.println("자격증 항목이 빈 값");
				if(certVO.getCertSeq() != null || !certVO.getCertSeq().isEmpty()) {
					certificateDAO.updateCertificate(certVO);
					System.out.println("certVO update함");
				}
				continue;
			}
			// 외래키 세팅
			certVO.setSeq(recruitSeq);
			
			if(certVO.getSeq() == null || certVO.getSeq().isEmpty()) {
				certificateDAO.insertCertificate(certVO);
				System.out.println("certVO insert함");
			}
			else {
				certificateDAO.updateCertificate(certVO);
				System.out.println("certVO update함");
			}
		
		}
	}
	
	
	
	
	
}
		
		
