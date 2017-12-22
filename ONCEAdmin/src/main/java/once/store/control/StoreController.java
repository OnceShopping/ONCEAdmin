package once.store.control;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import once.manager.vo.ManagerVO;
import once.store.service.StoreService;
import once.store.vo.StoreVO;

@RequestMapping("/store")
@Controller
public class StoreController {

	@Autowired
	private StoreService service;
	
	//매장 리스트 페이지
	@RequestMapping("/list")
	public ModelAndView list() {
		List<StoreVO> firstFloor = service.selectFirst();
		List<StoreVO> secondFloor = service.selectSecond();
		List<StoreVO> thirdFloor = service.selectThird();
		
		ModelAndView mav = new ModelAndView();

		mav.addObject("firstFloor", firstFloor);
		mav.addObject("secondFloor", secondFloor);
		mav.addObject("thirdFloor", thirdFloor);
		mav.setViewName("admin/store/list");
		
		return mav;
	}
	
	//매장 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public void deleteStore(@RequestParam String storeNo) {
		service.deleteStore(storeNo);
		
	}
	
	//매장 추가 페이지
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addForm(Model model) {
		StoreVO store = new StoreVO();
		model.addAttribute("storeVO", store);
		return "admin/store/add";
	}
	
	//존재하는 매장 체크
	@ResponseBody
	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public boolean checkStore(@RequestParam String storeNo) {
		return service.checkStore(storeNo);
	}

	//매장 추가 처리
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addStore(MultipartHttpServletRequest request, @Valid StoreVO store) throws Exception {
		String uploadPath = "C:\\Once\\image\\";
		Iterator<String> iterator = request.getFileNames();
		
		while( iterator.hasNext()) {
			
			String fileName = iterator.next();
			
			MultipartFile file = request.getFile(fileName);
			String oriFileName = file.getOriginalFilename();
			
			if(oriFileName != null && !oriFileName.equals("")) {
				String ext = "";
				int index = oriFileName.lastIndexOf(".");
				
				if(index != -1) {
					ext = oriFileName.substring(index);
				}
				
				long fileSize = file.getSize();
				
				String saveFileName = "ONCE-" + UUID.randomUUID().toString() + ext;
				
				file.transferTo(new File(uploadPath + saveFileName));
				
				store.setLogo(oriFileName);
				store.setImgSaveName(saveFileName);
				store.setImgSize((int)fileSize);
			}
			
		}
		service.addStore(store);
		return "redirect:/store/list";
		
	}
	
	
	//매장 상세 페이지
	@RequestMapping(value = "/detail/{storeNo}", method = RequestMethod.GET)
	public String detail(@PathVariable String storeNo, Model model) {
		StoreVO store = service.selectByStoreNo(storeNo);
		model.addAttribute("storeVO", store);
		
		return "admin/store/detail";
	}
	
	//회원 정보 수정 처리
	@RequestMapping(value = "/detail/{storeNo}", method = RequestMethod.POST)
	public String modify(@PathVariable String storeNo, @ModelAttribute @Valid StoreVO store, MultipartHttpServletRequest request, Model model) throws Exception {
		
		String updatePath = "C:\\Once\\image\\";
		File file = new File(updatePath + store.getImgSaveName());
		
		if(store.getImgSaveName() != null) {
			file.delete();
		}
		
		Iterator<String> iterator = request.getFileNames();
		while(iterator.hasNext()) {
			
			String formFileName = iterator.next();
			MultipartFile multiFile = request.getFile(formFileName);
			String oriFileName = multiFile.getOriginalFilename();
			
			if(oriFileName != null && !oriFileName.equals("")) {
			
				String ext = "";
				int index = oriFileName.lastIndexOf(".");
				
				if (index != -1) {
					ext = oriFileName.substring(index);
				}
				
				// 파일 사이즈
				long fileSize = multiFile.getSize();
				
				String saveFileName = "ONCE-" + UUID.randomUUID().toString() + ext;
			
				// 임시저장된 파일을 원하는 경로에 저장
				multiFile.transferTo(new File(updatePath + saveFileName));
				
				store.setLogo(oriFileName);
				store.setImgSaveName(saveFileName);
				store.setImgSize((int)fileSize);
			}
			
		}
		service.modifyStore(store);
		
		model.addAttribute("storeVO", store);
		model.addAttribute("message", "매장 정보 수정이 성공적으로 완료되었습니다.");
		
		return "admin/store/modifyProcess";
	}
	
}
