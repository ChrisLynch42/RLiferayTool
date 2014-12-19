require_relative 'template_utility'

module RLiferayLib
  class PreparePortletService
    attr_reader :template_directory, :target_directory, :template_variables

    WEB_INF_DIR = '/src/main/webapp/WEB-INF'
    JSP_DIR = '/src/main/webapp/html'
    JAVA_DIR = 'src/main/java/mil/army/hrc/ikrome'
    PLUGIN_PACKAGE_NAME = 'liferay-plugin-package.properties'
    PORTLET_XML_NAME = 'portlet.xml'
    CONTROLLER_NAME = 'PortletController.java'
    LOCAL_IMPL_NAME = 'LocalServiceImpl.java'
    REMOTE_IMPL_NAME = 'ServiceImpl.java'

    def initialize(template_directory, target_directory, template_variables)
      self.template_directory=template_directory
      self.target_directory=target_directory
      self.template_variables=template_variables
      generate_properties
      generate_jsp_files
      generate_java_files
    end

    private
    attr_writer :template_directory, :target_directory, :template_variables

    def generate_properties
      target_directory = self.target_directory + WEB_INF_DIR
      generate_portlet_xml(target_directory)
      generate_plugin_package_properties(target_directory)
    end

    def generate_portlet_xml(target_directory)
      template_utility = TemplateUtility.new(
          self.template_directory + '/portlet.xml.erb',
          target_directory,
          PORTLET_XML_NAME,
          self.template_variables)
    end

    def generate_plugin_package_properties(target_directory)
      template_utility = TemplateUtility.new(
          self.template_directory + '/liferay-plugin-package.properties.erb',
          target_directory,
          PLUGIN_PACKAGE_NAME,
          self.template_variables)
    end


    def generate_jsp_files
      jsp_target = self.target_directory + JSP_DIR
      prepare_directory(jsp_target)
      generate_view_jsp(jsp_target)
      generate_init_jsp(jsp_target)
      generate_edit_jsp(jsp_target)
      generate_add_jsp(jsp_target)
    end

    def generate_view_jsp(jsp_target)
      template_utility = TemplateUtility.new(
          self.template_directory + '/view.jsp.erb',
          jsp_target,
          'view.jsp', self.template_variables)
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
      target_directory = self.target_directory + '/' + JAVA_DIR + "/#{self.template_variables['project_name'].downcase}"
      prepare_directory(target_directory)
      generate_controller(target_directory)
      generate_local_impl(target_directory)
      generate_remote_impl(target_directory)
    end

    def generate_controller(target_directory)
      target_directory = target_directory + '/portlet'
      prepare_directory(target_directory)
      template_utility = TemplateUtility.new(
          self.template_directory + '/PortletController.java.erb',
          target_directory,
          CONTROLLER_NAME,
          self.template_variables)
    end

    def generate_local_impl(target_directory)
      target_directory = target_directory + '/service/impl'
      prepare_directory(target_directory)
      template_utility = TemplateUtility.new(
          self.template_directory + '/ListItemLocalServiceImpl.java.erb',
          target_directory,
          "#{self.template_variables['name']}" + LOCAL_IMPL_NAME,
          self.template_variables)
    end

    def generate_remote_impl(target_directory)
      target_directory = target_directory + '/service/impl'
      prepare_directory(target_directory)
      template_utility = TemplateUtility.new(
          self.template_directory + '/ListItemServiceImpl.java.erb',
          target_directory,
          "#{self.template_variables['name']}" + REMOTE_IMPL_NAME,
          self.template_variables)
    end


    private
      def prepare_directory(directory_path)
        if !Dir.exist? directory_path
          FileUtils.mkpath directory_path
        end
      end

  end
end