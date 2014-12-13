require 'thor'
require 'nokogiri'

require_relative 'r_liferay_lib/prepare_portlet_service'
require_relative 'r_liferay_lib/read_service'
require_relative 'r_liferay_lib/read_pom'

class RLiferayTool < Thor
  
  desc "update_portlet_service", "Generate code files from a Liferay Service xml file."
  #method_option :project_name, :type => :string, :required => true, :desc => "You must enter a name for the project"
  #method_option :project_version, :type => :string, :required => true, :desc => "You must enter a project version"
  #method_option :service_xml_file, :type => :string, :required => true, :desc => "Specify the location of the service.xml file in your project"
  #method_option :platform, :aliases => "-p", :type => :string, :required => true, :default => 'rails', :desc => "Choose which platform you are targeting for code generation."
  default_task :update_portlet_service

  def update_portlet_service()

    has_error=false

    base_directory = f = File.expand_path File.dirname(__FILE__)

    project_name = File.basename(Dir.pwd)

    target_directory = project_name + '-portlet'

    pom_file = './pom.xml'

    if !Dir.exist? target_directory
      has_error = true
      say "You are not in a Liferay portlet service directory.", :red
    end

    if !File.exist? pom_file
      has_error = true
      say "You are not in a valid maven project directory.", :red
    end


    template_directory = base_directory + '/r_liferay_lib/portlet_service_templates'

    service_xml = target_directory + "/src/main/webapp/WEB-INF/service.xml"



    if has_error
      return
    else
      read_service = RLiferayLib::ReadService.new(service_xml)
      read_pom = RLiferayLib::ReadPOM.new(pom_file)


      template_variables = read_service.entities[read_service.entities.keys[0]]
      template_variables['project_name'] = project_name
      template_variables['project_version'] = read_pom.version
      prepare_portlet_service = RLiferayLib::PreparePortletService.new(template_directory, target_directory, template_variables)
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

