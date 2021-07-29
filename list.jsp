<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="java.util.Date" %>
<%
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   ResultSet rs_reply = null;
   String sql = "";
   int totalCount = 0;	// 총 글의 개수
   int pagePerCount = 10; // 페이지 당 글 개수
   int start = 0; // 시작 글번호
   
   String pageNum = request.getParameter("pageNum");	// get방식으로 pageNum 받기
   if(pageNum!= null && !pageNum.equals("")){
	   start = (Integer.parseInt(pageNum)-1) * pagePerCount;	//
   }else {
	   pageNum = "1";
	   start = 0;
   }
   
   try{
      conn = Dbconn.getConnection();
      sql = "select count(b_idx) as total from tb_board";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      if(rs.next()){
         totalCount = rs.getInt("total");
      }
      
      sql = "select b_idx, b_userid, b_title, b_regdate, b_hit, b_like, b_file from tb_board order by b_idx desc limit ?,?";
      
      /* 
      		select *from tb_board order by b_idx desc limit 0, 10; : 0부터 10개 맨 뒤에부터(최신글 10개)
      		select *from tb_board order by b_idx desc limit 10, 10; : 11부터 10개
      		select *from tb_board order by b_idx desc limit 20, 10; : 21부터 10개
      
      */
      pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, start);
      pstmt.setInt(2, pagePerCount);
      rs = pstmt.executeQuery();
   }catch(Exception e){
      e.printStackTrace();
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LIST</title>
</head>
<body>
   <h2>LIST</h2>
   <p>게시글 : <%=totalCount%>개</p>
   
   <table border="1" width="800">
      <tr>
         <th width="50">번호</th>
         <th width="300">제목</th>
         <th width="100">글쓴이</th>
         <th width="75">조회수</th>
         <th width="200">날짜</th>
         <th width="75">좋아요</th>
      </tr>
<%
   while(rs.next()){
      String b_idx = rs.getString("b_idx");
      String b_userid = rs.getString("b_userid");
      String b_title = rs.getString("b_title");
      String b_regdate = rs.getString("b_regdate").substring(0, 10);
      String b_hit = rs.getString("b_hit");
      String b_like = rs.getString("b_like");
      String b_file = rs.getString("b_file");
      
      Date date = new Date();
      SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
      String time = (String)simpleDate.format(date);
      String update_time = b_regdate.substring(0,10);
      
      String fileStr = "";
      if(b_file != null && !b_file.equals("")){
    	  fileStr = "<img src='./file.png' alt='파일'>";
      }
      
      /* 현재 글에 대한 count  */
      sql = "select count(re_idx) as replycnt from tb_reply where re_boardidx=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, b_idx);
      rs_reply = pstmt.executeQuery();
      
      
      int replycnt = 0;
      String replycnt_str = "";
      
      if(rs_reply.next()){
    	  replycnt = rs_reply.getInt("replycnt");
    	  if(replycnt > 0){
    		  replycnt_str = "["+replycnt+"]";
    	  }
      }
      
%>
      <tr>
         <td><%=b_idx%></td>
         <!-- 게시물 idx (글번호) 를 가져옴 -->
         <td><a href="./view.jsp?b_idx=<%=b_idx%>"><%=b_title%></a> [<%=replycnt%>] <%=fileStr%>
         <% 
         	if(time.equals(update_time)){
         %>
         <img src=./newicon.png><% }%> </td>
         <td><%=b_userid%></td>
         <td><%=b_hit%></td>
         <td><%=b_regdate%></td>
         <td><%=b_like%></td>
      </tr>
<%
   }


	int pageNums = 0;
	if(totalCount % pagePerCount == 0){
		pageNums = (totalCount / pagePerCount); // 20(전체 글 개수) / 10
	}else{
		pageNums = (totalCount/ pagePerCount) + 1;
	}
%>

	<tr>
		<td colspan="6" align="center">
		<%
			for(int i=1; i<=pageNums; i++){
				out.print("<a href='list.jsp?pageNum="+i+"'>["+i+"]</a> ");
			}
		
		%>
		
		</td>
	</tr>
   </table>
   
   
   <p><input type="button" value="글쓰기" onclick="location.href='write.jsp'"> <input type="button" value="MAIN" onclick="location.href='../login.jsp'"></p>
</body>
</html>