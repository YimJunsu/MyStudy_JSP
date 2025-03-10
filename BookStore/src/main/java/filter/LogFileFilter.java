package filter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFileFilter implements Filter{
	PrintWriter writer;
	
	public void init(FilterConfig config) throws ServletException {
		String filename=config.getInitParameter("filename");
		
		if(filename==null)
			throw new ServletException("로그 파일의 이름을 찾을 수 없습니다.");
		
		try {
			writer=new PrintWriter(new FileWriter(filename, true), true);
		} catch (IOException e) {
			throw new ServletException("로그 파일을 열 수 없습니다.");
		}
	}
	// 파일에 작성
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException {
		writer.println(" ===================log시작======================");
		writer.println(" 접속한 클라이언트 IP : " + request.getRemoteAddr());
		long start=System.currentTimeMillis();
		writer.println(" 접근한 URL 경로 : " + getURLPath(request));
		writer.println(" 요청 처리 시작 시간 : " + getCurrentTime());
		
		chain.doFilter(request, response);
		
		long end = System.currentTimeMillis();
		writer.println(" 요청 처리 종료 시작 : " + getCurrentTime());
		writer.println(" 요청 처리 소요 시간 : " + (end-start)+"ms ");
		writer.println(" ====================종료=====================");
		writer.flush();  // 버퍼 비우기
	}
	public void destroy() {
		writer.close();
	}
	private String getURLPath (ServletRequest request) {
		HttpServletRequest req;
		String curremtPath="";
		String queryString="";
		if(request instanceof HttpServletRequest) {
			req = (HttpServletRequest)request;
			curremtPath=req.getRequestURI();
			queryString=req.getQueryString();
			queryString=queryString==null ? "" : "?" + queryString ;
		}
		return curremtPath+queryString;
	}
	private String getCurrentTime() {
		DateFormat formatter=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(calendar.getTime());
	}
}