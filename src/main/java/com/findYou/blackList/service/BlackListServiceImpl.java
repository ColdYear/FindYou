package com.findYou.blackList.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.blackList.dao.IBlackListDao;
import com.findYou.blackList.vo.BlackListVO;
import com.findYou.exception.BizNotEffectedException;

@Service
public class BlackListServiceImpl {

	@Inject
	IBlackListDao iBlackListDao;
	
	public BlackListVO getBlackList(String id) {
		BlackListVO member = iBlackListDao.getBlackList(id);
		return member;
	}
	
	public int insertBlackList(BlackListVO member) throws BizNotEffectedException{
		int cnt = iBlackListDao.insertBlackList(member);
		if(cnt <= 0) throw new BizNotEffectedException();
		return cnt;
	}
	
	public List<BlackListVO> businessGenderCheck(){
		List<BlackListVO> blackList = iBlackListDao.businessGenderCheck();
		return blackList;
	}
	
}
