package once.boardQA.control;

import java.util.List;

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

@RequestMapping("/boardQA")
@Controller
public class BoardQAController {
	
	@Autowired
	private BoardQAService service;
	
	@RequestMapping("/list")
	public ModelAndView list() {
		List<BoardQAVO> BoardList = service.selectAllBoard();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("BoardList", BoardList);
		mav.setViewName("boardQA/list");
		
		return mav;
	}
	
	@RequestMapping(value = "/detail/{boardNo}", method = RequestMethod.GET)
	public String selectOne(@PathVariable int boardNo, Model mod) {
		BoardQAVO boardQAVO = service.selectOneBoard(boardNo);
		mod.addAttribute("boardQAVO", boardQAVO);
		
		return "boardQA/detail";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String writeForm(Model model) {
		BoardQAVO boardQAVO = new BoardQAVO();
		
		model.addAttribute("boardQAVO", boardQAVO);
		
		return "redirect:/boardQA/write";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(@Valid BoardQAVO boardQAVO) {
		service.insertBoard(boardQAVO);
		
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
		
		return "boardQA/modify";
	}
	
	@RequestMapping(value = "/{boardNo}", method = RequestMethod.PUT)
	public String modify(@PathVariable int boardNo, @Valid BoardQAVO boardQAVO) {
		boardQAVO.setBoardNo(boardNo);
		return "redirect:/boardQA/detail/" + boardNo;
	}
	
}
