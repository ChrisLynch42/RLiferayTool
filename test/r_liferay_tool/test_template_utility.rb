require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/r_liferay_tool/read_service'
require_relative '../../lib/r_liferay_tool/template_utility'

module RLiferayTool
  class TestTemplateUtility < Minitest::Test

    def setup
      @target_name = 'test_view.jsp'
      @target_file_name = TestFiles::TEMP_DIR + '/' + @target_name
      clean_up
      read_service = ReadService.new(TestFiles::SERVICE_XML)
      @template_variables = read_service.entities[read_service.entities.keys[0]]
      @template_variables['project_name'] = 'test'
      @test_object = TemplateUtility.new(TestFiles::VIEW_JSP, @target_name , TestFiles::TEMP_DIR, @template_variables)
      @test_class_constant = TemplateUtility
    end

    def teardown
      #clean_up
    end

    def test_erb_results
      assert_equal(true,File.exist?(@target_file_name),"File #{@target_file_name} was not created.")
      begin
        f = File.open(@target_file_name)
        contents = f.read

        string_contained = "mil.army.hrc.ikrome.#{@template_variables['project_name']}.model.ChatResponse"
        assert_equal(true,contents.include?(string_contained),"File did not contain #{string_contained}")

        string_contained = 'keyProperty="responseId"'
        assert_equal(true,contents.include?(string_contained),"File did not contain #{string_contained}")

        string_contained = 'value="${item.responseId}"'
        assert_equal(true,contents.include?(string_contained),"File did not contain #{string_contained}")
      ensure
        f.close()
      end
    end


    private
    def clean_up
      if File.exist?(@target_file_name)
        FileUtils.remove(@target_file_name)
      end
    end

  end
end
