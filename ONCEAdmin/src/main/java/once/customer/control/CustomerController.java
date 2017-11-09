package once.customer.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.customer.service.CustomerService;

@Controller
public class CustomerController {

	@Autowired
	private CustomerService service;
}
