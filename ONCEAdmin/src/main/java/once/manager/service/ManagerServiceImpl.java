package once.manager.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.manager.dao.ManagerDAO;
import once.manager.vo.ManagerVO;

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
	
}
 