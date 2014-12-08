module RLiferayTool
  class PreparePortlet
    attr_reader :project_name, :project_package, :portlet_xml_file, :xml_utility, :plugin_package_properties_file

    def initialize(portlet_xml_file, plugin_package_properties_file, project_name, project_package)
      self.portlet_xml_file=portlet_xml_file
      self.plugin_package_properties_file=plugin_package_properties_file
      self.project_name=project_name
      self.project_package=project_package
      self.xml_utility = XMLUtility.new(self.portlet_xml_file)
      update_portlet_xml_content
      update_plugin_package_properties
    end


    def portlet_class_content
      "mil.army.hrc.ikrome.#{self.project_name.downcase}.PortletController"
    end

    def plugin_package_properties_text
      "portal-dependency-jars=\\\n" +
          "    jstl-api.jar,\\\n" +
          "    jstl-impl.jar,\\\n" +
          "    commons-lang.jar\n"
    end

    private
    attr_writer :project_name, :project_package, :portlet_xml_file, :xml_utility, :plugin_package_properties_file

    def update_portlet_xml_content
      portlet_class_node = xml_utility.xml_content.at_xpath('/portlet-app/portlet/portlet-class')
      portlet_class_node.inner_html = portlet_class_content
      xml_utility.write_xml_content
    end

    def update_plugin_package_properties
      if File.exist? self.plugin_package_properties_file
        f = nil
        begin
          f = File.open(self.plugin_package_properties_file,"ab")
          f.write plugin_package_properties_text
        ensure
          f.close()
        end
      end
    end

  end
end