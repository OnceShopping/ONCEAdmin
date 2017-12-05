package once.item.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.item.vo.ItemContentsVO;
import once.item.vo.ItemImgVO;
import once.manager.vo.ManagerVO;

@Repository
public class ItemDAOImpl implements ItemDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//상품 등록을 위한 매장 찾기
	@Override
	public ItemContentsVO findStore(String id) {
		return sqlSession.selectOne("once.item.dao.ItemDAO.findStore", id);
	}
	
	//item 테이블에 상품 등록
	@Override
	public void addItem(ItemContentsVO item) {
		sqlSession.insert("once.item.dao.ItemDAO.addItem", item);
	}
	
	//item 테이블에 detail 등록
	@Override
	public void updateDetail(ItemContentsVO item) {
		sqlSession.update("once.item.dao.ItemDAO.updateDetail", "item");
		
	}
	
	//itemColor, imgTable을 위한 F.K(item 테이블의 num) 찾기
	@Override
	public int findNum() {
		return sqlSession.selectOne("once.item.dao.ItemDAO.findNum");
	}
	
	//itemColor 테이블에 상품 등록
	@Override
	public void addItemColor(ItemContentsVO item) {
		sqlSession.insert("once.item.dao.ItemDAO.addItemColor", item);
	}
	
	//itemDetail 테이블에 상품 등록
	@Override
	public void addItemDetail(ItemContentsVO item) {
		sqlSession.insert("once.item.dao.ItemDAO.addItemDetail", item);	
	}

	//imgTable 테이블에 상품 등록
	@Override
	public void addImage(ItemImgVO itemImg) {
		sqlSession.insert("once.item.dao.ItemDAO.addImage", itemImg);
	}
	
	//매장의 등록된 상품 리스트 출력
	@Override
	public List<ItemContentsVO> selectAll(String storeName) {
		
		List<ItemContentsVO> list = new ArrayList<>();
		
		list = sqlSession.selectList("once.item.dao.ItemDAO.selectAll", storeName);
		
		return list;
	}
	
	//상품 코드 기존 DB에 존재하는지 여부 확인
	@Override
	public boolean checkItemNo(String itemNo) {
		
		boolean check = false;
		
		ItemContentsVO checkObj = new ItemContentsVO();
		
		checkObj = sqlSession.selectOne("once.item.dao.ItemDAO.checkItemNo", itemNo);
		
		if(checkObj != null) //동일한 itemNo가 DB에 존재하는 경우
			check = true;
		else //동일한 itemNo가 DB에 존재하지 않은 경우
			check = false;
			
		return check;
	}
	
	//선택한 size 삭제
	@Override
	public void deleteSize(String size) {
		sqlSession.delete("once.item.dao.ItemDAO.deleteSize", size);
	}
	
	//추가하려는 size가 기존 DB에 존재하는지 여부 확인
	@Override
	public boolean checkSize(ItemContentsVO item) {
		
		boolean check = false;
		
		ItemContentsVO checkObj = new ItemContentsVO();
		
		checkObj = sqlSession.selectOne("once.item.dao.ItemDAO.checkSize", item);
		
		if(checkObj != null) //동일한 size가 DB에 존재하는 경우
			check = true;
		else //동일한 size가 DB에 존재하지 않은 경우
			check = false;
			
		return check;
	}
	
	//item 검색
	@Override
	public List<ItemContentsVO> search(ItemContentsVO item) {
		
		List<ItemContentsVO> list = sqlSession.selectList("once.item.dao.ItemDAO.search", item);
		
		return list;
	}
	
	//item list 페이징
	@Override
	public List<ItemContentsVO> selectPage(List page) {
		
		List<ItemContentsVO> list = sqlSession.selectList("once.manager.dao.ManagerDAO.selectPage", page);
		
		return list;
	}
}
