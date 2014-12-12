require 'thor'
require 'nokogiri'

require_relative 'r_liferay_tool/prepare_portlet_service'
require_relative 'r_liferay_tool/read_service'

class RLiferayTool < Thor
  
  desc "update_portlet_service", "Generate code files from a Liferay Service xml file."
  method_option :project_name, :type => :string, :required => true, :desc => "You must enter a name for the project"
  method_option :project_version, :type => :string, :required => true, :desc => "You must enter a project version"
  #method_option :service_xml_file, :type => :string, :required => true, :desc => "Specify the location of the service.xml file in your project"
  #method_option :platform, :aliases => "-p", :type => :string, :required => true, :default => 'rails', :desc => "Choose which platform you are targeting for code generation."
  default_task :update_portlet_service

  def update_portlet_service()
    has_error=false

    template_directory = base_directory + '/r_liferay_tool/portlet_service_templates'
    target_directory = Dir.pwd + "/#{options[:project_name]}/#{options[:project_name]}-portlet"

    service_xml = target_directory + "/src/main/webapp/WEB-INF/service.xml"
    read_service = ReadService.new(service_xml)

    template_variables = read_service.entities[read_service.entities.keys[0]]
    template_variables['project_name'] = options[:project_name]
    template_variables['project_version'] = options[:project_version]

    base_directory = File.expand_path File.dirname(__FILE__)

    prepare_portlet_service = PreparePortletService.new(template_directory, target_directory, template_variables)

    if has_error
     return
    else

    end
  end






  private




  def say_error(error)
    say 'Internal RLiferayTool Error', :red
    say '-------------------------', :red
    say error.message, :red
    unless error.backtrace.nil?
      error.backtrace.each do | line |
        say line, :red
      end
    end
  end
end

