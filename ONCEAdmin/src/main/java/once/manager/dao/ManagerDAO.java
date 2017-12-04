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
	
	void delete(String managerId);
	
	void update(String managerId, String telephone);
	
	void insert(ManagerVO manager);
	
	List<ManagerVO> search(ManagerVO manager);

	boolean checkId(String managerId);
	
	List<ManagerVO> selectPage(List page);

	List<ManagerVO> selectInfoStaff();

	List<ManagerVO> selectInfoStaffPage(List<Integer> page);

	List<ManagerVO> searchInfoStaff(ManagerVO manager);

}