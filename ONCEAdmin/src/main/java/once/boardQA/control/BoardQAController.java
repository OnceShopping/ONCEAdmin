package once.boardQA.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import once.boardQA.service.BoardQAService;
import once.boardQA.vo.BoardQAVO;
import once.manager.service.ManagerService;
import once.manager.vo.ManagerVO;

@RequestMapping("/boardQA")
@Controller
public class BoardQAController {
	@Autowired
	private BoardQAService service;
	
	@Autowired
	private ManagerService mService;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpSession session) {
		
		ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
		
		String type = checkType(loginVO);
		// 현재 페이지 번호 저장 변수
		int pageNo = 1;
		if (request.getParameter("pageNo") != null) {
			// 페이지 파라미터가 있는 경우 현재 페이지 번호를 설정
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		} 
		// 한페이지에 보여질 목록 수
		int listSize = 5;
		
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
//		List<BoardQAVO> BoardList = service.selectPage(page);
		
		Map<String, Object> boardQAMap = new HashMap<>();
		boardQAMap.put("startPage", (pageNo -1 ) * listSize);
		boardQAMap.put("count", listSize );
		
		String date1;
		String date2;
		String selectCategory3;
		//날짜, 카테고리 가져오기  ,
		if( request.getParameter("date1") != ""  ) {
			date1 = request.getParameter("date1");
			boardQAMap.put("date1", date1);
			date2 = request.getParameter("date2");
			boardQAMap.put("date2", date2);
			request.setAttribute("date1", date1);
			request.setAttribute("date2", date2);
		} 
		
		if( request.getParameter("selectCategory3") != "" ) {
			selectCategory3 = request.getParameter("selectCategory3");
			boardQAMap.put("selectCategory3", selectCategory3);
			request.setAttribute("selectCategory3", selectCategory3);
		}

		if( request.getParameter("searchC") != null) {
			//제목, 작성자, 내용 가져오기
			switch (request.getParameter("searchC")) {
			case "t":
				boardQAMap.put("title",request.getParameter("search"));
				break;
			case "w":
				boardQAMap.put("writer",request.getParameter("search"));
				break;
			case "c":
				boardQAMap.put("content",request.getParameter("search"));
				break;
			case "tc":
				boardQAMap.put("title",request.getParameter("search"));
				boardQAMap.put("content",request.getParameter("search"));
				break;
			}
			request.setAttribute("searchC", request.getParameter("searchC"));
			request.setAttribute("search", request.getParameter("search"));
		}
		
		System.out.println(boardQAMap);
		List<BoardQAVO> Searchlist = service.selectSearch(boardQAMap);
		ModelAndView mav = new ModelAndView();
		mav.addObject("BoardList", Searchlist);
		mav.setViewName(type+"/boardQA/list");
		return mav;
	}

	@RequestMapping(value = "/detail/{boardNo}", method = RequestMethod.GET)
	public String selectOne(@PathVariable int boardNo, Model mod, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		BoardQAVO boardQAVO = service.selectOneBoard(boardNo);
		Cookie[] Cookies = request.getCookies(); //모든 쿠키의 값을 가져옴
		System.out.println(Cookies.length);
	for (int i = 0; i < Cookies.length; i++) {
		System.out.println(Cookies[i].getValue());
		if(Cookies[i].getValue().equals("boardQA"+boardNo)) { //쿠키의 noticeNo 페이지값과 들어간 페이지의 noticeNo가 같으면 break
			break;
		} else if (i == Cookies.length - 1 ){ //없으면 쿠키를 생성해서 추가하고 게시물 조회수를 1 늘림
			Cookie noticeCookie = new Cookie("boardQA"+boardNo, "boardQA"+boardNo);
			noticeCookie.setMaxAge(60*60*24); //쿠키기간1일짜리
			response.addCookie(noticeCookie);
			service.addCountBoardQA(boardNo);
		}
	}
		mod.addAttribute("boardQAVO", boardQAVO);
		
		ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
		String type = checkType(loginVO);
		return type + "/boardQA/detail";
	}
	
	@RequestMapping(value = "/write/{boardNo}", method = RequestMethod.GET)
	public String writeForm(Model model, @PathVariable int boardNo, HttpSession session) {
		BoardQAVO boardQAVO = new BoardQAVO();
		
		model.addAttribute("boardQAVO", boardQAVO);
		
		ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
		String type = checkType(loginVO);
		return type + "/boardQA/write";
	}
	
	@RequestMapping(value = "/write/{boardNo}", method = RequestMethod.POST)
	public String write(@Valid BoardQAVO sboardQAVO, HttpSession session) {
		BoardQAVO pBoardQAVO = service.selectOneBoard(sboardQAVO.getBoardNo());
		System.out.println(pBoardQAVO);
		pBoardQAVO.setFamily(pBoardQAVO.getFamily());	//부모글의 family	- 그룹번호
		pBoardQAVO.setParent(pBoardQAVO.getBoardNo());	//부모글의 no	  	- 부모글
		pBoardQAVO.setDepth(pBoardQAVO.getDepth()+1);	//부모글의 +1		- 글 순서
		pBoardQAVO.setIntent(pBoardQAVO.getIntent()+1);	//부모글의 +1 		- 들어쓰기 수준
		
		ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
		pBoardQAVO.setWriter(loginVO.getManagerId());
		String title = sboardQAVO.getTitle();
		String indent="";
		for(int i =0; i<pBoardQAVO.getIntent(); i++) {
			indent += "&nbsp;&nbsp;";
		}
		pBoardQAVO.setTitle(indent+"└>RE:"+title);
		pBoardQAVO.setContent(sboardQAVO.getContent());
		
		ManagerVO managerVO = mService.selectById(loginVO.getManagerId());
		pBoardQAVO.setStaffNo(managerVO.getStaffNo());
		System.out.println(pBoardQAVO);
		service.insertBoard(pBoardQAVO);
		
		return "redirect:/boardQA/list";
	}
	
	@RequestMapping(value = "/{boardNo}", method = RequestMethod.DELETE)
	public String delete(@PathVariable int boardNo) {
		service.deleteBoard(boardNo);
		return "redirect:/boardQA/list";
	}
	
	@RequestMapping(value = "/{boardNo}", method = RequestMethod.GET)
	public String modifyForm(Model model) {
		BoardQAVO boardQAVO = new BoardQAVO();
		
		model.addAttribute("boardQAVO", boardQAVO);
		
		/*return "admin/boardQA/modify";*/
		return "storeManager/boardQA/modify";
	}
	
	@RequestMapping(value = "/{boardNo}", method = RequestMethod.PUT)
	public String modify(@PathVariable int boardNo, @Valid BoardQAVO boardQAVO) {
		boardQAVO.setBoardNo(boardNo);
		return "redirect:/boardQA/detail/" + boardNo;
	}
	
	public String checkType(ManagerVO loginVO) {
		String type=null;
		
		if(loginVO.getType().equals("admin")) {
			type="admin";
		} else if(loginVO.getType().equals("infoManger")) {
			type="infoManger";
		}else if(loginVO.getType().equals("storeManager")) {
			type="storeManager";
		}
		
		return type;
	}
}

// 
