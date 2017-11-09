package once.counter.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CounterDAOImpl implements CounterDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
}
