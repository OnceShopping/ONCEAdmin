package once.comment.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.comment.service.CommentService;

@Controller
public class CommentController {
	
	@Autowired
	private CommentService service;
}
