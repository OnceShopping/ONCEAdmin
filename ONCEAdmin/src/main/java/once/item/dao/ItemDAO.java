package once.item.dao;


import java.util.List;
import java.util.Map;

import once.item.vo.ItemContentsVO;
import once.item.vo.ItemDetailVO;
import once.item.vo.ItemImgVO;

public interface ItemDAO {
	
	//상품 등록을 위한 매장 찾기
	public ItemContentsVO findStore(String id);
	
	//item 테이블에 상품 등록
	public void addItem(ItemContentsVO item);
	
	//item 테이블에 detail 등록
	public void updateDetail(ItemContentsVO item);
	
	//itemColor, imgTable을 위한 F.K(item 테이블의 num) 찾기
	public int findNum();
	
	//itemColor 테이블에 상품 등록
	public void addItemColor(ItemContentsVO item);
	
	//itemDetail 테이블에 상품 등록
	public void addItemDetail(ItemDetailVO item);
	
	//imgTable 테이블에 상품 등록
	public void addImage(ItemImgVO itemImg);

	//매장의 등록된 상품 리스트 출력
	public List<ItemContentsVO> selectAll(String storeName);
	
	//상품 코드 기존 DB에 존재하는지 여부 확인
	public boolean checkItemNo(String itemNo);
	
	//추가하려는 size가 기존 DB에 존재하는지 여부 확인
	public boolean checkSize(ItemContentsVO item);
	
	//item 검색
	public List<ItemContentsVO> search(ItemContentsVO item);
	
	//item list 페이징
	public List<ItemContentsVO> selectPage(Map<String, Object> ItemContentsVOMap);
	
	//item 삭제
	public void deleteItem(int detailNo);
	
	//item count 수정을 위해 item 찾기
	public ItemContentsVO findItem(int detailNo);
	
	//item count 수정
	public void updateItem(ItemContentsVO item);
}
