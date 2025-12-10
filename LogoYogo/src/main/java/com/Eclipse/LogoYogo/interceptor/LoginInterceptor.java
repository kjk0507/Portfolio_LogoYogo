//package com.Eclipse.LoGoYoGo.interceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.web.servlet.HandlerInterceptor;
//import org.springframework.web.servlet.ModelAndView;
//
//public class LoginInterceptor implements HandlerInterceptor {
//	
//    @Override
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {	
//    	
//        String uri = request.getRequestURI();
//
//        if (uri.equals("/main") || uri.equals("/")) {
//            return true;
//        }
//    	
//        HttpSession session = request.getSession(false);
//
//        if (session == null || session.getAttribute("loginUser") == null) {
//        	response.sendRedirect(request.getContextPath() + "/main");
//        	System.out.println("Interceptor html: " + request.getContextPath());
//        	System.out.println("Interceptor URI: " + request.getRequestURI());
//            return false;
//        }
//
//        return true;
//    }
//
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
//			throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//}
