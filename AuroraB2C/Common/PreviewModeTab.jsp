<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN PreviewModeTab.jspf -->


<%@ include file= "/Widgets_701/Common/EnvironmentSetup.jspf" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>

<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.context.content.ContentContext" %>
<%@ page import="com.ibm.commerce.context.preview.PreviewContext" %>
<%@ page import="com.ibm.commerce.tools.segmentation.SegmentDataBean" %>

<fmt:setBundle var="sp" basename="com.ibm.commerce.stores.preview.properties.StorePreviewer"/>

<%
CommandContext pmt_commandContext = (CommandContext) request.getAttribute("CommandContext");
PreviewContext pmt_previewContext = (PreviewContext) pmt_commandContext.getContext(PreviewContext.CONTEXT_NAME);
Pattern pmt_p = Pattern.compile(".*\\[preview time = (.*) \\| isStatic = (.*) \\| other data = (.*) \\| dirty = (.*)\\]");
Matcher pmt_m = pmt_p.matcher(pmt_previewContext.toString());
String pmt_start = null;
String pmt_status = null;
if (pmt_m.matches()) {
	pmt_start = pmt_m.group(1);
	pmt_status = pmt_m.group(2);
}
SimpleDateFormat pmt_sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
pageContext.setAttribute("pmt_start", (pmt_start == null || pmt_start.length() == 0 || pmt_start.equals("null") ? pmt_previewContext.getTimestamp() : pmt_sdf.parse(pmt_start)));
pageContext.setAttribute("pmt_status", (pmt_status == null || pmt_status.length() == 0 ? Boolean.FALSE : Boolean.valueOf(pmt_status)));

String pmt_includedMemberGroupIds = pmt_previewContext.getProperty("previewIncludedMemberGroupIds");
String pmt_includedMemberGroupNames = "";
if (pmt_includedMemberGroupIds != null && pmt_includedMemberGroupIds.length() != 0) {
	try {
		StringTokenizer pmt_st = new StringTokenizer(pmt_includedMemberGroupIds, ",");
		for (int i = 0; pmt_st.hasMoreElements(); i++) {
			SegmentDataBean pmt_segmentDataBean = new SegmentDataBean();
			pmt_segmentDataBean.setCommandContext(pmt_commandContext);
			pmt_segmentDataBean.setId(pmt_st.nextToken());
			pmt_segmentDataBean.populate();
			if (i > 0) {
				pmt_includedMemberGroupNames += ", ";
			}
			String pmt_memberGroupName = pmt_segmentDataBean.getSegmentDisplayName();
			if (pmt_memberGroupName == null || pmt_memberGroupName.length() == 0) {
				pmt_memberGroupName = pmt_segmentDataBean.getSegmentName();
			}
			pmt_includedMemberGroupNames += pmt_memberGroupName;
		}
	} catch (Exception e) {
	}
}
%>

<script>
	function showPreviewModeAlert() {
		document.getElementById("previewModeDialog").style.display = "block";
	}
	
	function hidePreviewModeAlert() {
		document.getElementById("previewModeDialog").style.display = "none";
	}
	function handlePreviewDialogTab(event, object) {
		if (event.keyCode == dojo.keys.TAB) {
			event.preventDefault ? event.preventDefault() : event.returnValue = false;
			if (object.id == "sp_close_button") {
				document.getElementById('closePreviewModeDialogButton').focus();
			} else if (object.id == "closePreviewModeDialogButton") {
				document.getElementById('sp_close_button').focus();
			}
		}
	}
</script>

<div class="previewModeTab" role="region" aria-label="<fmt:message key='previewModeTabTitle' bundle='${sp}'/>">
	<div class="pmt_button">
		<div class="pmt_left"></div>
		<a id="previewModeTab_Text" class="pmt_middle" href="javascript:void(0);" onclick="showPreviewModeAlert(); document.getElementById('sp_close_button').focus();" role="button"><fmt:message key='previewModeTabTitle' bundle='${sp}'/></a>
		<div class="pmt_right"></div>
	</div>
	<c:choose>
		<c:when test="${CommandContext.locale == 'iw_IL' || CommandContext.locale == 'ar_EG'}">
			<link rel="stylesheet" type="text/css" href="${staticAssetContextRoot}/tools/preview/css/store_preview_bidi.css"></link>
		</c:when>
		<c:otherwise>
			<link rel="stylesheet" type="text/css" href="${staticAssetContextRoot}/tools/preview/css/store_preview.css"></link>
		</c:otherwise>
	</c:choose>
	
	<div id="previewModeDialog" role="dialog" aria-labelledby="sp_header_text" class="store_preview_dialog_window" style="display: none; z-index: 250;">
		<div class="sp_header_top">
			<div class="sp_header">
				<span id="sp_header_text"><fmt:message key="previewModeTabTitle" bundle="${sp}"/></span>
				<a id="sp_close_button" onkeydown="handlePreviewDialogTab(event, this);" role="button" title="<fmt:message key='storePreviewCloseBtnText' bundle='${sp}'/>" aria-label="<fmt:message key='storePreviewCloseBtnText' bundle='${sp}'/>" id='closePreviewModeDialog' href='javascript:hidePreviewModeAlert();document.getElementById("previewModeTab_Text").focus();'>
					<img onmouseover="this.src='${staticAssetContextRoot}/images/preview/storepreview_window_close_icon_hover.png'"
						onmouseout="this.src='${staticAssetContextRoot}/images/preview/storepreview_window_close_icon.png'"
						onmousedown="this.src='${staticAssetContextRoot}/images/preview/storepreview_window_close_icon_press.png'"
						src="${staticAssetContextRoot}/images/preview/storepreview_window_close_icon.png" alt=""/>
				</a>
			</div>
			<div class="sp_whitespace_background">
				<div class="sp_content_container">
					<strong class="sp_bold"><fmt:message key='previewModeTabMessage' bundle='${sp}'/></strong><br/>
					<strong class="sp_bold"><fmt:message key='storePreviewStartTimeMsg' bundle='${sp}'/></strong> <fmt:formatDate value='${pmt_start}' type='both'/>
					<c:choose>
						<c:when test="${pmt_status}">
							<br/><strong class="sp_bold"><fmt:message key='storePreviewTimeStatus' bundle='${sp}'/></strong> <fmt:message key='storePreviewTimeStatusStatic' bundle='${sp}'/>
						</c:when>
						<c:otherwise>
							<br/><strong class="sp_bold"><fmt:message key='storePreviewTimeStatus' bundle='${sp}'/></strong> <fmt:message key='storePreviewTimeStatusRolling' bundle='${sp}'/> - <fmt:formatDate value='${previewContext.timestamp}' type='both'/>
						</c:otherwise>
					</c:choose>
					<br/><strong class="sp_bold"><fmt:message key='storePreviewInvStatusTitle' bundle='${sp}'/></strong>
					<c:choose>
						<c:when test="${previewContext.properties['previewInventory'] == '-1'}">
							<fmt:message key='storePreviewInvStatusDupWthCnst' bundle='${sp}'/>
						</c:when>
						<c:when test="${previewContext.properties['previewInventory'] == '1'}">
							<fmt:message key='storePreviewInvStatusDupWthoutCnst' bundle='${sp}'/>
						</c:when>
						<c:otherwise>
							<fmt:message key='storePreviewInvStatusReal' bundle='${sp}'/>
						</c:otherwise>
					</c:choose>
					<c:if test="${!empty previewContext.properties['previewIncludedMemberGroupIds']}">
						<br/><strong class="sp_bold"><fmt:message key='storePreviewCustomerSegments' bundle='${sp}'/></strong> <%= pmt_includedMemberGroupNames %>
					</c:if>
				</div>
				<div class="sp_optionsContainer"> 
					<div class="sp_rightContainer">
						<a role="button"
							aria-labelledby="closePreviewModeButtonLeft"
							id="closePreviewModeDialogButton"
							class="sp_light_button"
							href="javascript:void(0);"
							onkeydown="handlePreviewDialogTab(event, this);"
							onclick="hidePreviewModeAlert();document.getElementById('previewModeTab_Text').focus();">
							<div id="closePreviewModeButtonLeft" class="sp_button_text"><fmt:message key='storePreviewCloseBtnText' bundle='${sp}'/></div>
							<div id="closePreviewModeButtonRight" class="sp_button_right"></div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- END PreviewModeTab.jspf -->
