package once.manager.control;

import java.util.ArrayList;
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
	@RequestMapping(value="/list", method=RequestMethod.DELETE)
	public String delete(HttpServletRequest request) {
		
		String [] staffNos = request.getParameterValues("managerId");
		
		for(int i=0; i<staffNos.length; i++) {
			service.delete(staffNos[i]);
		}
		
		return "redirect:/manager/list";
	}
	
	//매니저 정보 수정
	@RequestMapping(value = "/modify/{managerId}", method = RequestMethod.GET)
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
	@RequestMapping(value ="/update/{managerId}", method=RequestMethod.PUT )
	public String update(@PathVariable String managerId, @ModelAttribute @Valid ManagerVO manager) {
		
		service.update(manager.getManagerId(), manager.getTelephone());
		
		return "redirect:/manager/list";
	}
}
