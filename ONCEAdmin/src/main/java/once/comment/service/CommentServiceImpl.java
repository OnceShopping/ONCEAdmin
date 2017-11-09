package once.comment.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.comment.dao.CommentDAO;

@Service
public class CommentServiceImpl implements CommentService{
	
	@Autowired
	private CommentDAO dao;
}
