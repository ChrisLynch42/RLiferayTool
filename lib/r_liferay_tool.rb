require 'thor'
require 'nokogiri'

class RLiferayTool < Thor
  
  desc "update_portlet_service", "Generate code files from a Liferay Service xml file."
  method_option :service_xml_file, :type => :string, :required => true, :desc => "Specify the location of the service.xml file in your project"
  #method_option :platform, :aliases => "-p", :type => :string, :required => true, :default => 'rails', :desc => "Choose which platform you are targeting for code generation."
  default_task :update_portlet_service

  def update_portlet_service()
    has_error=false

    #copy options to use in various subclasses
    application_options = Hash.new()
    options.each do | key, value |
      application_options[key.to_sym]=value
    end
    #puts options[:service_xml_file]


    read_service = ReadService.new(service_xml_file)
    @template_variables = read_service.entities[read_service.entities.keys[0]]
    @template_variables['project_name'] = 'test'
    @template_variables['project_version'] = '1.00.000'
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

