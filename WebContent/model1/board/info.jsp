<%@page import="model.Board"%>
<%@page import="model.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%-- /WebContent/model1/board/info.jsp 
  1. num 파라미터 정보를 변수에 저장.
  2. num을 이용하여 db에서 게시물 정보를 조회
     Board BoardDao.selectOne(num)
  3. 조회수 증가시키기   
     void BoardDao.readcntadd(num)
  4. 조회된 게시물을 화면에 출력.     
--%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDao dao = new BoardDao();
	Board b = dao.selectOne(num); //num 해당하는 게시물 조회
	dao.readcntadd(num); //num 해당하는 게시물의 조회건수 1증가
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 상세 보기</title>
<link rel="stylesheet" href="../../css/mainboard.css">
</head>
<body>
	<table>
		<caption>게시물 상세 보기</caption>
		<tr>
			<th width="20%">글쓴이</th>
			<td width="80%" style="text-align: left"><%=b.getName()%></td>
		</tr>
		<tr>
			<th>제목</th>
			<td style="text-align: left"><%=b.getSubject()%></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><table style="width: 100%; height: 250px;">
					<tr>
						<td
							style="border-width: 0px; vertical-align: top; text-align: left">
							<%=b.getContent()%>
						</td>
					</tr>
				</table></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<%
					if (b.getFile1() == null || b.getFile1().trim().equals("")) {
				%>
				&nbsp; <%
 	} else {
 %> <a href="file/<%=b.getFile1()%>"><%=b.getFile1()%></a>
				<%
					}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2"><a href="replyForm.jsp?num=<%=num%>">[답변]</a> 
			<a href="updateForm.jsp?num=<%=num%>">[수정]</a> 
			<a href="deleteForm.jsp?num=<%=num%>">[삭제]</a> 
			<a href="list.jsp">[목록]</a>
			</td>
		</tr>
	</table>
</body>
</html>