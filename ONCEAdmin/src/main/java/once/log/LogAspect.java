package once.log;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LogAspect {
	
	@Around("execution(* ONCE..*.*(..))")
	public Object trace(ProceedingJoinPoint joinPoint) 
					throws Throwable {
		String pattern = "[yyyy-MM-dd hh:mm:ss] ";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		
		System.out.println(sdf.format(new Date()) 
				+ joinPoint.getTarget().getClass().getName() + "."
				+ joinPoint.getSignature().getName() + "() 시작");
		
		Object obj = joinPoint.proceed();
		
//		System.out.println(sdf.format(new Date()) 
//				+ joinPoint.getTarget().getClass().getName() + "."
//				+ joinPoint.getSignature().getName() + "() 종료");
//		
		return obj;
	}
}











