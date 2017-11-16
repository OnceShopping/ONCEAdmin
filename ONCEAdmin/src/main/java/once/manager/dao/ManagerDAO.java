package once.manager.dao;

import java.util.List;

import javax.validation.Valid;

import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

public interface ManagerDAO {

	boolean checkPassword(String managerId, String password);

	ManagerVO selectById(String managerId);
	
	StoreVO selectByNo(String storeNo);

	ManagerVO login(ManagerVO manager);

	void modifyManager(String managerId, String password, String telephone);
	
	List<ManagerVO> selectAll();
	
	void delete(int staffNo);
}