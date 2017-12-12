package once.item.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.item.dao.ItemDAO;
import once.item.vo.ItemContentsVO;
import once.item.vo.ItemImgVO;

@Service
public class ItemServiceImpl implements ItemService {
	
	@Autowired
	private ItemDAO dao;
		
	//상품 등록을 위한 매장 찾기
	@Override
	public ItemContentsVO findStore(String id) {	
		return dao.findStore(id);
	}
	
	//item 테이블에 상품 등록
	@Override
	public void addItem(ItemContentsVO item) {
		dao.addItem(item);
	}
	
	//item 테이블에 detail 등록
	@Override
	public void updateDetail(ItemContentsVO item) {
		dao.updateDetail(item);
	}
	
	//itemColor, imgTable을 위한 F.K(item 테이블의 num) 찾기
	@Override
	public int findNum() {	
		return dao.findNum();
	}
	
	//itemColor 테이블에 상품 등록
	@Override
	public void addItemColor(ItemContentsVO item) {
		dao.addItemColor(item);
	}
	
	//itemDetail 테이블에 상품 등록
	@Override
	public void addItemDetail(ItemContentsVO item) {
		dao.addItemDetail(item);
	}
	
	//imgTable 테이블에 상품 등록
	@Override
	public void addImage(ItemImgVO itemImg) {
		dao.addImage(itemImg);
	}
	
	//매장의 등록된 상품 리스트 출력
	@Override
	public List<ItemContentsVO> selectAll(String storeName) {
		List<ItemContentsVO> list = dao.selectAll(storeName);
		return list;
	}
	
	//상품 코드 기존 DB에 존재하는지 여부 확인	
	@Override
	public boolean checkItemNo(String itemNo) {		
		return dao.checkItemNo(itemNo);
	}
	
	//선택한 size 삭제
	@Override
	public void deleteSize(String size) {
		dao.deleteSize(size);
	}
	
	//추가하려는 size가 기존 DB에 존재하는지 여부 확인
	@Override
	public boolean checkSize(ItemContentsVO item) {
		return dao.checkSize(item);
	}
	
	//item 검색
	@Override
	public List<ItemContentsVO> search(ItemContentsVO item) {
		return dao.search(item);
	}
	
	//itemList 페이징
	@Override
	public List<ItemContentsVO> selectPage(List page) {
		return dao.selectPage(page);
	}
}
