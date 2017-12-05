package once.log;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import once.manager.vo.ManagerVO;

@Component
@Aspect
public class LogAspect {
	
//	@Around("execution(* once..*.*(..))")
//	public Object trace(ProceedingJoinPoint joinPoint) 
//					throws Throwable {
//		String pattern = "[yyyy-MM-dd hh:mm:ss] ";
//		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
//		
//		System.out.println(sdf.format(new Date()) 
//				+ joinPoint.getTarget().getClass().getName() + "."
//				+ joinPoint.getSignature().getName() + "() 시작");
//		
//		Object obj = joinPoint.proceed();
//		
//		System.out.println(sdf.format(new Date()) 
//				+ joinPoint.getTarget().getClass().getName() + "."
//				+ joinPoint.getSignature().getName() + "() 종료");
//	
//		return obj;
//	}
	
	
	@Around("execution(* once.boardQA.control.*.*(..))")
	public Object checkType(ProceedingJoinPoint joinPoint) throws Throwable{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession(); 
		ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
		
		String type = "";
		
		if(loginVO.getType().equals("admin")) {
			type = loginVO.getType();
		} else if(loginVO.getType().matches(".*info.*")) {
			type = loginVO.getType();
		} else if(loginVO.getType().matches(".*store.*")) {
			type = loginVO.getType();
		}
		request.setAttribute("type", type);
		return joinPoint.proceed();
	}
}











