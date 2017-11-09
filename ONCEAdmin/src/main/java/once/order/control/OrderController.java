package once.order.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.order.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	private OrderService service;
}
