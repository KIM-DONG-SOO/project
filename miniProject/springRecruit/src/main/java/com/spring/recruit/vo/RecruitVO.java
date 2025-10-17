package com.spring.recruit.vo;

import java.util.List;

public class RecruitVO {
	
	private String 	seq;
	private String 	name;
	private String 	birth;
	private String 	field3;
	private String 	phone;
	private String 	email;
	private String 	addr;
	private String 	location;
	private String 	workType;
	private String 	submit;
	
	//COM_CODE에서 가져오는 지역 이름
	private String 	codeType;
	private String 	codeName;
	
	//학력 항목
	private List<EducationVO> eduList;
	
	//경력 항목
	private List<CareerVO> carList;
	
	//자격증 항목
	private List<CertificateVO> certList;
	

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getField3() {
		return field3;
	}

	public void setField3(String field3) {
		this.field3 = field3;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public String getSubmit() {
		return submit;
	}

	public void setSubmit(String submit) {
		this.submit = submit;
	}

	public String getCodeType() {
		return codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public List<EducationVO> getEduList() {
		return eduList;
	}

	public void setEduList(List<EducationVO> eduList) {
		this.eduList = eduList;
	}

	public List<CareerVO> getCarList() {
		return carList;
	}

	public void setCarList(List<CareerVO> carList) {
		this.carList = carList;
	}

	public List<CertificateVO> getCertList() {
		return certList;
	}

	public void setCertList(List<CertificateVO> certList) {
		this.certList = certList;
	}
	
	
	
	
	
	
	
	
	
	
}
