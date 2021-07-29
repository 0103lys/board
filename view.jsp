<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>


<jsp:useBean id="reply" class="com.koreait.reply.ReplyDTO" />
<jsp:setProperty property="*" name="reply" />
<jsp:setProperty property="re_idx" param="re_idx" name="reply" />
<jsp:useBean id="replydao" class="com.koreait.reply.ReplyDAO" />

<jsp:useBean class="com.koreait.board.BoardDTO" id="board" />
<jsp:setProperty property="*" name="board" />
<jsp:setProperty property="idx" param="b_idx" name="board" />
<jsp:useBean class="com.koreait.board.BoardDAO" id="dao" />
<%
	if(dao.view(board)!=null && replydao.view_reply(reply, board)!=null){
	   board.setIdx(Integer.parseInt(String.valueOf(session.getAttribute("b_idx"))));
	   board.setUserid((String)session.getAttribute("b_userid"));
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<script>
	function like(){
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
				document.getElementById('like').innerHTML = xhr.responseText;
			}
		}
		xhr.open('GET', './like_ok.jsp?b_idx=<%=board.getIdx()%>
	', true);
		xhr.send();
	}
</script>
</head>
<body>
	<h2>글보기</h2>
	<table border="1" width="800">
		<tr>
			<td>제목</td>
			<td><%=board.getTitle()%></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><%=board.getRegdate()%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=board.getUserid()%></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><%=board.getHit()%></td>
		</tr>
		<tr>
			<td>좋아요</td>
			<td><span id="like"><%=board.getLike()%></span></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=board.getContent()%></td>
		</tr>
		<tr>
			<td>파일</td>
			<td>
				<%
					if(board.getFile() != null && !board.getFile().equals("")){
						out.println("첨부파일");
						out.println("<img src='../upload/"+board.getFile()+"' alt='첨부파일' width='150'>");
					}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
<%
	if(board.getUserid().equals((String)session.getAttribute("userid"))){
%> 
	<input type="button" value="수정"	 onclick="location.href='./edit.jsp?b_idx=<%=board.getIdx()%>'"> 
	<input type="button" value="삭제" 	onclick="location.href='./delete.jsp?b_idx=<%=board.getIdx()%>'">
<%
	}	
%> 
	<input type="button" value="좋아요" onclick="like()"> 
	<input	type="button" value="리스트" onclick="location.href='./list.jsp'"></td>
		</tr>
	</table>
	<hr/>
	
	<form method="post" action="reply_ok.jsp">
		<input type="hidden" name="b_idx" value="<%=board.getIdx()%>">
		<p><%=session.getAttribute("userid")%> : <input type="text" size="40" name="re_content"> 
		<input	type="submit" value="확인"></p>
	</form>
	<hr/>

	<p><%=reply.getRe_userid()%>	:	<%=reply.getRe_content()%>		( <%=reply.getRe_regdate()%> )
<%
	if(reply.getRe_userid().equals((String)session.getAttribute("userid"))){
%>
	<input type="button" value="삭제" onclick="location.href='reply_del.jsp?re_idx=<%=reply.getRe_idx()%>&b_idx=<%=board.getIdx()%>'">
<%
	}
%>
	</p>

</body>
</html>