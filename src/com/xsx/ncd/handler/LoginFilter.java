package com.xsx.ncd.handler;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter{

	String requestUrl = null;
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		HttpServletRequest httpRequest=(HttpServletRequest)request;
        HttpServletResponse httpResponse=(HttpServletResponse)response;

        requestUrl = httpRequest.getRequestURI();
        
        HttpSession session=httpRequest.getSession();

        if(session.getAttribute("ncd_account") != null){
            chain.doFilter(request, response);
        }
        else{
        	if(requestUrl.equals("/NCD_Server/") || requestUrl.endsWith("Page"))
        	{
        		httpResponse.sendRedirect(httpRequest.getContextPath()+"/Login");
        	}
        	else
        		chain.doFilter(request, response);
        }
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
