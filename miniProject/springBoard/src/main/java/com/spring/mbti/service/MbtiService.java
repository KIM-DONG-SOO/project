package com.spring.mbti.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mbti.dao.MbtiDao;
import com.spring.mbti.vo.MbtiVo;
import com.spring.mbti.vo.PageVo;

@Service
public class MbtiService {
	
	@Autowired
	MbtiDao mbtiDao;
	
	public List<MbtiVo> selectList(PageVo pageVo) throws Exception {
		
		return mbtiDao.selectList(pageVo);
	}
	
	// 시나리오 요구사항 처럼 3210123이 딱 보여야함
	public String calculateMbtiResult(Map<String, String[]> paramMap) throws Exception {
		
		StringBuilder result = new StringBuilder();
		// 점수 계산을 위한 임시 맵 선언
		Map<String, Integer> tempMap = new HashMap<>();
        tempMap.put("E", 0); tempMap.put("I", 0);
        tempMap.put("N", 0); tempMap.put("S", 0);
        tempMap.put("F", 0); tempMap.put("T", 0);
        tempMap.put("J", 0); tempMap.put("P", 0);
		
		for(Map.Entry<String, String[]> entry : paramMap.entrySet()) {
			String key = entry.getKey(); //EI, IE, NS...
			String firstType = String.valueOf(key.charAt(0));
			String secondType = String.valueOf(key.charAt(1));
			
			String[] values = entry.getValue();
			// 배열에 있는 value 하나씩 꺼내기
			String value = values[0];
			
			if(value.equals("7")) {
				tempMap.put(firstType, tempMap.get(firstType) + 3);
			}
			else if(value.equals("6")) {
				tempMap.put(firstType, tempMap.get(firstType) + 2);
			}
			else if(value.equals("5")) {
				tempMap.put(firstType, tempMap.get(firstType) + 1);
			}
			else if(value.equals("4")) {
				tempMap.put(firstType, tempMap.get(firstType) + 0);
			}
			else if(value.equals("3")) {
				tempMap.put(secondType, tempMap.get(secondType) + 1);
			}
			else if(value.equals("2")) {
				tempMap.put(secondType, tempMap.get(secondType) + 2);
			}
			else if(value.equals("1")) {
				tempMap.put(secondType, tempMap.get(secondType) + 3);
			}
		}
		// 합산 점수가 같거나, 모두 0점인 경우 사전순으로 빠른 문자를 선정.
		result.append(selectType(tempMap, "E", "I"));
		result.append(selectType(tempMap, "N", "S"));
		result.append(selectType(tempMap, "F", "T"));
		result.append(selectType(tempMap, "J", "P"));
		
		return result.toString();
	}
	
	// MBTI 문자 선정 함수
	public String selectType(Map<String, Integer> tempMap, String firstType,
															String secondType) {
		
		String selectedType = "";
		
		int firstScore = tempMap.get(firstType);
		int secondScore = tempMap.get(secondType);
		
		int flagNum = firstType.compareTo(secondType);
		
		// 단순 수치 비교
		if(firstScore > secondScore) {
			selectedType = firstType;
		}
		else if(firstScore < secondScore) {
			selectedType = secondType;
		}
		// 합산 점수가 같거나, 모두 0점인 경우 사전순으로 빠른 문자를 선정.
		else if(firstScore==secondScore || firstScore==0 && secondScore==0) {
			selectedType = (flagNum<0) ? firstType : secondType;
		}
		
		return selectedType;
	}
	
}
		
		
		
		
//			String[] values = paramMap.get(key);
//			for(String sPoint : values) {
//				int point = Integer.parseInt(sPoint);
//				
//				if(tempMap.get(firstType) > 4) {
//					tempMap.put(firstType, tempMap.get(firstType) + point);
//				}
//				else if(tempMap.get(firstType) < 4) {
//					tempMap.put(secondType, tempMap.get(secondType));
//				}
//			}
//			
//			for(String tempKey : tempKeys) {
//				if(tempMap.get(firstType) > tempMap.get(secondType)) {
//					result.append(tempKey);
//				}
//				else if(tempMap.get(firstType).equals(tempMap.get(secondType)) ||
//						tempMap.get(firstType).equals(0)) {
//					
//					int num = firstType.compareTo(secondType);
//					if(num > 0) {
//						result.append(tempKey);
//					}
//				}
//			}
			// key가 E인 sum이 key가 I인 sum 보다 크다면 result에 E를 할당
			
			// key가 E인 sum이 key가 I인 sum 과 같다면 문자의 사전순서를 비교해서 result에 할당
		
		
		
		
//		// 파라미터 맵을 전체 순회하며 임시 맵에 타입별 점수를 저장
//		for(Map.Entry<String, String[]> entry : paramMap.entrySet()) {
//			String key = entry.getKey(); //EI, NS...
//			String[] values = entry.getValue(); // [7,5,3..]
//			// 배열에 있는 value 하나씩 꺼내기
//			String value = values[0]; // 7
//			
//			tempMap.put(key, null);
//			
//			int point = 0;
//			if(value != null) {
//				int val = Integer.parseInt(value);
//				
//				char first = key.charAt(0);
//				char second = key.charAt(1);
//				point = Math.abs(4 - val);
//				
//				if(val > 4) {
//					tempMap.merge(String.valueOf(first), point, Integer::sum);
//				}
//				else if(val < 4) {
//					tempMap.merge(String.valueOf(second), point, Integer::sum);
//				}
//			}
//		}
//		
//		// 문자열1.compareTo(문자열2) 메소드를 이용해서 문자의 사전적 순서를 구분하기
//		
//		Set<String> typeSet = tempMap.keySet();
//		
//		for(String type : typeSet) {
//			
//		}
//		
//		StringBuilder result = new StringBuilder();
//		
//		result.append(tempMap.get("E") > tempMap.get("I") ? "E" : "I");
//		result.append(tempMap.get("N") > tempMap.get("S") ? "N" : "S");
//		result.append(tempMap.get("F") > tempMap.get("T") ? "F" : "T");
//		result.append(tempMap.get("J") > tempMap.get("P") ? "J" : "P");
		

