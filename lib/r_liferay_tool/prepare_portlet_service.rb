require_relative 'template_utility'

module RLiferayTool
  class PreparePortletService
    attr_reader :template_directory, :target_directory, :template_variables

    def initialize(template_directory, target_directory, template_variables)
      self.template_directory=template_directory
      self.target_directory=target_directory
      self.template_variables=template_variables
      generate_portlet_xml
      generate_plugin_package_properties
      generate_view_jsp
    end




    private
    attr_writer :template_directory, :target_directory, :template_variables

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



  end
end