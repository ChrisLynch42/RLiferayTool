require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/r_liferay_tool/prepare_portlet_service'
require_relative '../../lib/r_liferay_tool/read_service'

module RLiferayTool
  class TestPreparePortletService < Minitest::Test

    def setup
      clean_up
      build_up
    end

    def teardown
      clean_up
    end

    def test_generate_portlet_xml_content
      assert_equal(true,File.exist?(TestFiles::TEMP_PORTLET_XML),"Portlet.xml file is missing.")
      portlet_xml_content = File.read(TestFiles::TEMP_PORTLET_XML)
      assert_equal(true,portlet_xml_content.include?("mil.army.hrc.ikrome.#{@template_variables['project_name']}"),"Portlet xml file content was not updated.")
    end

    def test_generate_plugin_package_properties
      assert_equal(true,File.exist?(TestFiles::TEMP_PLUGIN_PACKAGE_FILE),"Plugin properites file is missing.")
      properties_content = File.read(TestFiles::TEMP_PLUGIN_PACKAGE_FILE)
      assert_equal(true,properties_content.include?("name=#{@template_variables['project_name']}"),"Plugin properties file content was not updated.")
    end

    def test_generate_view_jsp
      assert_equal(true,File.exist?(TestFiles::TEMP_VIEW_JSP),"View.jsp file is missing.")
      properties_content = File.read(TestFiles::TEMP_VIEW_JSP)
      check_value = "keyProperty=\"responseId\""
      assert_equal(true,properties_content.include?(check_value),"View.jsp file content was not updated.  #{check_value}")
    end


    private

    def build_up
      @target_name = 'test_view.jsp'
      @target_file_name = TestFiles::TEMP_DIR + '/' + @target_name
      read_service = ReadService.new(TestFiles::SERVICE_XML)
      @template_variables = read_service.entities[read_service.entities.keys[0]]
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
