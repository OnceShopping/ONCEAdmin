package once.manager.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import once.manager.service.ManagerService;
import once.manager.vo.ManagerVO;

@SessionAttributes("loginVO")
@Controller
public class ManagerLoginController {

	@Autowired
	private ManagerService service;
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@RequestParam("id")String id, @RequestParam("password")String password, Model model) {
		
		ManagerVO manager = new ManagerVO();
		manager.setManagerId(id);
		manager.setPassword(password);
		
		ManagerVO loginVO = service.login(manager);
				
		if(loginVO==null) {
			model.addAttribute("message", "Please check your ID or Password");
			
			return "login/loginFail";
		}else {
			model.addAttribute("loginVO", loginVO);
			System.out.println(loginVO);
			if(loginVO.getType().equals("admin")) {
				
				return "admin/notice/list";
			}else if(loginVO.getType().equals("infoManger")) {
				
				return "infoManager/itemManage/addItem";
			}else if(loginVO.getType().equals("storeManager")) {
				
				return "storeManager/itemManage/registerItem";
			}else {
				model.addAttribute("message", "type이 이상합니다");
				
				return "login/loginFail";
			}
		}
	}
}