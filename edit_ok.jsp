<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userid") == null){
%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp';
	</script>
<%
	}else{
		
%>
<jsp:useBean class="com.koreait.board.BoardDTO" id="board"/>
<jsp:setProperty property="*" name="board"/>
<jsp:setProperty property="idx" param="b_idx" name="board"/>
<jsp:setProperty property="content" param="b_content" name="board"/>
<jsp:setProperty property="title" param="b_title" name="board"/>
<jsp:setProperty property="file" param="b_file" name="board"/>
<jsp:useBean class="com.koreait.board.BoardDAO" id="dao"/>
<%
		String b_idx = request.getParameter("b_idx");
		String b_title = request.getParameter("b_title");
		String b_content = request.getParameter("b_content");
		
		String uploadPath = request.getRealPath("upload");
		
		//Connection conn = null;
		//PreparedStatement pstmt = null;
		//String sql = "";
		int size = 1024*1024*10;
		//String b_idx = "";
		
		//board.setIdx(Integer.parseInt(String.valueOf(session.getAttribute("idx"))));
		System.out.print(board);
		if(dao.edit(board)==1){

%>

<script>
	alert('수정되었습니다');
	location.href='view.jsp?b_idx=<%=board.getIdx()%>';
</script>
<%
		}else{
%>
<script>
	alert('수정실패!');
	history.back();
</script>	
<%
	}
}
%>
