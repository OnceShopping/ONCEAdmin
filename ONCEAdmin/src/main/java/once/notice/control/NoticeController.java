package once.notice.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.notice.service.NoticeService;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService service;
}
