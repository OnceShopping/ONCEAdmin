package once.warehouse.control;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import once.customer.service.CustomerService;
import once.customer.vo.CustomerVO;
import once.order.service.OrderService;
import once.order.vo.OrderVO;
import once.tagSticker.service.TagStickerService;
import once.tagSticker.vo.TagStickerVO;
import once.warehouse.service.WarehouseService;
import once.warehouse.vo.WarehouseVO;

@RequestMapping("warehouse")
@Controller
public class WarehouseController {

	@Autowired
	private WarehouseService service;
	
	@Autowired
	private CustomerService cService;
	
	@Autowired
	private TagStickerService tService;
	
	@Autowired
	private OrderService oService;
	
	@RequestMapping("insert")
	public @ResponseBody Map<String, Object> insertWarehouse(@RequestParam(value="warehouseId")String warehouseId, 
			@RequestParam("TagNo")String tagNo, @RequestParam("memNo")int memNo, @RequestParam("floor")String floor, @RequestParam("floorWareNo")int floorWareNo) {
		Map<String, Object> map = new HashMap<>();
		
		TagStickerVO tagStickerVO = tService.selectOneTag(tagNo);
		
		CustomerVO customerVO = cService.selectOneCustomer(memNo);
		
		WarehouseVO warehouseVO = service.selectOneWarehouse(memNo);
		
		List<OrderVO> orderList = oService.memNoOrderList(memNo);
		
		int totalCount = 0;

		for(int i=0; i< orderList.size(); i++) {
			String status = orderList.get(i).getStatus();
			if(status != "수령완료") {
				totalCount++;
			}
		}
		
		
				if(warehouseVO != null) {

					service.updateWarehouse(memNo);
					oService.updateStatusFin(tagStickerVO.getOrderNo());
					map.put("orderNo", tagStickerVO.getOrderNo());
					map.put("id", customerVO.getId());
					map.put("tagNo", tagNo);
					map.put("count", warehouseVO.getCount()+1);
					map.put("totalCount", totalCount);
				} else {

					WarehouseVO newWarehouseVO = new WarehouseVO(1, floor, memNo, floorWareNo);
					service.insertWarehouse(newWarehouseVO);
					oService.updateStatusFin(tagStickerVO.getOrderNo());
					map.put("orderNo", tagStickerVO.getOrderNo());
					map.put("id", customerVO.getId());
					map.put("tagNo", tagNo);
					map.put("count", 1);
					map.put("totalCount", totalCount);
				}
		
		if(map.get("count").equals(map.get("totalCount"))) {

			try {
				sendMessage(customerVO, floor);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return map;
	}
	
	public void sendMessage(CustomerVO customer, String floor) throws Exception{

        String sms_url = "";
        sms_url = "https://sslsms.cafe24.com/sms_sender.php"; // SMS 전송요청 URL
        String user_id = base64Encode(""); // SMS아이디
        String secure = base64Encode("");//인증키
        String msg = base64Encode("구매하신 상품이 준비완료되었습니다. 지정하신 " + floor+"에서 구매한 물품을 수령해주세요.");
        String rphone = base64Encode(customer.getTelephone());
        String sphone1 = base64Encode("010");
        String sphone2 = base64Encode("9435");
        String sphone3 = base64Encode("4464");
        String mode = base64Encode("1");
        String subject = "";
        /*String testflag = base64Encode("Y");*/
        String nointeractive = "1";
        String smsType = base64Encode("S");

        String[] host_info = sms_url.split("/");
        String host = host_info[2];
        String path = "/" + host_info[3];
        int port = 80;

        // 데이터 맵핑 변수 정의
        String arrKey[]
            = new String[] {"user_id","secure","msg", "rphone","sphone1","sphone2","sphone3",
                        "mode","smsType"};
        /*
        String arrKey[]
                = new String[] {"user_id","secure","msg", "rphone","sphone1","sphone2","sphone3",
                            "mode","testflag","smsType"};*/
        String valKey[]= new String[arrKey.length] ;
        valKey[0] = user_id;
        valKey[1] = secure;
        valKey[2] = msg;
        valKey[3] = rphone;
        valKey[4] = sphone1;
        valKey[5] = sphone2;
        valKey[6] = sphone3;
        valKey[7] = mode;
        valKey[8] = smsType;
        /*valKey[8] = testflag;
        valKey[9] = smsType;*/
        

        String boundary = "";
        Random rnd = new Random();
        String rndKey = Integer.toString(rnd.nextInt(32000));
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] bytData = rndKey.getBytes();
        md.update(bytData);
        byte[] digest = md.digest();
        for(int i =0;i<digest.length;i++)
        {
            boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
        }
        boundary = "---------------------"+boundary.substring(0,11);

        // 본문 생성
        String data = "";
        String index = "";
        String value = "";
        for (int i=0;i<arrKey.length; i++)
        {
            index =  arrKey[i];
            value = valKey[i];
            data +="--"+boundary+"\r\n";
            data += "Content-Disposition: form-data; name=\""+index+"\"\r\n";
            data += "\r\n"+value+"\r\n";
            data +="--"+boundary+"\r\n";
        }
        
        InetAddress addr = InetAddress.getByName(host);
        Socket socket = new Socket(host, port);
        // 헤더 전송
        BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), "UTF-8"));
        wr.write("POST "+path+" HTTP/1.0\r\n");
        wr.write("Content-Length: "+data.length()+"\r\n");
        wr.write("Content-type: multipart/form-data, boundary="+boundary+"\r\n");
        wr.write("\r\n");

        // 데이터 전송
        wr.write(data);
        wr.flush();

        // 결과값 얻기
        BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(), "UTF-8"));
        String line;
        String alert = "";
        ArrayList tmpArr = new ArrayList<>();
        while ((line = rd.readLine()) != null) {
            tmpArr.add(line);
        }
        wr.close();
        rd.close();

        String tmpMsg = (String)tmpArr.get(tmpArr.size()-1);
        String[] rMsg = tmpMsg.split(",");
        String Result= rMsg[0]; //발송결과
        String Count= ""; //잔여건수
        if(rMsg.length>1) {Count= rMsg[1]; }

                        //발송결과 알림
        if(Result.equals("success")) {
            alert = "성공적으로 발송하였습니다.";
            alert += " 잔여건수는 "+ Count+"건 입니다.";
        }
        else if(Result.equals("reserved")) {
            alert = "성공적으로 예약되었습니다";
            alert += " 잔여건수는 "+ Count+"건 입니다.";
        }
        else if(Result.equals("3205")) {
            alert = "잘못된 번호형식입니다.";
        }
        else {
            alert = "[Error]"+Result;
        }

        if(nointeractive.equals("1") && !(Result.equals("Test Success!")) && !(Result.equals("success")) && !(Result.equals("reserved")) ) {
        	 System.out.println("<script>alert('" + alert + "')</script>");
        }
        else if(!(nointeractive.equals("1"))) {
        	System.out.println("<script>alert('" + alert + "')</script>");
        }
   
	}
	
	
	@SuppressWarnings("restriction")
	public static String base64Encode(String str)  throws java.io.IOException {
        sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
        byte[] strByte = str.getBytes();
        String result = encoder.encode(strByte);
        return result ;
    }
	
	@SuppressWarnings("restriction")
	public static String base64Decode(String str)  throws java.io.IOException {
		sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
		byte[] strByte = decoder.decodeBuffer(str);
        String result = new String(strByte);
        return result ;
    }
	
}
