<%--
<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%@page import="com.model2.mvc.service.domain.Product"%>
<%@page import="java.util.*"%>
<%@page import="com.model2.mvc.common.Search"%>
<%@page import="com.model2.mvc.common.Page"%>
 --%>
 
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--

<%
			System.out.println("listproduct.jsp 10 도착");
	HashMap<String, Object> map = (HashMap<String, Object>) request.getAttribute("map");
Search searchVO = (Search) request.getAttribute("searchVO");

String searchCondition = CommonUtil.null2str(searchVO.getSearchCondition());
String searchKeyword = CommonUtil.null2str(searchVO.getSearchKeyword());

request.getAttribute("menu");
Page resultPage=(Page)request.getAttribute("resultPage");
			System.out.println("resultpage 확인 :::"+resultPage);

int total = 0;
List<Product> list = null;
if (map != null) {
	total = ((Integer) map.get("totalCount")).intValue();
	list = (ArrayList<Product>) map.get("list");
}

int currentPage = searchVO.getCurrentPage();

int totalPage = 0;
if (total > 0) {
	totalPage = total / searchVO.getPageSize();
	if (total % searchVO.getPageSize() > 0)
		totalPage += 1;
	System.out.println("listproduct.jsp 31라인 "+totalPage);
}
%>




 --%>


<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
<!--
		function fncGetProductList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();		
}
 -->
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" action="/listProduct.do?menu=manage"
			method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">
						<%-- 		
								<%
									if("manage".equals(request.getParameter("menu"))){
								%>
								상품 관리
								<%
									}else{
								%>
								상품 검색
									<%
									}
								%>
						--%>
						<c:if test ="${param.menu=='manage'}">
							상품관리<br/>
						</c:if>
						
						<c:if test ="${param.menu=='search'}">
							상품검색<br/>
						</c:if>		
								
							</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" />
					</td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					
		 			<td align="right">
		 			<select name="searchCondition" class="ct_input_g" style="width: 80px">
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>가격</option>
					</select> 
					<input type="text" name="searchKeyword"	value="${! empty search.searchKeyword ? search.searchKeyword : "" }" 
							class="ct_input_g"
							style="width: 200px; height: 19px" />
						</td>
				
					
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23">
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;"> 
								<a href="javascript:fncGetProductList('1');">검색</a>
								</td>
								<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">
						전체  ${ resultPage.totalCount}  건수, 현재 ${ resultPage.currentPage} 페이지
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">현재상태</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
	<%--			
				<%
					for (int i = 0; i < list.size(); i++) {
						Product vo =list.get(i);
				%>
				<tr class="ct_list_pop">
					<td align="center"><%=i+1%></td>
					<td></td>

					<td align="left"><!-- 요부분 -->
					<a href="/getProduct.do?prodNo=<%=vo.getProdNo()%>&menu=<%=request.getAttribute("menu") %>"><%=vo.getProdName()%></a>
					</td>

					<td></td>
					<td align="left"><%=vo.getPrice()%></td>
					<td></td>
					<td align="left"><%=vo.getRegDate()%></td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
				<%} %>
				
	--%>
		<c:set var="i" value="0"/>
		<c:forEach var="product" items="${list}">
			<c:set var="i" value="${i+1}"/>
			<tr class="ct_list_pop">
				<td align="center">${i}</td>
				<td></td>
				<td align="left"><a href="/getProduct.do?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>
			<%--	<c:choose>
						<c:when test = "${menu == 'manage'}">
							<jsp:forward page="/updateProductView.jsp"/>
						</c:when>
						<c:otherwise>
							<jsp:forward page= "/getProduct.jsp"/>
						</c:otherwise>
					</c:choose>
			--%> 
				<td></td>
				<td align="left"> ${product.price } </td>
				<td></td>
				<td align="left">${product.regDate } </td>
				<td></td>
				<td align="left"> 판매중  </td>
				<td></td>
			</tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</c:forEach>
	
	</table>
				
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center">
						<input type="hidden" id="currentPage" name="currentPage" value=""/>
		<%--				
							<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
									◀ 이전
							<% }else{ %>
									<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
							<% } %>
				
							<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
									<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
							<% 	}  %>
					
							<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
									이후 ▶
							<% }else{ %>
									<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
							<% } %>   
		 --%>		
		 			<jsp:include page="../common/pageNavigator2.jsp"/>
		 			
					</td>
				</tr>
			</table>
			<!--  페이지 Navigator 끝 -->

		</form>

	</div>
</body>
</html>
