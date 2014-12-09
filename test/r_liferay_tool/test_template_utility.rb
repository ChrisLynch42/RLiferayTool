require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/r_liferay_tool/read_service'
require_relative '../../lib/r_liferay_tool/template_utility'

module RLiferayTool
  class TestTemplateUtility < Minitest::Test

    def setup
      read_service = ReadService.new(TestFiles::SERVICE_XML)
      template_variables = read_service.entities[read_service.entities.keys[0]]
      @target_name = 'test_view.jsp'
      @test_object = TemplateUtility.new(TestFiles::VIEW_JSP, @target_name , TestFiles::TEMP_DIR, template_variables)
      @test_class_constant = TemplateUtility
    end

    def teardown
      #FileUtils.remove(TestFiles::TEMP_PORTLET_XML)
    end

    def test_erb_results
      File.exist?(TestFiles::TEMP_DIR + '/' + @target_name)
    end

  end
end
