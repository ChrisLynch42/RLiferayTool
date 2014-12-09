require 'erb'

module RLiferayTool
  class TemplateUtility
    attr_accessor :content


    def initialize(template_path, target_name, target_directory, template_variables )
      run_erb(template_path, target_name, target_directory, template_variables)
    end


    private
    attr_writer :content

    def run_erb(template_path, target_name, target_directory, template_variables)
      write_template_results(target_directory + '/' + target_name,erb_output(template_path,template_variables))
    end

    def erb_output(template_name,template_variables=Hash.new())
      template_content = load_template(template_name)
      template = ERB.new(template_content)
      template_results = template.result(binding)
      puts 'xxx'
      puts template_results
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
        File.delete(file_name)
      end
      File.open(file_name,'w') { |file|
        file.write(template_results)
      }
    end
  end
end