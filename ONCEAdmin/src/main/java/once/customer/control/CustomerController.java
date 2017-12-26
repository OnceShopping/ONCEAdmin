package once.customer.control;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import once.customer.service.CustomerService;
import once.customer.vo.CustomerVO;
import once.manager.vo.ManagerVO;

@RequestMapping("/customer")
@Controller
public class CustomerController {

	@Autowired
	private CustomerService service;
	
	//고객 전체 리스트 조회
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		
		// 현재 페이지 번호 저장 변수
		int pageNo = 1;
		if (request.getParameter("pageNo") != null) {

		// 페이지 파라미터가 있는 경우 현재 페이지 번호를 설정
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		} 

		// 한페이지에 보여질 목록 수
		int listSize = 10;
				
		// 전체 게시글 카운트
		int totalCount = service.selectAllBoard().size();
		
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
				
				
		// 해당 페이지의 게시글 목록
		List<Integer> page = new ArrayList<>();
		page.add( (pageNo - 1) * listSize );
		page.add( listSize );
		List<CustomerVO> customerList = service.selectPage(page);
					
		List<CustomerVO> customerAll = service.selectAllBoard();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/customer/list");
		mav.addObject("customerList", customerList);
		mav.addObject("customerAll", customerAll);
		
		return mav;
	}
	
	//고객 삭제
	@RequestMapping(value="/list", method=RequestMethod.DELETE)
	public String deleteList(HttpServletRequest request) {
	   
	    String [] mem = request.getParameterValues("memNo");
	      
	    int [] memNo = new int[mem.length];
	     
	    for(int i=0; i<mem.length; i++) {
	       memNo[i] = Integer.parseInt(mem[i]);
	       service.deleteBoard(memNo[i]);
	    }
	    return "redirect:/customer/list";
	}
	
	//고객 조회
	@RequestMapping(value="/search", method=RequestMethod.POST)
	@ResponseBody
	public List<CustomerVO> searchList(@RequestParam(value="searchType") String searchType, @RequestParam(value="searchText") String searchText) {
	   		
		String search;
		CustomerVO customer = new CustomerVO();
		List<CustomerVO> customerList = new ArrayList<>();
				
		try {
			search = URLDecoder.decode(searchText, "UTF-8");
			
			if(searchType.equals("name")) 
				customer.setName(search);
			else
				customer.setId(search);
			
			customerList = service.searchBoard(customer);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return customerList;
	}
}
