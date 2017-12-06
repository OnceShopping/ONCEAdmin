package once.item.control;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		itemVO.setPrice(Integer.parseInt(mRequest.getParameter("price")));
		itemVO.setItemCategory1(mRequest.getParameter("itemCategory1"));
		itemVO.setItemCategory2(mRequest.getParameter("itemCategory2"));
		itemVO.setItemCategory3(mRequest.getParameter("itemCategory3"));		
	
	
		int num = service.findNum() + 1; //item을 추가하지 않은 상황에서는 num은 +1
		
		itemVO.setColor(mRequest.getParameter("color"));
		itemVO.setItemNo(mRequest.getParameter("itemNo"));
		itemVO.setNum(num);
		
		itemImg = new ItemImgVO(); //이미지 등록을 위한 객체
		
	    String uploadDir = servletContext.getRealPath("/upload/");
		    
	    Iterator<String> iter = mRequest.getFileNames();
	    
	    while(iter.hasNext()) {
	         
	    String formFileName = iter.next();
	    
	    MultipartFile mFile = mRequest.getFile(formFileName);
	         
	    // 원본 파일명
	    String oriFileName = mFile.getOriginalFilename();
	    System.out.println("원본 파일명 : " + oriFileName);    
	    
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
		        String saveFileName = "mlec-" + UUID.randomUUID().toString() + ext;
		         
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

		String id = mRequest.getParameter("id");
	
		service.addItem(itemVO); //Item 테이블에 데이터 추가
		service.addItemColor(itemVO); //ItemColor 테이블에 데이터 추가
		
		//size와 count 값 가져옴
		String [] size = mRequest.getParameterValues("size");
		String [] counts = mRequest.getParameterValues("count");
		
		//ItemDetail 테이블에 데이터 추가
		for(int i=0; i<size.length; i++) {
			ItemDetailVO itemDetail = new ItemDetailVO();
			
			itemDetail.setSize(size[i]);
			
			int count = Integer.parseInt(counts[i]);
			itemDetail.setCount(count);
			
			itemDetail.setItemNo(itemVO.getItemNo());
		
			service.addItemDetail(itemDetail);
		}
		
		//Item 테이블에 추가할 detail 값을 가져온 후 ItemDetail테이블을 update 함
		String detail = mRequest.getParameter("detail");

		if(detail!=null) {
			itemVO.setDetail(detail);
		}else {
			itemVO.setDetail("상품 상세 정보가 없습니다.");
		}	
		service.updateDetail(itemVO);
	
		//ImageTable 테이블에 registerItem 함수에서 추가한 이미지 정보를 추가
		service.addImage(itemImg);
		
		// 실행되는 웹어플리케이션의 실제 경로 가져오기
	    String uploadDir = servletContext.getRealPath("/upload/");
	    System.out.println(uploadDir);
    
	    Iterator<String> iter = mRequest.getFileNames();
	    
	    while(iter.hasNext()) {
	         
	    String formFileName = iter.next();
	    
	    // 폼에서 파일을 선택하지 않아도 객체 생성됨
	    MultipartFile mFile = mRequest.getFile(formFileName);
	         
	    // 원본 파일명
	    String oriFileName = mFile.getOriginalFilename();
	    System.out.println("원본 파일명 : " + oriFileName);    
	    
		    if(oriFileName != null && !oriFileName.equals("")) {
		         
		    	ItemImgVO itemImgs = new ItemImgVO();
		    	
		        String ext = "";
		        
		        int index = oriFileName.lastIndexOf(".");
		        if (index != -1) {
		            ext = oriFileName.substring(index);
		        }
		            
		        long fileSize = mFile.getSize();
		               
		        String saveFileName = "mlec-" + UUID.randomUUID().toString() + ext;
		         
		        mFile.transferTo(new File(uploadDir + saveFileName));
		        
		        itemImgs.setImgSaveName(saveFileName);
		        itemImgs.setImageSize((int)fileSize);
		        itemImgs.setImgOriName(oriFileName);
		        itemImgs.setNum(itemVO.getNum());
		        
		        service.addImage(itemImgs);
		    }
	    }

	    ModelAndView mav = new ModelAndView("storeManager/itemManage/again");
		mav.addObject("storeName", service.findStore(id).getStoreName()); 
	    
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
		
		String storeName = service.findStore(manager.getManagerId()).getStoreName();
		
		int pageNo = 1;
		if (request.getParameter("pageNo") != null) {
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		} 

		int listSize = 10;
		
		int totalCount = service.selectAll(storeName).size();

		int lastPage = (totalCount % listSize == 0) ? totalCount / listSize 
				                                    : totalCount / listSize + 1;	
		request.setAttribute("pageNo"  , pageNo);
		request.setAttribute("lastPage", lastPage);
		
		int tabSize  = 5;
		 
		int currTab   = (pageNo  -1) / tabSize + 1;
		int beginPage = (currTab -1) * tabSize + 1;
		int endPage   = (currTab * tabSize < lastPage) ? currTab * tabSize 
				                                       : lastPage;
		
		request.setAttribute("beginPage", beginPage);
		request.setAttribute("endPage"  , endPage);
		
		
		List<Integer> page = new ArrayList<>();
		page.add( (pageNo - 1) * listSize );
		page.add( listSize );
		List<ItemContentsVO> itemList = service.selectPage(page);
	
		
		ModelAndView mav = new ModelAndView();
	
		mav.addObject("itemList", itemList);
		mav.addObject("storeName", storeName);
		
		mav.setViewName("storeManager/itemManage/list");
		
		return mav;

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
}
