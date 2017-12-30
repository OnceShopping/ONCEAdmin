package once.item.control;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import once.item.service.ItemService;
import once.item.vo.ItemContentsVO;
import once.item.vo.ItemDetailVO;
import once.item.vo.ItemImgVO;
import once.manager.vo.ManagerVO;

@Controller
@RequestMapping(value = "/item")
public class ItemController {

	@Autowired
	private ItemService service;
	
	@Autowired
	private ServletContext servletContext;
	
	private ItemContentsVO itemVO;
	private ItemImgVO itemImg;
	private String category = null;
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public ModelAndView register(HttpSession session) {
			
		ManagerVO manager = (ManagerVO)session.getAttribute("loginVO");
		
		String storeName = service.findStore(manager.getManagerId()).getStoreName(); 		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("storeName", storeName);
		
		mav.setViewName("storeManager/itemManage/register"); 
		 
		return mav;
	}
	
	//카테고리, 상품 등록
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public ModelAndView registerItem(MultipartHttpServletRequest mRequest) throws Exception {
				
		itemVO = new ItemContentsVO();
		
		String id = mRequest.getParameter("id");
		itemVO = service.findStore(id); //storeName, storeNo 설정
				
		itemVO.setItemName(mRequest.getParameter("itemName"));
		itemVO.setItemCategory1(mRequest.getParameter("itemCategory1"));
		itemVO.setItemCategory2(mRequest.getParameter("itemCategory2"));
		itemVO.setItemCategory3(mRequest.getParameter("itemCategory3"));		
		
		//,로 작성된 가격을 Int형식으로 변경
		String oriPrice=mRequest.getParameter("price");
		String [] array;
		String intPrice="";
		
		array = oriPrice.split(",");
		
		for(int i=0; i<array.length; i++) {
			intPrice+=array[i];
		}
		
		itemVO.setPrice(Integer.parseInt(intPrice));
		
		int num = service.findNum(); //item을 추가하지 않은 상황
		
		itemVO.setColor(mRequest.getParameter("color"));
		itemVO.setItemNo(mRequest.getParameter("itemNo"));
		itemVO.setNum(num);
		
		itemImg = new ItemImgVO(); //이미지 등록을 위한 객체
		
	    String uploadDir = "C:\\Once\\image\\";
		    
	    Iterator<String> iter = mRequest.getFileNames();
	    
	    while(iter.hasNext()) {
	         
	    String formFileName = iter.next();
	    
	    MultipartFile mFile = mRequest.getFile(formFileName);
	         
	    // 원본 파일명
	    String oriFileName = mFile.getOriginalFilename(); 
	    
		    if(oriFileName != null && !oriFileName.equals("")) {
		    	
		    	// 확장자 처리
		        String ext = "";
		        // 뒤쪽에 있는 . 의 위치 
		        int index = oriFileName.lastIndexOf(".");
		        if (index != -1) {
		        	// 파일명에서 확장자명(.포함)을 추출
		            ext = oriFileName.substring(index);
		        }
		            
		        // 파일 사이즈
		        long fileSize = mFile.getSize();
			            
		        // 고유한 파일명 만들기   
		        String saveFileName = "ONCE-" + UUID.randomUUID().toString() + ext;
		         
		        // 임시저장된 파일을 원하는 경로에 저장
		        mFile.transferTo(new File(uploadDir + saveFileName));
		        
		        itemImg.setImgSaveName(saveFileName);
		        itemImg.setImageSize((int)fileSize);
		        itemImg.setImgOriName(oriFileName);
		        itemImg.setNum(num);
		    }
	    }
		    
	    ModelAndView mav = new ModelAndView("storeManager/itemManage/registerDetail");
	    mav.addObject("item", itemVO);
	    mav.addObject("itemImg", itemImg);   
	    
		return mav;
	}

	// 상품 이미지, 상품 상세 정보 등록
	@RequestMapping(value="/registerDetail", method=RequestMethod.POST)
	public ModelAndView registerItemDetail(MultipartHttpServletRequest mRequest) throws Exception {
			
		service.addItem(itemVO); //Item 테이블에 데이터 추가
		service.addItemColor(itemVO); //ItemColor 테이블에 데이터 추가
		
		int num = itemVO.getNum();
				
		//size와 count 값 가져옴
		String [] size = mRequest.getParameterValues("size");
		String [] counts = mRequest.getParameterValues("count");
		
		//ItemDetail 테이블에 데이터 추가
		for(int i=0; i<size.length; i++) {
			ItemDetailVO itemDetail = new ItemDetailVO();
			
			itemDetail.setSize(size[i]);
			int itemCount = Integer.parseInt(counts[i]);
			
			itemDetail.setCount(itemCount);
			itemDetail.setItemNo(itemVO.getItemNo());
		
			service.addItemDetail(itemDetail);
		}
		
		//Item 테이블에 추가할 detail 값을 가져온 후 ItemDetail테이블을 update 함
		String detail = mRequest.getParameter("detail").replace("\r\n", "<br>");
			
		if(detail!=null) {
			itemVO.setDetail(detail);
		}else {
			itemVO.setDetail("상품 상세 정보가 없습니다.");
		}	
		service.updateDetail(itemVO);
	
		//ImageTable 테이블에 registerItem 함수에서 추가한 이미지 정보를 추가
		service.addImage(itemImg);
		
		// 실행되는 웹어플리케이션의 실제 경로 가져오기
	    String uploadDir = "C:\\Once\\image\\";
    
	    Iterator<String> iter = mRequest.getFileNames();
	    
	    while(iter.hasNext()) {
	    
	    ItemImgVO itemImgs = new ItemImgVO();
	    	
	    String formFileName = iter.next();
	    
	    // 폼에서 파일을 선택하지 않아도 객체 생성됨
	    MultipartFile mFile = mRequest.getFile(formFileName);
	         
	    // 원본 파일명
	    String oriFileName = mFile.getOriginalFilename();
	    
		    if(oriFileName != null && !oriFileName.equals("")) {	    	
		    	
		    	 // 확장자 처리
		        String ext = "";
		        
		        // 뒤쪽에 있는 . 의 위치
		        int index = oriFileName.lastIndexOf(".");
		      
		        
		        if (index != -1) {
		            ext = oriFileName.substring(index); // 파일명에서 확장자명(.포함)을 추출
		        }
		            
		        long fileSize = mFile.getSize();
		               
		        String saveFileName = "ONCE-" + UUID.randomUUID().toString() + ext; // 고유한 파일명 만들기  
		        
		        // 임시저장된 파일을 원하는 경로에 저장
		        mFile.transferTo(new File(uploadDir + saveFileName));
		        
		        itemImgs.setImgSaveName(saveFileName);
		        itemImgs.setImageSize((int)fileSize);
		        itemImgs.setImgOriName(oriFileName);
		        itemImgs.setNum(num);
		       
		        service.addImage(itemImgs);
		    }
	    }

	    ModelAndView mav = new ModelAndView("storeManager/itemManage/again");
		mav.addObject("storeName", itemVO.getStoreName()); 
	    
		return mav;
	}
	
	//상품 코드 기존 DB에 존재하는지 여부 확인
	@RequestMapping(value="/checkItem", method=RequestMethod.GET)
	@ResponseBody
	public boolean checkItemNo(@RequestParam(value="itemNo") String itemNo) {	
		return service.checkItemNo(itemNo);
	}
	
	//매장의 등록된 상품 리스트 출력
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public ModelAndView itemList(HttpSession session, HttpServletRequest request) {
					
		ManagerVO manager = (ManagerVO)session.getAttribute("loginVO");
		
		Map<String, Object> ItemContentsVOMap = new HashMap<>();
		
		String storeName = service.findStore(manager.getManagerId()).getStoreName();
		
		ItemContentsVOMap.put("storeName", storeName);
		
		if(category == null)
			ItemContentsVOMap.put("filterType", null);
		else
			ItemContentsVOMap.put("filterType", category);
		

		// 현재 페이지 번호 저장 변수
		int pageNo = 1;
		if (request.getParameter("pageNo") != null) {
			// 페이지 파라미터가 있는 경우 현재 페이지 번호를 설정
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		} 
		// 한페이지에 보여질 목록 수
		int listSize = 15;
		
		ItemContentsVOMap.put("startPage", null);
		ItemContentsVOMap.put("count", null );	
		
		// storeName이 일치하는 전체 게시글 카운트
		int totalCount = service.selectPage(ItemContentsVOMap).size();
		
		ItemContentsVOMap.put("startPage", (pageNo -1 ) * listSize);
		ItemContentsVOMap.put("count", listSize );	
		
		List<ItemContentsVO> itemList = service.selectPage(ItemContentsVOMap);
		
		// 마지막 페이지 구하기
		int lastPage = (totalCount % listSize == 0) ? totalCount / listSize 
				                                    : totalCount / listSize + 1;	

		request.setAttribute("pageNo"  , pageNo);
		request.setAttribute("lastPage", lastPage);


		// ======================================================================
		// 탭 관련 작업 추가 파트
		// ======================================================================
		// 목록에 보여질 탭 사이즈
		int tabSize  = 5;
		// 현재 페이지에 해당하는 탭 위치 
		int currTab   = (pageNo  -1) / tabSize + 1;
		int beginPage = (currTab -1) * tabSize + 1;
		int endPage   = (currTab * tabSize < lastPage) ? currTab * tabSize 
				                                       : lastPage;
		
		request.setAttribute("beginPage", beginPage);
		request.setAttribute("endPage"  , endPage);
		// ======================================================================
	
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("storeName", storeName);
		mav.addObject("itemList", itemList);
		mav.addObject("startPage", (pageNo -1 ) * listSize);
		mav.setViewName("storeManager/itemManage/list");
		
				
		return mav;

	}
	
	//Sorting item
	@RequestMapping(value="/list", method=RequestMethod.POST)
	public String sortItem(HttpServletRequest request){
	
		category = request.getParameter("category");
		
		return "redirect:/item/list";
	}
	
	//item 검색
	@RequestMapping(value="/search", method=RequestMethod.POST)
	@ResponseBody
	public List<ItemContentsVO> searchManager(@RequestParam(value="searchType") String searchType, @RequestParam(value="searchText") String searchText, @RequestParam(value="storeName") String storeName) {

		String search;
		String shop;
		
		ItemContentsVO item = new ItemContentsVO();		
		
		List<ItemContentsVO> itemList = new ArrayList<>();
				
		try {
			search = URLDecoder.decode(searchText, "UTF-8"); // 한글 깨짐 현상 방지
			shop = URLDecoder.decode(storeName, "UTF-8");
			
			if(searchType.equals("itemName")) 
				item.setItemName(search);
			else
				item.setItemNo(search);
					
			item.setStoreName(shop);
			itemList = service.search(item);
			
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		return itemList;
	}
	
	//재고 관리
	@RequestMapping(value="/manage", method=RequestMethod.GET)
	public 	ModelAndView manageItem(HttpSession session, HttpServletRequest request) {
		
		ManagerVO manager = (ManagerVO)session.getAttribute("loginVO");
		String id =  manager.getManagerId();
		String storeName = service.findStore(id).getStoreName();
		
		Map<String, Object> ItemContentsVOMap = new HashMap<>();
		
		ItemContentsVOMap.put("storeName", storeName);
		
		ItemContentsVOMap.put("filterType", null); //category를 선택하는 것이 없음
		

		// 현재 페이지 번호 저장 변수
		int pageNo = 1;
		if (request.getParameter("pageNo") != null) {
			// 페이지 파라미터가 있는 경우 현재 페이지 번호를 설정
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		} 
		// 한페이지에 보여질 목록 수
		int listSize = 15;
		
		ItemContentsVOMap.put("startPage", null);
		ItemContentsVOMap.put("count", null );	
		// storeName이 일치하는 전체 게시글 카운트
		int totalCount = service.selectPage(ItemContentsVOMap).size();
		
		ItemContentsVOMap.put("startPage", (pageNo -1 ) * listSize);
		ItemContentsVOMap.put("count", listSize );	
		
		List<ItemContentsVO> itemList = service.selectPage(ItemContentsVOMap);
		
		// 마지막 페이지 구하기
		int lastPage = (totalCount % listSize == 0) ? totalCount / listSize 
				                                    : totalCount / listSize + 1;	

		request.setAttribute("pageNo"  , pageNo);
		request.setAttribute("lastPage", lastPage);


		// ======================================================================
		// 탭 관련 작업 추가 파트
		// ======================================================================
		// 목록에 보여질 탭 사이즈
		int tabSize  = 5;
		// 현재 페이지에 해당하는 탭 위치 
		int currTab   = (pageNo  -1) / tabSize + 1;
		int beginPage = (currTab -1) * tabSize + 1;
		int endPage   = (currTab * tabSize < lastPage) ? currTab * tabSize 
				                                       : lastPage;
		
		request.setAttribute("beginPage", beginPage);
		request.setAttribute("endPage"  , endPage);
		// ======================================================================
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("itemList", itemList);
		mav.addObject("storeName", storeName);
		mav.addObject("startPage", (pageNo -1 ) * listSize);
		mav.setViewName("storeManager/itemManage/manage");
		
		return mav;
	}
	
	//item 삭제
	@RequestMapping(value="/manage", method=RequestMethod.DELETE)
	public String deleteItem(HttpServletRequest request) {
		
		String [] detailNos = request.getParameterValues("detailNo");
		int [] detailNo = new int[detailNos.length];
		String [] itemNo = new String[detailNos.length];
		
		
		for(int i=0; i<detailNos.length; i++) {
			
			detailNo[i] = Integer.parseInt(detailNos[i]);
			
			//detailNo에 해당하는 itemNo 찾기
			itemNo[i] = (service.findItem(detailNo[i])).getItemNo();
			
			//itemDetail 테이블에서 해당 item 삭제
			service.deleteDetail(detailNo[i]);
			
			//itemDetail테이블에 삭제한 item에 대한 정보가 존재하는지 확인
			boolean check = service.searchDetail(itemNo[i]);
			
			if(check==true) { //itemDetail테이블에 데이터가 모두 삭제된 경우
				
				int num = service.searchNum(itemNo[i]); //itemColor애서 삭제할 Item에 대한 num 찾기
				
				service.deleteColor(itemNo[i]); //itemColor테이블에서 Item 삭제
				
				//itemColor테이블에서 현재 삭제한 num에 대한 정보가 있는지 여부 확인
				boolean checkNum = service.checkNum(num);
				
				if(checkNum==true) {
					service.deleteImg(num); //ImageTable테이블에서 삭제한 item만 존재할 경우 해당 item 정보를 삭제
					service.deleteItem(num); //Item테이블에서 삭제한 item만 존재할 경우  해당 item 정보를  삭제					
				}
			}
			
		}
		
		return "redirect:/item/manage";
	}
	
	//item count 수정을 위해 item 찾기
	@RequestMapping(value="/modify/{detailNo}")
	public ModelAndView modifyItem(@PathVariable(value="detailNo") int detailNo) {
	
		ItemContentsVO item = new ItemContentsVO();
		
		item = service.findItem(detailNo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("item", item);
		mav.setViewName("storeManager/itemManage/modify");
		return mav;
	}
	
	//item 수량 수정
	@RequestMapping(value="/update/{detailNo}", method=RequestMethod.PUT)
	public String updateItem(@PathVariable(value="detailNo") int detailNo, HttpServletRequest request) {
		
		ItemContentsVO item = new ItemContentsVO();
		
		String Scount = request.getParameter("count");
		int count = Integer.parseInt(Scount);
		
		item.setDetailNo(detailNo);
		item.setCount(count);
		
		service.updateItem(item);
		
		return "redirect:/item/manage";
	}
	
	//기존에 존재하는 item 추가 등록
	@RequestMapping(value="/register/{itemNo}")
	public ModelAndView extraItem(@PathVariable(value="itemNo") String itemNo, HttpSession session) {
		
		List<ItemContentsVO> itemList= service.searchItem(itemNo);
		
		
		ItemContentsVO itemOne = null;
		
		//itemName, itemNo, storeName sample 1개를 받기 위함
		for(int i=0; i<1; i++) {
			itemOne = new ItemContentsVO();
			itemOne = itemList.get(i);
		}
		
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("storeManager/itemManage/extraRegister");
		mav.addObject("itemList", itemList);
		mav.addObject("itemOne", itemOne);
		
		
		return mav;
	}
	
	//상품 추가 등록
	@RequestMapping(value="/extraAdd", method=RequestMethod.POST)
	public ModelAndView extraAdd(HttpServletRequest request) {
		
		String storeName = request.getParameter("storeName");
		String itemNo = request.getParameter("itemNo");
		
		//size와 count 값 가져옴
		String [] size = request.getParameterValues("size");
		String [] counts = request.getParameterValues("count");
		
		
		//ItemDetail 테이블에 데이터 추가
		for(int i=0; i<size.length; i++) {
			ItemDetailVO itemDetail = new ItemDetailVO();
			
			itemDetail.setSize(size[i]);
			int itemCount = Integer.parseInt(counts[i]);
			
			itemDetail.setCount(itemCount);
			itemDetail.setItemNo(itemNo);
		
			service.addItemDetail(itemDetail);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("storeManager/itemManage/again");
		mav.addObject("storeName", storeName); 
	    
		return mav;
	}
	
}
