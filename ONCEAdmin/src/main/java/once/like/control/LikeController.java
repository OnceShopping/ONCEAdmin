package once.like.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.like.service.LikeService;

@Controller
public class LikeController {

	@Autowired
	private LikeService service;
}
