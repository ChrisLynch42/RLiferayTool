require_relative 'template_utility'

module RLiferayTool
  class PreparePortletService
    attr_reader :template_directory, :target_directory, :template_variables

    WEB_INF_DIR = '/src/main/webapp/WEB-INF'
    JSP_DIR = '/src/main/webapp/html'
    JAVA_DIR = 'src/main/java/mil/army/hrc/ikrome'


    def initialize(template_directory, target_directory, template_variables)
      self.template_directory=template_directory
      self.target_directory=target_directory
      self.template_variables=template_variables
      generate_properties
      generate_jsps
      generate_java
    end

    private
    attr_writer :template_directory, :target_directory, :template_variables

    def generate_jsps
      generate_view_jsp
      generate_init_jsp
      generate_edit_jsp
      generate_add_jsp
    end

    def generate_java
      generate_controller
      generate_local_impl
    end

    def generate_properties
      generate_portlet_xml
      generate_plugin_package_properties
    end

    def generate_portlet_xml
      template_utility = TemplateUtility.new(self.template_directory + '/portlet.xml.erb', self.target_directory + WEB_INF_DIR, 'portlet.xml', self.template_variables)
    end

    def generate_plugin_package_properties
      template_utility = TemplateUtility.new(
          self.template_directory + '/liferay-plugin-package.properties.erb',
          self.target_directory + WEB_INF_DIR, 'liferay-plugin-package.properties',
          self.template_variables)
    end


    def generate_jsp_files
      jsp_target = self.target_directory + HTML
      generate_view_jsp(jsp_target)
      generate_init_jsp(jsp_target)
      generate_edit_jsp(jsp_target)
      generate_add_jsp(jsp_target)
    end

    def generate_view_jsp(jsp_target)
      template_utility = TemplateUtility.new(
          self.template_directory + '/view.jsp.erb',
          jsp_target,
          'view.jsp',
          self.template_variables)
    end

    def generate_init_jsp(jsp_target)
      template_utility = TemplateUtility.new(
          self.template_directory + '/init.jsp.erb',
          jsp_target,
          'init.jsp',
          self.template_variables)
    end

    def generate_edit_jsp(jsp_target)
      template_utility = TemplateUtility.new(
          self.template_directory + '/edit.jsp.erb',
          jsp_target,
          'edit.jsp',
          self.template_variables)
    end

    def generate_add_jsp(jsp_target)
      template_utility = TemplateUtility.new(
          self.template_directory + '/add.jsp.erb',
          jsp_target,
          'add.jsp',
          self.template_variables)
    end


    def generate_java_files
      java_target = self.target_directory + JAVA_DIR + "/#{self.template_variables['project_name']}"
    end

    def generate_controller(java_target)
      template_utility = TemplateUtility.new(
          self.template_directory + '/PortletController.java.erb',
          java_target + '/portlet',
          'PortletController.java',
          self.template_variables)
    end

    def generate_local_impl(java_target)
      template_utility = TemplateUtility.new(
          self.template_directory + '/ListItemLocalServiceImpl.java.erb',
          java_target + '/service/impl',
          'ListItemLocalServiceImpl.java',
          self.template_variables)
    end

  end
end