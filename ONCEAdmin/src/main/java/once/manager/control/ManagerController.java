package once.manager.control;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import once.customer.service.CustomerService;
import once.customer.vo.CustomerVO;
import once.manager.service.ManagerService;
import once.manager.vo.ManagerVO;
import once.notice.service.NoticeService;
import once.notice.vo.NoticeVO;
import once.order.service.OrderService;
import once.order.vo.OrderVO;
import once.store.vo.StoreVO;
import once.warehouse.service.WarehouseService;
import once.warehouse.vo.WarehouseVO;

@SessionAttributes("loginVO")
@Controller
public class ManagerController {

	@Autowired
	private ManagerService service;
	
	@Autowired
	private NoticeService nService;
	
	@Autowired
	private WarehouseService wService;
	
	@Autowired
	private OrderService oService;
	
	@Autowired
	private CustomerService cService;
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public ModelAndView login(@RequestParam("id")String id, @RequestParam("password")String password, Model model, HttpServletRequest request) {
		
		ManagerVO manager = new ManagerVO();
		manager.setManagerId(id);
		manager.setPassword(password);
		
		ModelAndView mav = new ModelAndView();
		
		ManagerVO loginVO = service.login(manager);
				
		if(loginVO==null) {
			mav.addObject("message", "Please check your ID or Password");
			mav.setViewName("login/loginFail");
			
		}else {
      mav.addObject("loginVO", loginVO);
      
			if(loginVO.getType().equals("admin")) {
				
				// 현재 페이지 번호 저장 변수
				int pageNo = 1;
				if (request.getParameter("pageNo") != null) {
					// 페이지 파라미터가 있는 경우 현재 페이지 번호를 설정
					pageNo = Integer.parseInt(request.getParameter("pageNo"));
				} 
				// 한페이지에 보여질 목록 수
				int listSize = 10;
				
				// 전체 게시글 카운트
				int totalCount = nService.selectAllNotice().size();

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
				List<NoticeVO> list = nService.selectPage(page);
	
        mav.addObject("list", list);
				mav.setViewName("admin/notice/list");
				
			}else if(loginVO.getType().matches(".*info.*")) {			
				mav.setViewName("redirect:/info/addItem");

			}else if(loginVO.getType().matches(".*store.*")) {
				mav.addObject("storeName", service.selectById(id).getStoreName());
				mav.setViewName("storeManager/itemManage/register");
				
			}else {
				mav.addObject("message", "type이 이상합니다");
				mav.setViewName("login/loginFail");
			}
		}
		return mav;
	}
	
	//패스워드 체크 페이지
	@RequestMapping(value = "/manager/check", method = RequestMethod.GET)
	public String checkForm(@ModelAttribute("loginVO") ManagerVO manager, Model model) {
		String type = service.checkType((String)manager.getManagerId());
		
		model.addAttribute("type", type);
		return "manager/check";
	}

	//패스워드 체크 처리
	@RequestMapping(value = "/manager/check", method = RequestMethod.POST)
	public String check(@ModelAttribute("loginVO") ManagerVO manager, Model model) {
		String managerId = manager.getManagerId();
		boolean result = service.checkPassword(managerId, manager.getPassword());
		if(result == false) {
			model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
			return "manager/checkProcess";
		}
		
		//회원 정보 상세 페이지
		service.selectById(managerId);
		StoreVO store = service.selectByNo(manager.getStoreNo());
		
		model.addAttribute("managerVO", manager);
		model.addAttribute("storeVO", store);
		
		return "manager/detail";
	}
	
	//회원 정보 수정 처리
	@RequestMapping(value = "/manager/detail/{managerId}", method = RequestMethod.GET)
	public String modify(@PathVariable String managerId, @ModelAttribute @Valid ManagerVO manager, Model model) {
		
		service.modifyManager(manager.getManagerId(), manager.getPassword(), manager.getTelephone());
		
		model.addAttribute("managerVO", manager);
		model.addAttribute("message", "회원 정보 수정이 성공적으로 완료되었습니다.");
		
		return "manager/modifyProcess";
	}
	
	//매니저 관리 조회
	@RequestMapping(value="/manager/list")
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
		int totalCount = service.selectAll().size();
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
		List<ManagerVO> managerList = service.selectPage(page);
	
		List<StoreVO> storeList = new ArrayList<>();
		
		ModelAndView mav = new ModelAndView();
		String DiffNo = null; // 기존에 없던 새로운 storeNo
		String ExNo = null; // 비교 기준 storeNo
		int count;

		
		for(int i=0; i<=managerList.size()-1; i++) {
			
			count=0; //storeNo에 해당하는 storeName이 존재하는 것을 비교하기 위한 count
			
			ExNo = managerList.get(i).getStoreNo(); //ExNo : 비교 기준 storeNo
			
			if(i==0) {
				storeList.add(service.selectByNo(ExNo));
			}else {
				for(int j=0; j<=i-1; j++) {
					if(ExNo.equals(managerList.get(j).getStoreNo())) //기존 storeList에 추가된 storeNo가 존재하는 경우
						++count;
					else //기존 storeList에 추가된 storeNo가 없을 경우
						DiffNo = ExNo;   
				}
				if(count==0)
					storeList.add(service.selectByNo(DiffNo)); //새로운  storeNo에 해당하는 storeVO객체를 List에 추가
			}
		}
		
		mav.addObject("managerList", managerList);
		mav.addObject("storeList", storeList);
		
		mav.setViewName("admin/manager/list");
		
		return mav;
	}
	
	//매니저 삭제
	@RequestMapping(value="/manager/list", method=RequestMethod.DELETE)
	public String delete(HttpServletRequest request) {
		
		String [] staffNos = request.getParameterValues("managerId");
		
		for(int i=0; i<staffNos.length; i++) {
			service.delete(staffNos[i]);
		}
		
		return "redirect:/manager/list";
	}
	
	//매니저 정보 수정
	@RequestMapping(value = "/manager/modify/{managerId}", method = RequestMethod.GET)
	public ModelAndView modify(@PathVariable String managerId) {
	
		ManagerVO manager = service.selectById(managerId);
		StoreVO store = service.selectByNo(manager.getStoreNo());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("managerVO", manager);
		
		mav.addObject("storeVO", store);
		mav.setViewName("admin/manager/modify");
		
		return mav;
	}
	
	//매니저 정보 수정 완료 
	@RequestMapping(value ="/manager/update/{managerId}", method=RequestMethod.PUT )
	public String update(@PathVariable String managerId, @ModelAttribute @Valid ManagerVO manager) {
		
		service.update(manager.getManagerId(), manager.getTelephone());
		
		return "redirect:/manager/list";
	}
	
	//매니저 추가
	@RequestMapping(value="/manager/add", method=RequestMethod.GET )
	@ResponseBody
	public ManagerVO addManager(@RequestParam(value="managerId") String managerId, @RequestParam(value="password") String password, @RequestParam(value="name") String name, @RequestParam(value="telephone") String telephone,@RequestParam(value="type") String type,@RequestParam(value="storeNo") String storeNo) {

		ManagerVO manager = new ManagerVO();
		
		manager.setManagerId(managerId);
		manager.setPassword(password);
		manager.setTelephone(telephone);
		manager.setType(type);
		manager.setName(name);
		manager.setStoreNo(storeNo);
		
		service.add(manager);
		
		//추가된 매니저에 대한 정보 조회(staffNo, date)
		ManagerVO managerAll = service.selectById(managerId);
		
		manager.setStaffNo(managerAll.getStaffNo());
		manager.setDate(managerAll.getDate());
		
		//추가된 매니저의  storeNo에 대한 storeName
		manager.setStoreName(service.selectByNo(storeNo).getStoreName());		
		
		return manager;
		
	}
	
	//매니저 검색
	@RequestMapping(value="/manager/search", method=RequestMethod.POST )
	@ResponseBody
	public List<ManagerVO> searchManager(@RequestParam(value="searchType") String searchType, @RequestParam(value="searchText") String searchText) {

		String search;
		ManagerVO manager = new ManagerVO();
		List<ManagerVO> managerVOList = new ArrayList<>();
				
		try {
			search = URLDecoder.decode(searchText, "UTF-8"); // 한글 깨짐 현상 방지
			
			if(searchType.equals("name")) 
				manager.setName(search);
			else if(searchType.equals("managerId"))
				manager.setManagerId(search);
			else
				manager.setStoreName(search);
					
			managerVOList = service.search(manager);
			
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		
		return managerVOList;
	}
	
	//ID 중복 체크
	@RequestMapping(value="/manager/checkId", method = RequestMethod.GET)
	@ResponseBody
	public boolean checkId(@RequestParam(value="managerId") String managerId) {
		
		return service.checkId(managerId);
	}
	//-------------------------------------------------------------------------------------------------------------------------------	
	//인포 스태프 리스트
	@RequestMapping(value="/info/staffList")
	public ModelAndView infoStaffList(HttpServletRequest request) {
		
		int pageNo = 1;
		if (request.getParameter("pageNo") != null) {

			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		} 

		int listSize = 10;
		int totalCount = service.selectInfoStaff().size();
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
		List<ManagerVO> staffList = service.selectInfoStaffPage(page);
	
		List<StoreVO> storeList = new ArrayList<>();
		
		ModelAndView mav = new ModelAndView();
		String DiffNo = null;
		String ExNo = null;
		int count;

		
		for(int i=0; i<=staffList.size()-1; i++) {
			
			count=0;
			
			ExNo = staffList.get(i).getStoreNo();
			
			if(i==0) {
				storeList.add(service.selectByNo(ExNo));
			}else {
				for(int j=0; j<=i-1; j++) {
					if(ExNo.equals(staffList.get(j).getStoreNo()))
						++count;
					else
						DiffNo = ExNo;   
				}
				if(count==0)
					storeList.add(service.selectByNo(DiffNo));
			}
		}
		
		mav.addObject("staffList", staffList);
		mav.addObject("storeList", storeList);
		
		mav.setViewName("infoManager/staff/list");
		
		return mav;
	}
	
	//인포 스태프 검색
	@RequestMapping(value="/info/searchStaff", method=RequestMethod.POST )
	@ResponseBody
	public List<ManagerVO> searchInfoStaff(@RequestParam(value="searchType") String searchType, @RequestParam(value="searchText") String searchText) {

		String search;
		ManagerVO manager = new ManagerVO();
		List<ManagerVO> managerList = new ArrayList<>();
				
		try {
			search = URLDecoder.decode(searchText, "UTF-8");
			
			if(searchType.equals("name")) 
				manager.setName(search);
			else if(searchType.equals("managerId"))
				manager.setManagerId(search);
			else
				manager.setStoreName(search);
					
			managerList = service.searchInfoStaff(manager);
			
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		
		return managerList;
	}
	
	//인포 스태프 삭제
	@RequestMapping(value="/info/staffList", method=RequestMethod.DELETE)
	public String deleteInfoStaff(HttpServletRequest request) {
		
		String [] staffNos = request.getParameterValues("managerId");
		
		for(int i=0; i<staffNos.length; i++) {
			service.delete(staffNos[i]);
		}
		
		return "redirect:/info/staffList";
	}
	// ==========================================================================================================
	// ==========================================================================================================
	// ==========================================================================================================
	//매장 직원 관리 조회
		@RequestMapping(value="/staffManage/list")
		public ModelAndView storeStaffList(HttpServletRequest request, HttpSession session) {
			// 로그인한 manager테이블 정보 알아냄
			ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
			
			// 현재 페이지 번호 저장 변수
			int pageNo = 1;
			if (request.getParameter("pageNo") != null) {
				// 페이지 파라미터가 있는 경우 현재 페이지 번호를 설정
				pageNo = Integer.parseInt(request.getParameter("pageNo"));
			} 
			// 한페이지에 보여질 목록 수
			int listSize = 10;
			
			// 전체 게시글 카운트
			int totalCount = service.selectByStore(loginVO.getStoreNo()).size();
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
			List<Object> page = new ArrayList<>();
			page.add( (pageNo - 1) * listSize );
			page.add( listSize );
			page.add( loginVO.getStoreNo());
			List<ManagerVO> managerList = service.selectByStorePage(page);
		
			List<StoreVO> storeList = new ArrayList<>();
			
			ModelAndView mav = new ModelAndView();
			String DiffNo = null; // 기존에 없던 새로운 storeNo
			String ExNo = null; // 비교 기준 storeNo
			int count;
			
			for(int i=0; i<=managerList.size()-1; i++) {
				
				count=0; //storeNo에 해당하는 storeName이 존재하는 것을 비교하기 위한 count
				
				ExNo = managerList.get(i).getStoreNo(); //ExNo : 비교 기준 storeNo
				
				if(i==0) {
					storeList.add(service.selectByNo(ExNo));
				}else {
					for(int j=0; j<=i-1; j++) {
						if(ExNo.equals(managerList.get(j).getStoreNo())) //기존 storeList에 추가된 storeNo가 존재하는 경우
							++count;
						else //기존 storeList에 추가된 storeNo가 없을 경우
							DiffNo = ExNo;   
					}
					if(count==0)
						storeList.add(service.selectByNo(DiffNo)); //새로운  storeNo에 해당하는 storeVO객체를 List에 추가
				}
			}
			mav.addObject("storeName", service.selectByNo(loginVO.getStoreNo()).getStoreName());
			mav.addObject("storeNo", service.selectByNo(loginVO.getStoreNo()).getStoreNo());
			mav.addObject("managerList", managerList);
			mav.addObject("storeList", storeList);
			
			mav.setViewName("storeManager/staffManage/list");
			
			return mav;
		}
		//매장 직원 삭제
		@RequestMapping(value="/staffManage/list", method=RequestMethod.DELETE)
		public String deleteStoreStaff(HttpServletRequest request) {
			
			String [] staffNos = request.getParameterValues("managerId");
			
			for(int i=0; i<staffNos.length; i++) {
				service.delete(staffNos[i]);
			}
			
			return "redirect:/staffManage/list";
		}
		//매장 직원 정보 수정
		@RequestMapping(value = "/staffManage/modify/{managerId}", method = RequestMethod.GET)
		public ModelAndView modifyStoreStaff(@PathVariable String managerId) {
			
			ManagerVO manager = service.selectById(managerId);
			StoreVO store = service.selectByNo(manager.getStoreNo());
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("managerVO", manager);
			
			mav.addObject("storeVO", store);
			mav.setViewName("storeManager/staffManage/modify");
			
			return mav;
		}
		//매장 직원 정보 수정 완료 
		@RequestMapping(value ="/staffManage/update/{managerId}", method=RequestMethod.PUT )
		public String updateStoreStaff(@PathVariable String managerId, @ModelAttribute @Valid ManagerVO manager) {
			
			service.update(manager.getManagerId(), manager.getTelephone());
			
			return "redirect:/staffManage/list";
		}
		//매장 직원 추가
		@RequestMapping(value="/staffManage/add1", method=RequestMethod.GET )
		@ResponseBody
		public ManagerVO addStoreStaff(@RequestParam(value="managerId") String managerId, @RequestParam(value="password") String password, @RequestParam(value="name") String name, @RequestParam(value="telephone") String telephone,@RequestParam(value="type") String type,@RequestParam(value="storeNo") String storeNo) {
			ManagerVO manager = new ManagerVO();
			
			manager.setManagerId(managerId);
			manager.setPassword(password);
			manager.setTelephone(telephone);
			manager.setType(type);
			manager.setName(name);
			manager.setStoreNo(storeNo);
			
			service.add1(manager);
			
			//추가된 매니저에 대한 정보 조회(staffNo, date)
			ManagerVO managerAll = service.selectById(managerId);
			
			manager.setStaffNo(managerAll.getStaffNo());
			manager.setDate(managerAll.getDate());
			
			//추가된 매니저의  storeNo에 대한 storeName
			manager.setStoreName(service.selectByNo(storeNo).getStoreName());		
			
			return manager;
		}
		//매장 직원 검색
		@RequestMapping(value="/staffManage/search", method=RequestMethod.POST )
		@ResponseBody
		public List<ManagerVO> searchStoreStaff(@RequestParam(value="searchType") String searchType, @RequestParam(value="searchText") String searchText) {

			String search;
			ManagerVO manager = new ManagerVO();
			List<ManagerVO> managerVOList = new ArrayList<>();
					
			try {
				search = URLDecoder.decode(searchText, "UTF-8"); // 한글 깨짐 현상 방지
				
				if(searchType.equals("name")) 
					manager.setName(search);
				else if(searchType.equals("managerId"))
					manager.setManagerId(search);
				else
					manager.setStoreName(search);
						
				managerVOList = service.searchByStore(manager);
				
			} catch (UnsupportedEncodingException e) {
				
				e.printStackTrace();
			}
			
			return managerVOList;
		}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	//물품 추가
	@RequestMapping("/info/addItem")
	public ModelAndView infoAddItem(ModelAndView mav, HttpSession session) {
		ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
		List<WarehouseVO> warehouseList = wService.selectAllWarehouse(loginVO.getStoreNo().substring(4));
		
		List<OrderVO> orderList = oService.selectAllOrder(loginVO.getStoreNo().substring(4));
		
		List<Map<String, Object>> memNoList = new ArrayList<>();
		
		CustomerVO customerVO;
		for (int i = 0; i < orderList.size(); i++) {
			if(i==0) {
				Map<String, Object> orderIdCount = new HashMap<>();
				customerVO = cService.selectOneCustomer(orderList.get(i).getMemNo());
				orderIdCount.put("id", customerVO.getId());
				orderIdCount.put("memNo", orderList.get(i).getMemNo());
				orderIdCount.put("itemCount", 1);
				memNoList.add(orderIdCount);
			} else  {
				for (int j = 0; j < memNoList.size(); j++) {
					int memNo =(int)memNoList.get(j).get("memNo");
					if( memNo == orderList.get(i).getMemNo()  ) {
						memNoList.get(j).put("itemCount", (int)memNoList.get(j).get("itemCount")+1);
						break;
					} else if(j == memNoList.size()-1) {
						Map<String, Object> orderIdCount = new HashMap<>();
						customerVO = cService.selectOneCustomer(orderList.get(i).getMemNo());
						orderIdCount.put("id", customerVO.getId());
						orderIdCount.put("memNo", orderList.get(i).getMemNo());
						orderIdCount.put("itemCount", 1);
						memNoList.add(orderIdCount);
						break;
					}
						
				}
			}
		}
		
		System.out.println(memNoList);
		
		mav.addObject("warehouseList", warehouseList);
		mav.addObject("orderList", orderList);
		mav.addObject("memNoList", memNoList);
		mav.setViewName("infoManager/itemManage/addItem");
		return mav;
	}
	
	//물품 전달
	@RequestMapping("/info/itemDelivery")
	public ModelAndView infoItemDelivery(ModelAndView mav) {
		mav.setViewName("infoManager/itemManage/itemDelivery");
		return mav;
	}
	
	//층에 따른 매장 확인
	@RequestMapping("/manager/storeCheck")
	@ResponseBody
	public List<StoreVO> storeCheck(@RequestParam("floor") String floor){
		
		List<StoreVO> list = new ArrayList<>();
		
		list = service.selectStoreByFloor(floor);
		
		return list;
	}
	
	//층에 따른 info 확인
	@RequestMapping("/manager/infoCheck")
	@ResponseBody
	public List<StoreVO> infoCheck(){
		
		List<StoreVO> list = new ArrayList<>();
		
		list = service.selectInfoByFloor();
				
		return list;
	}
}
