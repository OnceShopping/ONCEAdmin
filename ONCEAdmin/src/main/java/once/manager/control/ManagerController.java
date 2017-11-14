package once.manager.control;

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

import once.manager.service.ManagerService;
import once.manager.vo.ManagerVO;
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
	public String modify(@PathVariable String managerId, @RequestParam String password, @RequestParam String telephone, @Valid ManagerVO manager, Model model) {
		manager.setManagerId(managerId);
		manager.setPassword(password);
		manager.setTelephone(telephone);
		
		service.modifyManager(manager);
		
		model.addAttribute("managerVO", manager);
		model.addAttribute("message", "회원 정보 수정이 성공적으로 완료되었습니다.");
		
		return "manager/modifyProcess";
	}
}
