package once.customer.control;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import once.customer.service.CustomerService;
import once.customer.vo.CustomerVO;

@RequestMapping("/customer")
@Controller
public class CustomerController {

	@Autowired
	private CustomerService service;
	

	@RequestMapping("/customerList")
	public ModelAndView list() {
		List<CustomerVO> customerList = service.selectAllBoard();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("customer/customerList");
		mav.addObject("customerList", customerList);
		
		return mav;
	}
	
}
