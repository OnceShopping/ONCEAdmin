package once.item.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.item.dao.ItemDAO;
import once.item.vo.ItemContentsVO;
import once.item.vo.ItemDetailVO;
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
	public void addItemDetail(ItemDetailVO item) {
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
	public List<ItemContentsVO> selectPage(Map<String, Object> ItemContentsVOMap) {
		return dao.selectPage(ItemContentsVOMap);
	}
	
	//item 삭제
	@Override
	public void deleteDetail(int detailNo) {
		dao.deleteDetail(detailNo);
	}
	
	//item count 수정을 위해 item 찾기
	@Override
	public ItemContentsVO findItem(int detailNo) {
		return dao.findItem(detailNo);
	}
	
	//item count 수정
	@Override
	public void updateItem(ItemContentsVO item) {
		dao.updateItem(item);
	}
	
	//item 추가 등록과 관련한 item 찾기
	@Override
	public List<ItemContentsVO> searchItem(String itemNo) {
		List<ItemContentsVO> list = dao.searchItem(itemNo);
		return list;
	}
	
	//itemDetail테이블에 삭제한 item에 대한 정보가 존재하는지 확인
	@Override
	public boolean searchDetail(String itemNo) {
		return dao.searchDetail(itemNo);
	}
	
	//itemColor테이블에서 Item 삭제
	@Override
	public void deleteColor(String itemNo) {
		dao.deleteColor(itemNo);
	}
	
	//itemColor애서 삭제할 Item에 대한 num 찾기
	@Override
	public int searchNum(String itemNo) {
		return dao.searchNum(itemNo);
	}
	
	//itemColor테이블에서 현재 삭제한 num에 대한 정보가 있는지 여부 확인
	@Override
	public boolean checkNum(int num) {
		return dao.checkNum(num);
	}
	
	//itemImg테이블에서 num에 대한 정보 삭제
	@Override
	public void deleteImg(int num) {
		dao.deleteImg(num);
	}
	
	//item테이블에서 num에 대한 정보 삭제
	@Override
	public void deleteItem(int num) {
		dao.deleteItem(num);
	}

	//item 주문 확인을 위해 item 찾기
	@Override
	public ItemContentsVO getItemInfo(int detailNo) {
		return dao.getItemInfo(detailNo);
	}
}
