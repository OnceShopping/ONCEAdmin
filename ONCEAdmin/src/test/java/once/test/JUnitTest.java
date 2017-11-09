package once.test;

import java.util.List;

import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static junit.framework.Assert.assertEquals;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:config/spring/spring-mvc.xml")
public class JUnitTest {
	
	@Autowired
	private DataSource ds;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Test
	public void DB접속테스트() throws Exception {
		System.out.println(ds.getConnection());
		System.out.println(sqlSession);
		System.out.println("출력");
	}
	
	@Ignore
	@Test
	public void 전체게시글조회() {
//		List<BoardVO> list = sqlSession.selectList("kr.co.bit.board.dao.BoardDAO.selectAllBoard");
		
	
	}
}









