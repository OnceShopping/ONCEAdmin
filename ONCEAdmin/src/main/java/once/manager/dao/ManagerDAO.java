package once.manager.dao;

import java.util.List;

import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

public interface ManagerDAO {

	String checkType(String id);

	boolean checkPassword(String managerId, String password);

	ManagerVO selectById(String managerId);
	
	StoreVO selectByNo(String storeNo);

	ManagerVO login(ManagerVO manager);

	void modifyManager(String managerId, String password, String telephone);
	
	List<ManagerVO> selectAll();
	
	void delete(String managerId);
	
	void update(String managerId, String telephone);
	
	void insert(ManagerVO manager);
	
	List<ManagerVO> search(ManagerVO manager);

	boolean checkId(String managerId);
	
	List<ManagerVO> selectPage(List page);

	List<ManagerVO> selectInfoStaff();

	List<ManagerVO> selectInfoStaffPage(List<Integer> page);

	List<ManagerVO> searchInfoStaff(ManagerVO manager);

	ManagerVO selectOnestaffNo(int staffNo);

	//매장 직원 관리
	List<ManagerVO> selectByStore(String storeNo);
	
	List<ManagerVO> selectByStorePage(List<Object> page);

	List<ManagerVO> searchByStore(ManagerVO manager);
	
	void insert1(ManagerVO manager);

}