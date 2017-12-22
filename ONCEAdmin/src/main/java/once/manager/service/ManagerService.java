package once.manager.service;

import java.util.List;

import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

public interface ManagerService {

	ManagerVO login(ManagerVO manager);
	
	String checkType(String id);

	boolean checkPassword(String managerId, String password);

	ManagerVO selectById(String managerId);

	StoreVO selectByNo(String storeNo);

	void modifyManager(String managerId, String password, String telephone);

	List<ManagerVO> selectAll();
	
	void delete(String managerId);
	
	void update(String managerId, String telephone);
	
	void add(ManagerVO manager);
	
	List<ManagerVO> search(ManagerVO manager);
	
	boolean checkId(String managerId);
	
	List<ManagerVO> selectPage(List page);

	List<ManagerVO> selectInfoStaff();

	List<ManagerVO> selectInfoStaffPage(List<Integer> page);

	List<ManagerVO> searchInfoStaff(ManagerVO manager);
	
	//매장 직원 관리
	List<ManagerVO> selectByStore(String storeNo);

	ManagerVO selectOnestaffNo(int staffNo);

	List<ManagerVO> selectByStorePage(List<Object> page);

	List<ManagerVO> searchByStore(ManagerVO manager);
	
	void add1(ManagerVO manager);

}
