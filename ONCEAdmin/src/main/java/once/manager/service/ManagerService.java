package once.manager.service;

import once.manager.vo.ManagerVO;

public interface ManagerService {

	ManagerVO login(ManagerVO manager);
	
	boolean checkPassword(String managerId, String password);

	ManagerVO selectById(String managerId);

	void modifyManager(String managerId);

}
