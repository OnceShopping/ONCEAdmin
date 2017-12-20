package once.item.service;

import java.util.List;
import java.util.Map;

import once.item.vo.ItemContentsVO;
import once.item.vo.ItemDetailVO;
import once.item.vo.ItemImgVO;

public interface ItemService {
	
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
	public void deleteDetail(int detailNo);
	
	//item count 수정을 위해 item 찾기
	public ItemContentsVO findItem(int detailNo);
	
	//item count 수정
	public void updateItem(ItemContentsVO item);
	
	//item 추가 등록과 관련한 item 찾기
	public List<ItemContentsVO> searchItem(String itemNo);
	
	//itemDetail테이블에 삭제한 item에 대한 정보가 존재하는지 확인
	public boolean searchDetail(String itemNo);
	
	//itemColor테이블에서 Item 삭제
	public void deleteColor(String itemNo);
	
	//itemColor애서 삭제할 Item에 대한 num 찾기
	public int searchNum(String itemNo);
	
	//itemColor테이블에서 현재 삭제한 num에 대한 정보가 있는지 여부 확인
	public boolean checkNum(int num);
	
	//itemImg테이블에서 num에 대한 정보 삭제
	public void deleteImg(int num);
	
	//item테이블에서 num에 대한 정보 삭제
	public void deleteItem(int num);
	
	//item 주문 확인을 위해 item 찾기
	public ItemContentsVO getItemInfo(int detailNo);
}
