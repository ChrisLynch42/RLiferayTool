require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/r_liferay_tool/xml_utility'

module RLiferayTool
  class TestXMLUtility < Minitest::Test

    def setup
      FileUtils.copy_file(TestFiles::PORTLET_XML,TestFiles::TEMP_PORTLET_XML)
      @test_object = XMLUtility.new(TestFiles::TEMP_PORTLET_XML)
      @test_class_constant = XMLUtility
    end

    def teardown
      #FileUtils.remove(TestFiles::TEMP_PORTLET_XML)

    end

    def test_read_file_returns_content
      refute_nil @test_object.xml_content
    end

    def test_write_file
      FileUtils.remove(TestFiles::TEMP_PORTLET_XML)
      assert_equal(false,File.exist?(TestFiles::TEMP_PORTLET_XML),"XML content file was not deleted.")
      @test_object.write_xml_content
      assert_equal(true,File.exist?(TestFiles::TEMP_PORTLET_XML),"XMLUtility did not write file")
    end


  end
end
