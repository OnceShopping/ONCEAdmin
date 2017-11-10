package once.manager.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.manager.vo.ManagerVO;

@Repository
public class ManagerDAOImpl implements ManagerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public boolean checkPassword(String managerId, String password) {
		boolean result = false;
		
        Map<String, String> map = new HashMap<String, String>();
        map.put("managerId", managerId);
        map.put("password", password);
        
        int count = sqlSession.selectOne("once.manager.dao.ManagerDAO.checkPassword", map);
        if(count == 1) {
        	result= true;
        }
        
        return result;
	}

	@Override
	public ManagerVO selectById(String managerId) {
		return sqlSession.selectOne("once.manager.dao.ManagerDAO.selectOneManager", managerId);
	}
}
