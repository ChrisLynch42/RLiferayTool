require 'minitest/autorun'
require_relative '../test_helper'
require_relative 'cleanup_mixin'
require_relative 'buildup_mixin'
require_relative '../../lib/r_liferay_lib/prepare_portlet_service'
require_relative '../../lib/r_liferay_lib/read_service'

module RLiferayLib
  class TestPreparePortletService < Minitest::Test
    include RLiferayLib::CleanupMixin
    include RLiferayLib::BuildupMixin



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

    def test_generate_init_jsp
      assert_equal(true,File.exist?(TestFiles::TEMP_INIT_JSP),"Init.jsp file is missing.")
      properties_content = File.read(TestFiles::TEMP_INIT_JSP)
      check_value = "mil.army.hrc.ikrome.test.service.ChatResponseLocalServiceUtil"
      assert_equal(true,properties_content.include?(check_value),"Init.jsp file content was not updated.  #{check_value}")
    end

    def test_generate_edit_jsp
      assert_equal(true,File.exist?(TestFiles::TEMP_EDIT_JSP),"Edit.jsp file is missing.")
      properties_content = File.read(TestFiles::TEMP_EDIT_JSP)
      check_value = 'aui:input type="number" name="createdByUserId" label="createdByUserId" value="${param.createdByUserId}"'
      assert_equal(true,properties_content.include?(check_value),"Edit.jsp file content was not updated.  #{check_value}")
    end

    def test_generate_add_jsp
      assert_equal(true,File.exist?(TestFiles::TEMP_ADD_JSP),"Add.jsp file is missing.")
      properties_content = File.read(TestFiles::TEMP_ADD_JSP)
      check_value = 'aui:input type="text" name="firstContent" label="firstContent"'
      assert_equal(true,properties_content.include?(check_value),"Add.jsp file content was not updated.  #{check_value}")
    end

    def test_generate_controller
      file_name = @java_portlet_path + '/' + RLiferayLib::PreparePortletService::CONTROLLER_NAME
      assert_equal(true,File.exist?(file_name),"Controller class file is missing.")
      properties_content = File.read(file_name)
      check_value = 'List<ChatResponse> allItems = ChatResponseLocalServiceUtil.getChatResponses(QueryUtil.ALL_POS, QueryUtil.ALL_POS);'
      assert_equal(true,properties_content.include?(check_value),"Controller class file content was not updated.  #{check_value}")
    end

    def test_generate_local_impl
      file_name = "#{@java_service_path}/#{@template_variables['name']}#{RLiferayLib::PreparePortletService::LOCAL_IMPL_NAME}"
      assert_equal(true,File.exist?(file_name),"Local impl class file is missing.")
      properties_content = File.read(file_name)
      check_value = "add#{@template_variables['name']}"
      assert_equal(true,properties_content.include?(check_value),"Local impl class file content was not updated.  #{check_value}")
    end


    def build_up
      _build_up
      read_service = ReadService.new(TestFiles::SERVICE_XML)
      @template_variables = read_service.entities[read_service.entities.keys[0]]
      @template_variables['name'] = read_service.entities.keys[0]
      @template_variables['project_name'] = 'test'
      @template_variables['project_version'] = '1.00.000'

      @java_portlet_path=TestFiles::JAVA_DIR + '/' + @template_variables['project_name'].downcase + '/portlet'
      @java_service_path=TestFiles::JAVA_DIR + '/' + @template_variables['project_name'].downcase + '/service/impl'

      FileUtils.mkpath(@java_portlet_path)
      FileUtils.mkpath(@java_service_path)


      @test_object = PreparePortletService.new(TestFiles::TEMPLATE_DIR, TestFiles::TEMP_DIR , @template_variables)
      @test_class_constant = PreparePortletService
    end

  end
end
