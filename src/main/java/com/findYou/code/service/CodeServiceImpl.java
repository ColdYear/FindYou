package com.findYou.code.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.code.dao.ICodeDao;
import com.findYou.code.vo.CodeVO;
import com.findYou.exception.BizNotFoundException;

@Service
public class CodeServiceImpl {

	@Inject
	ICodeDao iCodeDao;
	
	public List<CodeVO> getCodeListByParent(String parentCode) {
		
		List<CodeVO> codeList = iCodeDao.getCodeListByParent(parentCode);
		return codeList;
	}
}
