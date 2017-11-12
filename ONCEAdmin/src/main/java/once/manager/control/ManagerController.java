package once.manager.control;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jdk.nashorn.internal.ir.RuntimeNode.Request;
import once.manager.service.ManagerService;
import once.manager.vo.ManagerVO;

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
		
		return "manager/detail/" + managerId;
	}
	
	//회원 정보 상세 페이지
	@RequestMapping(value = "/detail/{managerId}", method = RequestMethod.GET)
	public String detail(@PathVariable String managerId, Model model) {
		ManagerVO manager = service.selectById(managerId);
		
		model.addAttribute("managerVO", manager);
		
		return "manager/detail/" + managerId;
	}
	
	//회원 정보 수정 처리(미완)
	@RequestMapping(value = "/detail/{managerId}", method = RequestMethod.PUT)
	public String modify(@PathVariable String managerId, @Valid ManagerVO manager) {
		manager.setManagerId(managerId);
		service.modifyManager(managerId);
		return "manager/detail/" + managerId;
	}
}
