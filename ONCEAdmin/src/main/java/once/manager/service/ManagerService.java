package once.manager.service;

import java.util.List;

import javax.validation.Valid;

import once.manager.vo.ManagerVO;
import once.notice.vo.NoticeVO;
import once.store.vo.StoreVO;

public interface ManagerService {

	ManagerVO login(ManagerVO manager);
	
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

	ManagerVO selectOnestaffNo(int staffNo);

}
