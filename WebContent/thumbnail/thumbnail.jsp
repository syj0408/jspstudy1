<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="javax.media.jai.RenderableOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>원본 이미지와 썸네일 이미지 보기</title>
</head>
<body>
<%
//path : 이미지 업로드 위치.
//D:\190812\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\jspstudy1\thumbnail
	String path = application.getRealPath("/") + "thumbnail/";
	int size = 10 * 1024 * 1024;//최대 업로드 크기
	/*
		request : 요청 객체, 파라미터정보, 파일정보, 파일내용 => 데이터 정보
		path : 파일 업로드 폴더 정보
		size : 최대 업로드 될 수 있는 파일의 크기.
		"EUC-KR" : 파라미터 정보가있다면 인코딩 정보로 ..
		=> 파일 업로드 완료
	*/
	MultipartRequest multi = new MultipartRequest(request,path,size,"EUC-KR");
	String fname = multi.getFilesystemName("picture");
	//fname : 업로드된 파일의 이름
	/* ParameterBlock pb = new ParameterBlock();
	pb.add(path + fname);
	RenderedOp rop = JAI.create("fileload",pb);
	BufferedImage bi = rop.getAsBufferedImage(); */
	//new File(path + fname) : 이미 업로드된 이미지의 위치.
	//BufferedImage : 메인메모리 안에 이미지를 읽어서 메모리에 로드.
	//bi : 원본이미지의 메모리 로드 데이터 정보
	BufferedImage bi = ImageIO.read(new File(path + fname));
	int width = bi.getWidth()/5; //원본 이미지의 가로 크기의 1/5
	int height = bi.getHeight()/5; //원본 이미지의 세로크기의 1/5
	//thumb : 원본의 1/5크기의 이미지 버퍼를 생성. 색상은 컬러로 설정.
	BufferedImage thumb = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
	//g : 그리기 도구 객체
	Graphics2D g = thumb.createGraphics();
	//drawImage : 이미지 그리기. 이미지 원본 = bi , 이미지 버퍼에 원본의 1/5크기의 이미지 생성.
	g.drawImage(bi,0,0,width,height,null);
 	File f = new File(path + "sm_" + fname);
	//이미지 버퍼의 내용을 파일로 생성.
	ImageIO.write(thumb,"jpg",f); 
%>
<h3>원본이미지</h3>
<img src="<%=fname %>"><p>
<h3>썸네일이미지</h3>
<img src="sm_<%=fname %>"><p>
</body>
</html>