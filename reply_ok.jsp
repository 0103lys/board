<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn"%>
<% 
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userid") == null){
		
%>
<script>
   alert('로그인 후 이용하세요.');
   location.href = '../login.jsp';
</script>
<%
	} else { 
%>
<jsp:useBean class="com.koreait.board.BoardDTO" id="board"/>
<jsp:useBean class="com.koreait.reply.ReplyDTO" id="reply"/>
<jsp:setProperty property="*" name="board"/>
<jsp:setProperty property="idx" param="re_idx" name="board"/>
<jsp:setProperty property="re_content" param="re_content" name="reply"/>

<jsp:useBean class="com.koreait.board.BoardDAO" id="dao"/>
<jsp:useBean class="com.koreait.reply.ReplyDAO" id="replydao"/>
<% 		String b_idx = request.getParameter("b_idx");
		String re_content = request.getParameter("re_content");
		
		 
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    String sql = "";
	    
	  
%>

<script>
   alert('댓글이 등록되었습니다.');
   location.href='view.jsp?b_idx=<%=b_idx%>';
</script>
	       
<% 
	   }
%>
	   			