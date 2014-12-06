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

    puts get_service_xml(options[:service_xml_file]).to_s

    if has_error
     return
    else
      puts 'Do something here'
    end
  end



  desc "prepare_portlet_service", "Add additional files to Liferay portlet service project."
  method_option :portlet_xml_file, :type => :string, :required => true, :desc => "Specify the location of the portlet.xml file in your project"
  method_option :project_name, :type => :string, :required => true, :desc => "Specify the name of the project"
  method_option :project_package, :type => :string, :required => true, :desc => "Specify the package name for the project"
  def prepare_portlet_service()
    has_error=false

    # begin
    #   f = File.open(service_xml_file_location)
    #   dia_xml = Nokogiri::XML(f)
    # rescue
    #   say "Error reading service xml", :red
    # ensure
    #   f.close()
    # end


    if has_error
      return
    else
      puts 'Do something here prepare_portlet_service'
    end
  end



  private
  def run_controller(dia_xml,application_options)
    begin
      template_controller = RDiaLib::Database::TemplateController.new(dia_xml,application_options)
      template_controller.execute_template()
      say "RLiferayTool #{application_options[:model]} Model completed successfully.", :green
    rescue => error
      say_error(error)
    end
  end



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

