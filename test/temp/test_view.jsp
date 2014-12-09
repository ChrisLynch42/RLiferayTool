<%@include file="/init.jsp" %>

<portlet:renderURL var="addItemURL">
  <portlet:param name="jspPage" value="/add.jsp" />
  <portlet:param name="backURL" value="${currentURL}" />
</portlet:renderURL>

<a href="${addItemURL}">Add Item</a>

<liferay-ui:search-container searchContainer="${searchContainer}" >
  <liferay-ui:search-container-results
  results="${searchContainer.results}"
  total="${searchContainer.total}"
  />

  <liferay-ui:search-container-row
  className="mil.army.hrc.ikrome.test.model.ChatResponse"
  keyProperty="responseId"
  modelVar="item"
  >
    <liferay-ui:search-container-column-text
    name="name"
    property="raviName"
    />
    <liferay-ui:search-container-column-text
    name="Quantity"
    property="###quantity###"
    />

    <liferay-ui:search-container-column-text
    name="Description"
    property="jamieDescription"
    />
    <liferay-ui:search-container-column-text
    name="actions"
    >
      <liferay-ui:icon-menu >
        <portlet:renderURL var="updateItemURL">
          <portlet:param name="itemId" value="${item.responseId}" />
          <portlet:param name="itemName" value="${item.raviName}" />
          <portlet:param name="itemDescription" value="${item.jamieDescription}" />
          <portlet:param name="itemQuantity" value="${item.###quantity###}" />
          <portlet:param name="backURL" value="${currentURL}" />
          <portlet:param name="jspPage" value="/edit.jsp" />
        </portlet:renderURL>
        <liferay-ui:icon image="edit" message="edit" url="${updateItemURL}" />
        <portlet:actionURL name="deleteItem" var="deleteItemURL">
          <portlet:param name="item-id" value="${item.responseId}" />
          <portlet:param name="redirect" value="${currentURL}" />
        </portlet:actionURL>
        <liferay-ui:icon-delete url="${deleteItemURL}" />
      </liferay-ui:icon-menu>
    </liferay-ui:search-container-column-text>

  </liferay-ui:search-container-row>

  <liferay-ui:search-iterator />

</liferay-ui:search-container>