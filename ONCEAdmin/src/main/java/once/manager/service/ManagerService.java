package once.manager.service;

import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

public interface ManagerService {

	ManagerVO login(ManagerVO manager);
	
	boolean checkPassword(String managerId, String password);

	ManagerVO selectById(String managerId);

	StoreVO selectByNo(String storeNo);

	void modifyManager(String managerId);

}
