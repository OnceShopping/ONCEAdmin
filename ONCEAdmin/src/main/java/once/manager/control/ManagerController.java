package once.manager.control;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import once.manager.service.ManagerService;
import once.manager.vo.ManagerVO;
import once.notice.vo.NoticeVO;
import once.store.vo.StoreVO;

@SessionAttributes("loginVO")
@RequestMapping("/manager")
@Controller
public class ManagerController {

	@Autowired
	private ManagerService service;
	
	//패스워드 체크 페이지
	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public String checkForm() {
		return "manager/check";
	}

	//패스워드 체크 처리
	@RequestMapping(value = "/check", method = RequestMethod.POST)
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
	@RequestMapping(value = "/detail/{managerId}", method = RequestMethod.GET)
	public String modify(@PathVariable String managerId, @ModelAttribute @Valid ManagerVO manager, Model model) {
		
		service.modifyManager(manager.getManagerId(), manager.getPassword(), manager.getTelephone());
		
		model.addAttribute("managerVO", manager);
		model.addAttribute("message", "회원 정보 수정이 성공적으로 완료되었습니다.");
		
		return "manager/modifyProcess";
	}
	
	//매니저 관리 조회
	@RequestMapping(value="/list")
	public ModelAndView list() {
		
		List<ManagerVO> managerList = service.selectAll();
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("admin/manager/list");
		mav.addObject("managerList", managerList);
		
		return mav;
	}
	
	//매니저 삭제
	@RequestMapping(value="/list", method=RequestMethod.DELETE)
	public String delete(HttpServletRequest request) {
		
		String [] staffNos = request.getParameterValues("managerId");
		
		for(int i=0; i<staffNos.length; i++) {
			service.delete(staffNos[i]);
		}
		
		return "redirect:/manager/list";
	}
	

	@RequestMapping(value = "/modify/{managerId}", method = RequestMethod.GET)
	public ModelAndView modify(@PathVariable String managerId) {
	
		ManagerVO manager = service.selectById(managerId);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("managerVO", manager);
		mav.setViewName("admin/manager/modify");
		
		return mav;
	}
	
	@RequestMapping(value ="/update/{managerId}", method=RequestMethod.PUT )
	public String update(@PathVariable String managerId, @ModelAttribute @Valid ManagerVO manager) {
		
		System.out.println(manager.getManagerId());
		System.out.println(manager.getTelephone());
		
		service.update(manager.getManagerId(), manager.getTelephone());
		
		return "redirect:/manager/list";
	}
}
