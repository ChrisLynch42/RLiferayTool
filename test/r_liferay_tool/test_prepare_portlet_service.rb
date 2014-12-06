require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/r_liferay_tool/prepare_portlet_service'
require_relative '../../lib/r_liferay_tool/xml_utility'

module RLiferayTool
  class TestPreparePortletService < Minitest::Test

    def setup
      FileUtils.copy_file(TestFiles::PORTLET_XML,TestFiles::TEMP_PORTLET_XML)
      FileUtils.copy_file(TestFiles::PLUGIN_PACKAGE_FILE,TestFiles::TEMP_PLUGIN_PACKAGE_FILE)
      @test_object = PreparePortletService.new(TestFiles::TEMP_PORTLET_XML, TestFiles::TEMP_PLUGIN_PACKAGE_FILE,'test','test.subtest')
      @test_class_constant = PreparePortletService
    end

    def teardown
      FileUtils.remove(TestFiles::TEMP_PORTLET_XML)
      FileUtils.remove(TestFiles::TEMP_PLUGIN_PACKAGE_FILE)

    end

    def test_update_portlet_xml_content
      portal_class_node = @test_object.xml_utility.xml_content.at_xpath('/portlet-app/portlet/portlet-class')
      assert_equal(@test_object.portlet_class_content,portal_class_node.inner_html,"Portal-class node has the wrong inner content")
      assert_equal(true,File.exist?(TestFiles::TEMP_PORTLET_XML),"XML content file missing.")
      xml_content = File.read(TestFiles::TEMP_PORTLET_XML)
      assert_equal(true,xml_content.include?(@test_object.portlet_class_content),"XML file content was not updated.")
    end

    def test_update_plugin_package_properties
      assert_equal(true,File.exist?(TestFiles::TEMP_PLUGIN_PACKAGE_FILE),"Plugin properites file is missing.")
      properties_content = File.read(TestFiles::TEMP_PLUGIN_PACKAGE_FILE)
      assert_equal(true,properties_content.include?(@test_object.plugin_package_properties_text),"Plugin properties file content was not updated.")
    end

  end
end
