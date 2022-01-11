package com.findYou.code.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.code.vo.CodeVO;


@Mapper
public interface ICodeDao {

	/**
	 * 
	* @methodName : getCodeListByParent 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param parentCode
	* @return List<CodeVO>
	* 부모 코드에 대한 리스트 조회
	 */
	public List<CodeVO> getCodeListByParent(String parentCode);
}
