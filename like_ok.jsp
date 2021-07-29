<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
<jsp:setProperty property="*" name="board"/>
<jsp:setProperty property="idx" param="b_idx" name="board"/>
<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>
<% 
	if(session.getAttribute("userid") == null){		
%>
<script>
   alert('로그인 후 이용하세요');
   location.href = '../login.jsp';
</script>
<%
	} else {
		dao.updateLike(board);
		out.print(board.getLike());
	    	   
%>

<%
	}
%>