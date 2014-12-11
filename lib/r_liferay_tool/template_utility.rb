require 'erb'
require 'active_support/all'

module RLiferayTool
  class TemplateUtility
    attr_accessor :content


    def initialize(template_path, target_directory, target_name, template_variables )
      run_erb(template_path, target_name, target_directory, template_variables)
    end


    private
    attr_writer :content

    def run_erb(template_path, target_name, target_directory, template_variables)
      target_file_name = target_directory + '/' + target_name
      write_template_results(target_file_name,erb_output(template_path,template_variables))
    end

    def erb_output(template_name,template_variables=Hash.new())
      template_content = load_template(template_name)
      template = ERB.new(template_content)
      template_results = template.result(binding)
      template_results
    end

    def load_template(template_name)
      if File.exists?(template_name)
        file = File.open(template_name)
        contents=file.read()
      end
    end

    def write_template_results(file_name,template_results)
      if File.exist?(file_name)
        backup_file(file_name)
      end
      File.open(file_name,'w') { |file|
        file.write(template_results)
      }
    end

    def backup_file(file_name)
      FileUtils.mv(file_name,file_name + '.' + Time.now.strftime("%Y%m%d%H%M%S%L"), :force => true)
    end
  end
end