require_relative 'template_utility'

module RLiferayTool
  class PreparePortletService
    attr_reader :template_directory, :target_directory, :template_variables

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
      template_utility = TemplateUtility.new(self.template_directory + '/portlet.xml.erb', self.target_directory, 'portlet.xml', self.template_variables)
    end

    def generate_plugin_package_properties
      template_utility = TemplateUtility.new(
          self.template_directory + '/liferay-plugin-package.properties.erb',
          self.target_directory, 'liferay-plugin-package.properties',
          self.template_variables)
    end

    def generate_view_jsp
      template_utility = TemplateUtility.new(
          self.template_directory + '/view.jsp.erb',
          self.target_directory, 'view.jsp',
          self.template_variables)
    end

    def generate_init_jsp
      template_utility = TemplateUtility.new(
          self.template_directory + '/init.jsp.erb',
          self.target_directory, 'init.jsp',
          self.template_variables)
    end

    def generate_edit_jsp
      template_utility = TemplateUtility.new(
          self.template_directory + '/edit.jsp.erb',
          self.target_directory, 'edit.jsp',
          self.template_variables)
    end

    def generate_add_jsp
      template_utility = TemplateUtility.new(
          self.template_directory + '/add.jsp.erb',
          self.target_directory, 'add.jsp',
          self.template_variables)
    end

    def generate_controller
      template_utility = TemplateUtility.new(
          self.template_directory + '/PortletController.java.erb',
          self.target_directory, 'PortletController.java',
          self.template_variables)
    end

    def generate_local_impl
      template_utility = TemplateUtility.new(
          self.template_directory + '/ListItemLocalServiceImpl.java.erb',
          self.target_directory, 'ListItemLocalServiceImpl.java',
          self.template_variables)
    end

  end
end