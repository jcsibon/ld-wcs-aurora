<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  * This JSP segment displays the checkout address entry form for an unregistered user
  * for the following countries/regions:
  *  - Taiwan
  * The display order is as follows (* means mandatory):
  *  - last name*
  *  - first name
  *  - country/region*
  *  - state/province*
  *  - city*
  *  - zip/postal code*
  *  - address*
  *  - phone
  *  - email*
  *****
--%>
<!-- BEGIN UnregisteredCheckoutAddressEntryForm_TW.jsp-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../Common/EnvironmentSetup.jspf"%>

<c:set var="formName" value="${param.formName}"/>
<c:set var="pageName" value="${param.pageName}"/>
<c:set var="address" value="${param.address}"/>
<c:set var="paramPrefix" value="${param.paramPrefix}"/>
<c:set var="divNum" value="${param.divNum}"/>

<%@ include file="../Member/Address/AddressHelperCountrySelection.jspf" %>

<div id="WC_${formName}_requiredfield_div_1" class="denote_required_field">
	<span class="required-field"  id="WC_${formName}_requiredfield_div_2"> *</span>
	<fmt:message bundle="${storeText}" key="REQUIRED_FIELDS"/>
</div>

<div class="label_spacer" id="WC_${formName}_nickName_div_3">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}nickName'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="AB_RECIPIENT"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>

	<span class="required-field" id="WC_${formName}_nickName_div_4"> *</span>
	<fmt:message bundle="${storeText}" key="AB_RECIPIENT"/>
	</div>

<div id="WC_${formName}_nickName_div_5">
	<c:choose>
		<c:when test="${!empty addressId && addressId != -1}" >
			<input type="hidden" name="addressId" value="<c:out value='${addressId}' />" id="WC_${formName}_nickName_inputs_1"/>
			<input type="text" readonly="true" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}nickName'/>" name="nickName" size="35" class="form_input" value="<c:out value="${contact.nickName}"/>" />
		</c:when>
		<c:otherwise>
			<input type="text" aria-required="true" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}nickName'/>" name="nickName" size="35" class="form_input" value="" />
		</c:otherwise>
	</c:choose>
</div>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		AddressHelper.setStateDivName("<c:out value="stateDiv${divNum}"/>");
	});
</script>


<%-- last name --%>
<div class="label_spacer" id="WC_${formName}_lastName_div_6">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}lastName_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="LAST_NAME"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>
	<span class="required-field" id="WC_${formName}_lastName_div_7"> *</span>
	<fmt:message bundle="${storeText}" key="LAST_NAME"/></div>
<div id="WC_${formName}_lastName_div_8">
	<input type="text" aria-required="true" name="lastName" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}lastName_1'/>" size="35" class="form_input" value="<c:out value='${contact.lastName}'/>" />
</div>


<%-- first name --%>
<div class="label_spacer" id="WC_${formName}_firstName_div_9">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}firstName_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="FIRST_NAME"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>
	<fmt:message bundle="${storeText}" key="FIRST_NAME"/></div>
<div id="WC_${formName}_firstName_div_10">
	<input type="text" name="firstName" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}firstName_1'/>" size="35" class="form_input" value="<c:out value='${contact.firstName}'/>" />
</div>


<%-- country/region --%>
<div class="label_spacer" id="WC_${formName}_country_div_11">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}country_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT_COUNTRY2_ACCE">
		<fmt:param>${address}</fmt:param>
	</fmt:message>
	</label>
	</span>
	<span class="required-field" id="WC_${formName}_country_div_12"> *</span>
	<fmt:message bundle="${storeText}" key="COUNTRY2"/></div>
<div id="WC_${formName}_country_div_13">
	<c:set var="lang" value="${locale}" />
	<c:set var="country_language_select" value="${fn:split(lang, '_')}" />
	<select aria-required="true" name="country" size="1" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}country_1'/>" class="drop_down_country" onkeydown="saveTabPress(event)" onblur="setFocus('WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1')" onchange="javascript:AddressHelper.loadStatesUI('<c:out value='${formName}'/>','<c:out value='${paramPrefix}'/>','<c:out value='${paramPrefix}stateDiv${divNum}'/>','<c:out value="WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1"/>')">
		<c:forEach var="country" items="${countryBean.countries}">
			<option value="<c:out value='${country.code}'/>" 
				<c:choose>
					<c:when test="${!empty contact.country}">
						<c:if test="${country.code eq contact.country || country.displayName eq contact.country}">
							selected="selected"
							<c:set var="country1" value="${contact.country}"/>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${country.code eq country_language_select[1]}">
							selected="selected"
							<c:set var="country1" value="${country.code}"/>
						</c:if>
					</c:otherwise>
				</c:choose>

			>
				<c:out value="${country.displayName}"/>
			</option>
		</c:forEach>
	</select>
</div>


<%-- state/province --%>
<div class="label_spacer" id="WC_${formName}_state_div_14">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="REG_STATE"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>
	<span class="required-field" id="WC_${formName}_state_div_15"> *</span>
	<fmt:message bundle="${storeText}" key="REG_STATE"/>
</div>

<div id="<c:out value='${paramPrefix}stateDiv${divNum}'/>">
<c:set var="key1" value="store/${WCParam.storeId}/country/country_state_list+${langId}+${country1}"/>
<c:set var="countryBean" value="${cachedOnlineStoreMap[key1]}"/>
<c:if test="${empty countryBean}">
	<wcf:rest var="countryBean" url="store/{storeId}/country/country_state_list" cached="true">
		<wcf:var name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="countryCode" value="${country1}"/>
	</wcf:rest>
	<wcf:set target = "${cachedOnlineStoreMap}" key="${key1}" value="${countryBean}"/>
</c:if>

<c:choose>
	<c:when test="${!empty countryBean.countryCodeStates}">
		<select aria-required="true" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1'/>" name="state" class="drop_down_country">
			<c:forEach var="state" items="${countryBean.countryCodeStates}">
				<option value="<c:out value='${state.code}'/>" 
					<c:if test="${state.code eq contact.state || state.displayName eq contact.state}">
						selected="selected"
					</c:if>
				>
					<c:out value="${state.displayName}"/>
				</option>
			</c:forEach>
		</select>
	</c:when>
	<c:otherwise>
		<input type="text" aria-required="true" name="state" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1'/>" size="35" class="form_input" value="<c:out value='${contact.state}'/>" />
	</c:otherwise>
</c:choose>
</div>


<%-- city --%>
<div class="label_spacer" id="WC_${formName}_city_div_16">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}city_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="CITY2"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>
	<span class="required-field" id="WC_${formName}_city_div_17"> *</span>
	<fmt:message bundle="${storeText}" key="CITY2"/></div>
<div id="WC_${formName}_city_div_18">
	<input type="text" aria-required="true" name="city" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}city_1'/>" size="35" class="form_input" value="<c:out value='${contact.city}'/>" />
</div>


<%-- zipcode --%>
<div class="label_spacer" id="WC_${formName}_zipCode_div_19">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}zipCode_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="ZIP_CODE"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>
	<span class="required-field" id="WC_${formName}_zipCode_div_20"> *</span>
	<fmt:message bundle="${storeText}" key="ZIP_CODE"/></div>
<div id="WC_${formName}_zipCode_div_21">
	<input type="text" aria-required="true" name="zipCode" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}zipCode_1'/>" size="35" class="form_input" value="<c:out value='${contact.zipCode}'/>" />
</div>


<%-- address --%>
<div class="label_spacer" id="WC_${formName}_address1_div_22">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}address1_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="STREET_ADDRESS_LINE_1"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>
	<span class="required-field" id="WC_${formName}_address1_div_23"> *</span>
	<fmt:message bundle="${storeText}" key="STREET_ADDRESS"/></div>
<div id="WC_${formName}_address1_div_24">
	<input type="text" aria-required="true" name="address1" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}address1_1'/>" size="35" class="form_input" value="<c:out value='${contact.addressLine[0]}'/>" />
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}address2_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="STREET_ADDRESS_LINE_2"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>
	<input type="text" name="address2" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}address2_1'/>" size="35" class="form_input" value="<c:out value='${contact.addressLine[1]}'/>" />
</div>


<%-- phone --%>
<div class="label_spacer" id="WC_${formName}_phone1_div_25">
<span class="spanacce">
<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}phone1_1'/>">
<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="PHONE_NUMBER2"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
</span>
<fmt:message bundle="${storeText}" key="PHONE_NUMBER2"/></div>
<div id="WC_${formName}_phone1_div_26">
	<input type="tel" name="phone1" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}phone1_1'/>" size="35" class="form_input" value="<c:out value='${contact.phone1}'/>" />
</div>


<%-- email --%>
<div class="label_spacer" id="WC_${formName}_email1_div_27">
	<span class="spanacce">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}email1_1'/>">
	<fmt:message bundle="${storeText}" key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT2">
	<fmt:param><fmt:message bundle="${storeText}" key="EMAIL"/></fmt:param>
	<fmt:param>${address}</fmt:param></fmt:message>
	</label>
	</span>
	<span class="required-field" id="WC_${formName}_email1_div_28"> *</span>
	<fmt:message bundle="${storeText}" key="EMAIL"/></div>
<div id="WC_${formName}_email1_div_29">
	<input type="text" aria-required="true" name="email1" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}email1_1'/>" size="35" class="form_input" value="<c:out value='${contact.email1}'/>" />
</div>
<!-- END UnregisteredCheckoutAddressEntryForm_TW.jsp-->
