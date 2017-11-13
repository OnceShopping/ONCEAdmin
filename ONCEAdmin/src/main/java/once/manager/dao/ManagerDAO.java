package once.manager.dao;

import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

public interface ManagerDAO {

	boolean checkPassword(String managerId, String password);

	ManagerVO selectById(String managerId);
	
	StoreVO selectByNo(String storeNo);

	void modifyManager(String managerId);

	ManagerVO login(ManagerVO manager);

}