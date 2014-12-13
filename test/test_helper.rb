require_relative '../lib/r_liferay_lib/prepare_portlet_service'

class TestFiles

  TEMP_DIR = './test/temp'

  TEMPLATE_DIR = './lib/r_liferay_lib/portlet_service_templates/'

  WEB_INF_DIR = TEMP_DIR + '/' + RLiferayLib::PreparePortletService::WEB_INF_DIR
  JSP_DIR = TEMP_DIR + '/' + RLiferayLib::PreparePortletService::JSP_DIR
  JAVA_DIR = TEMP_DIR + '/' + RLiferayLib::PreparePortletService::JAVA_DIR

  PORTLET_XML = './test/portlet.xml'
  TEMP_PORTLET_XML = "#{WEB_INF_DIR}/portlet.xml"

  TEMP_PLUGIN_PACKAGE_FILE = "#{WEB_INF_DIR}/liferay-plugin-package.properties"

  TEMP_VIEW_JSP = "#{JSP_DIR}/view.jsp"
  TEMP_INIT_JSP = "#{JSP_DIR}/init.jsp"
  TEMP_EDIT_JSP = "#{JSP_DIR}/edit.jsp"
  TEMP_ADD_JSP = "#{JSP_DIR}/add.jsp"

  SERVICE_XML = './test/service.xml'

  POM_XML = './test/pom.xml'

  VIEW_JSP = './lib/r_liferay_lib/portlet_service_templates/view.jsp.erb'
  INIT_JSP = './lib/r_liferay_lib/portlet_service_templates/init.jsp.erb'

end


