package once.manager.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.manager.dao.ManagerDAO;
import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

@Service
public class ManagerServiceImpl implements ManagerService{

	@Autowired
	private ManagerDAO dao;

	@Override
	public ManagerVO login(ManagerVO manager) {
			System.out.println("service 실행");
			return dao.login(manager);
	}
	
	@Override
	public boolean checkPassword(String managerId, String password) {
		return dao.checkPassword(managerId, password);
	}

	@Override
	public ManagerVO selectById(String managerId) {
		return dao.selectById(managerId);
	}

	@Override
	public StoreVO selectByNo(String storeNo) {
		return dao.selectByNo(storeNo);
	}

	@Override
	public void modifyManager(String managerId, String password, String telephone) {
		dao.modifyManager(managerId, password, telephone);
	}
	
	//매니저 전체 조회
	@Override
	public List<ManagerVO> selectAll() {
		
		List<ManagerVO> list = dao.selectAll();
		
		return list;
	}
	
	//매니저 삭제
	@Override
	public void delete(int staffNo) {
		
		dao.delete(staffNo);
	}
	
}
 