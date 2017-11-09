package once.manager.service;

import once.manager.vo.ManagerVO;

public interface ManagerService {

	boolean checkPassword(String managerId, String password);

	ManagerVO selectById(String managerId);

}
