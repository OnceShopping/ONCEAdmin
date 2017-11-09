package once.counter.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.counter.service.CounterService;

@Controller
public class CounterController {

	@Autowired
	private CounterService service;
}
