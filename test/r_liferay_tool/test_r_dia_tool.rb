require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/r_liferay_tool'

module RLiferayTool
  class TestPreparePortletService < Minitest::Test

    def setup
      clean_up
      build_up
    end

    def teardown
    end

    def test_command_line
    end



    private

    def build_up
      @target_name = 'test_view.jsp'
      @target_file_name = TestFiles::TEMP_DIR + '/' + @target_name
      read_service = ReadService.new(TestFiles::SERVICE_XML)
      @template_variables['project_name'] = 'test'
      @template_variables['project_version'] = '1.00.000'
      @test_object = PreparePortletService.new(TestFiles::TEMPLATE_DIR, TestFiles::TEMP_DIR , @template_variables)
      @test_class_constant = PreparePortletService
    end


    def clean_up
      Dir[TestFiles::TEMP_DIR + '/*'].each { | file_name |
        File.delete(file_name)
      }
    end
  end
end
