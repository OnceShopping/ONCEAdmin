package once.manager.dao;

import javax.validation.Valid;

import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

public interface ManagerDAO {

	boolean checkPassword(String managerId, String password);

	ManagerVO selectById(String managerId);
	
	StoreVO selectByNo(String storeNo);

	void modifyManager(@Valid ManagerVO manager);

	ManagerVO login(ManagerVO manager);

}