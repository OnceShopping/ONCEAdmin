package once.notice.control;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import once.notice.service.NoticeService;
import once.notice.vo.NoticeVO;

@RequestMapping("/notice")
@Controller
public class NoticeController {

	@Autowired
	private NoticeService service;
	
	@RequestMapping("/list")
	public ModelAndView selectAll() {
		List<NoticeVO> list = service.selectAllNotice();
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("admin/notice/list");
		return mav;
	}
	
	@RequestMapping(value = "/detail/{noticeNo}", method = RequestMethod.GET)
	public String selectOne(@PathVariable int noticeNo, Model model) {
		NoticeVO noticeVO = service.selectOneNotice(noticeNo);
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
	public String write(@Valid NoticeVO noticeVO) {
		service.insertNotice(noticeVO);
		
		return "redirect:list";
	}
	
	@RequestMapping(value = "/{noticeNo}", method = RequestMethod.GET)
	public String updateForm(Model model) {
		NoticeVO noticeVO = new NoticeVO();
		model.addAttribute("noticeVO", noticeVO);
		return "admin/notice/update";
	}
	
	@RequestMapping(value = "/{noticeNo}", method = RequestMethod.PUT)
	public String update(@PathVariable int noticeNo, @Valid NoticeVO noticeVO) {
		noticeVO.setNoticeNo(noticeNo);
		service.updateNotice(noticeVO);
		return "redirect:/notice/detail/" + noticeNo;
	}

	@RequestMapping(value = "/{noticeNo}", method = RequestMethod.DELETE)
	public String delete(@PathVariable int noticeNo) {
		service.deleteNotice(noticeNo);		
		return "redirect:/notice/list";
	}	
}
