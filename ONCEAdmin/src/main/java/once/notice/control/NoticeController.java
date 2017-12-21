package once.notice.control;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import once.notice.service.NoticeService;
import once.notice.vo.NoticeVO;

@RequestMapping("/notice")
@Controller
public class NoticeController {

	@Autowired
	private NoticeService service;
	
	@RequestMapping("/list")
	public ModelAndView selectAll(HttpServletRequest request) {
		
		// 현재 페이지 번호 저장 변수
		int pageNo = 1;
		if (request.getParameter("pageNo") != null) {
			// 페이지 파라미터가 있는 경우 현재 페이지 번호를 설정
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		} 
		// 한페이지에 보여질 목록 수
		int listSize = 10;
		
		// 전체 게시글 카운트
		int totalCount = service.selectAllNotice().size();

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
		List<NoticeVO> list = service.selectPage(page);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("admin/notice/list");
		return mav;
	}
	
	@RequestMapping(value = "/detail/{noticeNo}", method = RequestMethod.GET)
	public String selectOne(@PathVariable int noticeNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		NoticeVO noticeVO = service.selectOneNotice(noticeNo);
		Cookie[] Cookies = request.getCookies(); //모든 쿠키의 값을 가져옴
			System.out.println(Cookies.length);
		for (int i = 0; i < Cookies.length; i++) {
			System.out.println(Cookies[i].getValue());
			if(Cookies[i].getValue().equals("notice"+noticeNo)) { //쿠키의 noticeNo 페이지값과 들어간 페이지의 noticeNo가 같으면 break
				break;
			} else if (i == Cookies.length - 1 ){ //없으면 쿠키를 생성해서 추가하고 게시물 조회수를 1 늘림
				Cookie noticeCookie = new Cookie("notice"+noticeNo, "notice"+noticeNo);
				noticeCookie.setMaxAge(60*60*24); //쿠키기간1일짜리
				response.addCookie(noticeCookie);
				service.addCountNotice(noticeNo);
			}
		}
		
		System.out.println(noticeVO);
		model.addAttribute("noticeVO", noticeVO);
		return "admin/notice/detail";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String writeForm(Model model) {
		NoticeVO noticeVO = new NoticeVO();
		model.addAttribute("noticeVO", noticeVO);
		return "admin/notice/write";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(MultipartHttpServletRequest mRequest, @Valid NoticeVO noticeVO) 
	throws Exception{
		System.out.println(mRequest.getContextPath()); //상대경로
		//로컬 경로가 아니라 서버쪽 경로에 저장됨->
//		String uploadPath = mRequest.getServletContext().getRealPath("/upload/admin/");
		String uploadPath2 = "C:\\Once\\image\\";
		Iterator<String> iter = mRequest.getFileNames();
		while(iter.hasNext()) {
			
			String formFileName = iter.next();
			// 폼에서 파일을 선택하지 않아도 객체 생성됨
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
				System.out.println("파일 사이즈 : " + fileSize);
				
				// 고유한 파일명 만들기	
				String saveFileName = "ONCE-" + UUID.randomUUID().toString() + ext;
				System.out.println("저장할 파일명 : " + saveFileName);
			
				// 임시저장된 파일을 원하는 경로에 저장
				mFile.transferTo(new File(uploadPath2 + saveFileName));
				
				noticeVO.setImgOriName(oriFileName);
				noticeVO.setImgSaveName(saveFileName);
				noticeVO.setImgSize((int)fileSize);
			}
			
		}
		System.out.println(noticeVO);
		noticeVO.setContent(noticeVO.getContent().replace("\r\n", "<br>"));
		service.insertNotice(noticeVO);
		return "redirect:list";
	}
	
	@RequestMapping(value = "update/{noticeNo}", method = RequestMethod.GET)
	public String updateForm(Model model) {
		NoticeVO noticeVO = new NoticeVO();
		model.addAttribute("noticeVO", noticeVO);
		return "admin/notice/update";
	}
	
	@RequestMapping(value = "update/{noticeNo}", method = RequestMethod.POST)
	public String update(@PathVariable int noticeNo, @Valid NoticeVO noticeVO, MultipartHttpServletRequest mRequest) throws Exception{
		noticeVO.setNoticeNo(noticeNo);
//		String updatePath = mRequest.getServletContext().getRealPath("/upload/admin/"); //저장된 경로
		String uploadPath2 = "C:\\Once\\image\\";
		File file = new File(uploadPath2+noticeVO.getImgSaveName()); //파일객체를 생성(저장된 경로+파일저장이름)
		//이미지 저장이름이 존재하면 삭제
		if(noticeVO.getImgSaveName() != null) {
			file.delete();
		}
		
		Iterator<String> iter = mRequest.getFileNames();
		while(iter.hasNext()) {
			
			String formFileName = iter.next();
			// 폼에서 파일을 선택하지 않아도 객체 생성됨
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
				System.out.println("파일 사이즈 : " + fileSize);
				
				// 고유한 파일명 만들기	
				String saveFileName = "ONCE-" + UUID.randomUUID().toString() + ext;
				System.out.println("저장할 파일명 : " + saveFileName);
			
				// 임시저장된 파일을 원하는 경로에 저장
				mFile.transferTo(new File(uploadPath2 + saveFileName));
				
				noticeVO.setImgOriName(oriFileName);
				noticeVO.setImgSaveName(saveFileName);
				noticeVO.setImgSize((int)fileSize);
			}
			
		}
		noticeVO.setContent(noticeVO.getContent().replace("\r\n", "<br>"));
		service.updateNotice(noticeVO);
		return "redirect:/notice/detail/" + noticeNo;
	}

	@RequestMapping(value = "delete/{noticeNo}")
	public String delete(@PathVariable int noticeNo, HttpServletRequest request) {
		NoticeVO noticeVO = service.selectOneNotice(noticeNo);
//		String deletePath = request.getServletContext().getRealPath("/upload/admin/"+noticeVO.getImgSaveName()); //저장된 경로 + 파일저장이름
		String uploadPath2 = "C:\\Once\\image\\"+noticeVO.getImgSaveName();
		File file = new File(uploadPath2); //파일객체를 생성
		//파일이 존재하면 삭제
		if(file.exists()) {
			file.delete();
		}
		service.deleteNotice(noticeNo);
		
		return "redirect:/notice/list";
	}	
}
