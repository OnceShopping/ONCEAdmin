package once.tagSticker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.tagSticker.dao.TagStickerDAO;

@Service
public class TagStickerServiceImpl implements TagStickerService {
	
	@Autowired
	private TagStickerDAO dao;
}
