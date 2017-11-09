package once.manager.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.manager.service.ManagerService;

@Controller
public class ManagerController {

	@Autowired
	private ManagerService service;

}
