<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2015 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  * This JSP creates an HTML table displaying the promotion code redemption
  * field plus all the applied promotion in an order.
  *
  * How to use this snippet?
  * 1. To display this feature in your store's checkout page, you can cut and
  *    paste the code from the snippet to your checkout page, or simply include it:
  *                     <c:import url="../../Snippets/Marketing/Promotions/PromotionsCodeDisplay.jsp">
  *                            <c:param name="orderId" value="10001"/>
       *                     </c:import>
  *****
--%>

<!-- BEGIN PromotionCodeDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error--%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		<fmt:message bundle="${storeText}" key="PROMOTION_CODE_EMPTY" var="PROMOTION_CODE_EMPTY"/>
		MessageHelper.setMessage("PROMOTION_CODE_EMPTY", <wcf:json object="${PROMOTION_CODE_EMPTY}"/>);
	});
</script>

<c:choose>
	<c:when test="${empty param.orderId}">
		<c:choose>
			<c:when test="${!empty WCParam.orderId}">
				<c:set var="orderId" value="${WCParam.orderId}" />
			</c:when>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:set var="orderId" value="${param.orderId}" />
	</c:otherwise>
</c:choose>

<c:set var="returnView" value=""/>
<c:if test="${!empty param.returnView}">
	<c:set var="returnView" value="${param.returnView}"/>
</c:if>

<wcf:url var="PromotionCodeManage" value="AjaxRESTPromotionCodeApply"  type="Ajax">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<c:set var="order" value="${requestScope.order}"/>
<c:choose>
	<c:when test="${empty order || order == null}">
		<wcf:rest var="promoCodeListBean" url="store/{storeId}/cart/@self/assigned_promotion_code">
			<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		</wcf:rest>
	</c:when>
	<c:otherwise>
		<c:set var="promoCodeListBean" value="${order}"/>
	</c:otherwise>
</c:choose>



<script type="text/javascript">
	dojo.addOnLoad(initPromotionAssets); 
       
	function initPromotionAssets(){
		<c:if test="${!empty errorMessage}">
			MessageHelper.displayErrorMessage(<wcf:json object="${errorMessage}"/>); 
		</c:if>       
	}
</script>

<form name="PromotionCodeForm" id="PromotionCodeForm" method="post" action="<c:out value="${PromotionCodeManage}"/>" onsubmit="javascript: return false;">
	<%-- the "onsubmit" option in the form tag above is to handle problems when a user apply a promotion code by pressing the Enter key in the promotion code input area:
			1) when in an AJAX checkout flow
			2) when the promotion code is empty in a non-AJAX flow --%>

	<input type="hidden" name="orderId" value="<c:out value="${orderId}"/>" id="WC_PromotionCodeDisplay_FormInput_orderId_In_PromotionCodeForm_1"/>
	<input type="hidden" name="taskType" value="A" id="WC_PromotionCodeDisplay_FormInput_page_In_PromotionCodeForm_1"/>
	<input type="hidden" name="URL" value="" id="WC_PromotionCodeDisplay_FormInput_URL_In_PromotionCodeForm_1"/>
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_PromotionCodeDisplay_FormInput_storeId_In_PromotionCodeForm_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_PromotionCodeDisplay_FormInput_catalogId_In_PromotionCodeForm_1"/>
	<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}"/>" id="WC_PromotionCodeDisplay_FormInput_langId_In_PromotionCodeForm_1"/>
	<input type="hidden" name="finalView" value="AjaxOrderItemDisplayView" id="WC_PromotionCodeDisplay_FormInput_finalView_In_PromotionCodeForm_1"/>
     
	<c:if test="${currentOrderLocked != 'true' || env_shopOnBehalfSessionEstablished eq 'true'}">	   
		<div class="promotion_code" id="WC_PromotionCodeDisplay_div_1">
			<label for="promoCode"><fmt:message bundle="${storeText}" key="PROMOTION_CODE"/></label>
		</div>
			 
		<div class="promotion_input" id="WC_PromotionCodeDisplay_div_2">
			<input type="text" class="input" size="6" name="promoCode" id="promoCode" onchange="javaScript:TealeafWCJS.processDOMEvent(event);" onkeypress="if(event.keyCode==13) JavaScript:CheckoutHelperJS.applyPromotionCode('PromotionCodeForm','<c:out value='${returnView}'/>')"/>
		</div>

		<div class="promotion_button" id="WC_PromotionCodeDisplay_div_3">
			<div class="button_align" id="WC_PromotionCodeDisplay_div_4">
					<a href="#" role="button" class="button_primary" id="WC_PromotionCodeDisplay_links_1" aria-labelledby="WC_PromotionCodeDisplay_links_1_ACCE_Label" tabindex="0" onclick="JavaScript:setCurrentId('WC_PromotionCodeDisplay_links_1'); CheckoutHelperJS.applyPromotionCode('PromotionCodeForm','<c:out value='${returnView}'/>');return false;">
					<div class="left_border"></div>
						<div class="button_text"><fmt:message bundle="${storeText}" key="APPLY"/><span id="WC_PromotionCodeDisplay_links_1_ACCE_Label" class="spanacce"><fmt:message bundle="${storeText}" key="Checkout_ACCE_promo_code_apply" /></span></div>
					<div class="right_border"></div>
				</a>
			</div>
			<c:set var="promoCodeString" value=""/>
			<br clear="all"/>
		</div>
	</c:if>
	<div id="appliedPromotionCodes" class="hover_underline">                                   
		<c:forEach var="promotionCode" items="${promoCodeListBean.promotionCode}" varStatus="status">
			<c:set var="promoCodeString" value="${promoCodeString},${promotionCode.code}"/>
				<div class="promotion_used">
					<c:set var="aPromotionCode" value='${fn:replace(promotionCode.code, "\'", "&#39;")}'/>
					<p>
						<c:choose>
							<c:when test="${currentOrderLocked != 'true' || env_shopOnBehalfSessionEstablished eq 'true'}">	
								<a class="font1" id="promotion_${status.count}" href="#" onclick='JavaScript:setCurrentId("promotion_<c:out value='${status.count}'/>");CheckoutHelperJS.removePromotionCode("PromotionCodeForm",<wcf:json object='${aPromotionCode}'/>,"<c:out value='${returnView}'/>");return false;'>
									<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_x_delete.png" alt=""/>
									<fmt:message bundle="${storeText}" key="PROMOTION_CODE_REMOVE" />&#160;<c:out value="${promotionCode.code}"/>
								</a>
							</c:when>
							<c:otherwise>
								<c:out value="${promotionCode.code}"/>
							</c:otherwise>
						</c:choose>
						<span id="promotionDetailsAcceText_${status.count}" style="display:none">
							<fmt:message bundle="${storeText}" key='PROMOTION_DETAILS' />
							<c:set var="emptyDesc" value="true"/>
							<c:forEach var="desc" items="${promotionCode.associatedPromotion}" varStatus="status2">
								<c:if test = "${!empty desc}">
									<c:set var="emptyDesc" value="false"/>
									<c:out value="${desc.description}" escapeXml="true"/>
								</c:if>
							</c:forEach>
							<c:if test="${emptyDesc}">
								<fmt:message bundle="${storeText}" key="PROMO_NO_DESC" />
							</c:if>								
						</span>
					
						<span class="more_info_icon verticalAlign_middle" id="promotion_${status.count}_details" tabindex="0" onmouseover="javascript: this.title = '';" onmouseout="javascript: this.title = document.getElementById('promotionDetailsAcceText_<c:out value='${status.count}'/>').innerHTML;"
							title="<fmt:message bundle='${storeText}' key='PROMOTION_DETAILS' />
								<c:set var="emptyDesc" value="true"/>
								<c:forEach var='desc' items='${promotionCode.associatedPromotion}' varStatus='status2'>
									<c:if test = '${!empty desc}'>
										<c:set var='emptyDesc' value='false'/>
										<c:out value='${desc.description}' escapeXml='true'/>
									</c:if>
								</c:forEach>
								<c:if test='${emptyDesc}'>
									<fmt:message bundle='${storeText}' key='PROMO_NO_DESC' />
								</c:if>
							">
							<img class="info_on" src="<c:out value='${jspStoreImgDir}${vfileColor}icon_info_ON.png'/>" alt=""/>
							<img class="info_off" src="<c:out value='${jspStoreImgDir}${vfileColor}icon_info.png'/>" alt=""/>
						</span>
						<br />
					</p>
				</div>
				<div id="WC_PromotionCodeDisplay_span_${status.count}" tabindex="0" dojoType="wc.widget.Tooltip" connectId="promotion_${status.count}_details" style="display:none">
				<div id="tooltip_popup_${status.count}" class="widget_site_popup">
					<div class="top">
						<div class="left_border"></div>
						<div class="middle"></div>
						<div class="right_border"></div>
					</div>
					<div class="clear_float"></div>
					<div class="middle">
						<div class="content_left_border">
							<div class="content_right_border">
								<div class="content">
									<div class="header" id="WC_PromotionCodeDisplay_div_6_${status.count}"> 
										<span id="WC_PromotionCodeDisplay_div_7_${status.count}"><fmt:message bundle="${storeText}" key="PROMOTION_DETAILS" /></span>
										<div class="clear_float"></div>
									</div>
									<%-- Calculate the height of the tooltip needed. Start with 10px initially (for the space between end of description and footer). (Set Height = length of promotion String /2) --%>
									<c:set var="descStringLen" value="10"/> 
									<c:forEach var="desc" items="${promotionCode.associatedPromotion}">
										<c:set var="descStringLen" value="${fn:length(desc) + descStringLen}"/>
									</c:forEach>
									<div class="body" style="min-height:${descStringLen/2}px;" id="WC_PromotionCodeDisplay_div_9_${status.count}">
										<c:set var="emptyDesc" value="true"/>
										<c:forEach var="desc" items="${promotionCode.associatedPromotion}" varStatus="status2">
											<c:if test = "${!empty desc}">
											<c:set var="emptyDesc" value="false"/>
												<div id="WC_PromotionCodeDisplay_div_10_${status.count}_${status2.count}">
													<div class="required-field" id="WC_PromotionCodeDisplay_div_11_${status.count}_${status2.count}">*</div>&nbsp;
													<c:out value="${desc.description}"/><br />
												</div>
											</c:if>
										</c:forEach>
										<c:if test="${emptyDesc}">
											<div id="WC_PromotionCodeDisplay_div_12_${status.count}">
												<div class="required-field" id="WC_PromotionCodeDisplay_div_13_${status.count}">*</div>&nbsp;
												<fmt:message bundle="${storeText}" key="PROMO_NO_DESC" /><br />
											</div>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="clear_float"></div>
					<div class="bottom">
						<div class="left_border"></div>
						<div class="middle"></div>
						<div class="right_border"></div>
					</div>
					<div class="clear_float"></div>
				</div>
			</div>
			<script type="text/javascript">
				dojo.addOnLoad(function() { 
					parseWidget("WC_PromotionCodeDisplay_span_${status.count}");
				});
			</script>
		</c:forEach>
	</div>
	<br clear="left" />
</form>
<!-- END PromotionCodeDisplay.jsp -->
