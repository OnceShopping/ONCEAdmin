package once.item.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.boardQA.vo.BoardQAVO;
import once.item.vo.ItemContentsVO;
import once.item.vo.ItemDetailVO;
import once.item.vo.ItemImgVO;

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
		sqlSession.update("once.item.dao.ItemDAO.updateDetail", item);
		
	}
	
	//itemColor, imgTable을 위한 F.K(item 테이블의 num) 찾기
	@Override
	public int findNum() {
		
		String StringNum = sqlSession.selectOne("once.item.dao.ItemDAO.findNum");
		int num=0;		
		
		if(StringNum == null) {
			num = 1;
		}else {
			num = Integer.parseInt(StringNum);
			num += 1;
		}
					
		return num; 		
	}
	
	//itemColor 테이블에 상품 등록
	@Override
	public void addItemColor(ItemContentsVO item) {
		sqlSession.insert("once.item.dao.ItemDAO.addItemColor", item);
	}
	
	//itemDetail 테이블에 상품 등록
	@Override
	public void addItemDetail(ItemDetailVO item) {
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
		
		List<ItemContentsVO> checkObj = new ArrayList<>();
		
		checkObj = sqlSession.selectList("once.item.dao.ItemDAO.checkItemNo", itemNo);
		
		if(checkObj.size()!=0) //동일한 itemNo가 DB에 존재하는 경우
			check = true;
		else //동일한 itemNo가 DB에 존재하지 않은 경우
			check = false;
			
		return check;
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
	
	//itemList 페이징
	@Override
	public List<ItemContentsVO> selectPage(Map<String, Object> ItemContentsVOMap) {
		
		List<ItemContentsVO> list = sqlSession.selectList("once.item.dao.ItemDAO.selectPage", ItemContentsVOMap);
		
		return list;
	}
	
	//item 삭제
	@Override
	public void deleteDetail(int detailNo) {
		sqlSession.delete("once.item.dao.ItemDAO.deleteDetail", detailNo);
	}
	
	//item count 수정을 위해 item 찾기
	@Override
	public ItemContentsVO findItem(int detailNo) {
		ItemContentsVO item = sqlSession.selectOne("once.item.dao.ItemDAO.findItem", detailNo);
		return item;
	}
	
	//item 수량 수정
	@Override
	public void updateItem(ItemContentsVO item) {
		sqlSession.update("once.item.dao.ItemDAO.updateItem", item);
	}
	
	//item 추가 등록과 관련한 item 찾기
	@Override
	public List<ItemContentsVO> searchItem(String itemNo) {
		List<ItemContentsVO> list = sqlSession.selectList("once.item.dao.ItemDAO.searchItem", itemNo);
		return list;
	}
	
	//itemDetail테이블에 삭제한 item에 대한 정보가 존재하는지 확인
	@Override
	public boolean searchDetail(String itemNo) {
				
		List<ItemContentsVO> list = sqlSession.selectList("once.item.dao.ItemDAO.searchDetail", itemNo);
		
		if(list.size() == 0) //itemDetail테이블에 데이터가 모두 삭제된 경우 
			return true;
		else 
			return false;
	}
	
	//itemColor테이블에서 Item 삭제
	@Override
	public void deleteColor(String itemNo) {
		sqlSession.selectList("once.item.dao.ItemDAO.deleteColor", itemNo);
	}
	
	//itemColor애서 삭제할 Item에 대한 num 찾기
	@Override
	public int searchNum(String itemNo) {
		return sqlSession.selectOne("once.item.dao.ItemDAO.searchNum", itemNo);
	}
	
	//itemColor테이블에서 현재 삭제한 num에 대한 정보가 있는지 여부 확인
	@Override
	public boolean checkNum(int num) {
		
		List<ItemContentsVO> list = sqlSession.selectList("once.item.dao.ItemDAO.checkNum", num);
		
		if(list.size() == 0) //itemColor테이블에 해당 num과 관련된 데이터가 존재하지 않을 경우 
			return true;
		else 
			return false;
		
	}
	
	//itemImg테이블에서 num에 대한 정보 삭제
	@Override
	public void deleteImg(int num) {
		sqlSession.delete("once.item.dao.ItemDAO.deleteImg", num);
	}
	
	//item테이블에서 num에 대한 정보 삭제
	@Override
	public void deleteItem(int num) {
		sqlSession.delete("once.item.dao.ItemDAO.deleteItem", num);
	}
}
