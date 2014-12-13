require 'minitest/autorun'
require_relative '../test_helper'
require_relative 'buildup_mixin'
require_relative 'cleanup_mixin'
require_relative '../../lib/r_liferay_lib/read_service'
require_relative '../../lib/r_liferay_lib/template_utility'

module RLiferayLib
  class TestTemplateUtility < Minitest::Test
    include RLiferayLib::CleanupMixin
    include RLiferayLib::BuildupMixin


    def setup
      clean_up
      build_up
    end

    def teardown
      clean_up
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

    def test_file_backup
      assert_equal(true,File.exist?(@target_file_name),"File #{@target_file_name} was not created.")
      build_up
      assert_equal(true,Dir[@target_file_name + '\.[0-9]*'].length > 0, 'Did not find any backed up files.')
    end


    private

    def build_up
      _build_up
      @target_name = 'test_view.jsp'
      @target_file_name = TestFiles::TEMP_DIR + '/' + @target_name
      read_service = ReadService.new(TestFiles::SERVICE_XML)
      @template_variables = read_service.entities[read_service.entities.keys[0]]
      @template_variables['project_name'] = 'test'
      @test_object = TemplateUtility.new(TestFiles::VIEW_JSP, TestFiles::TEMP_DIR, @target_name , @template_variables)
      @test_class_constant = TemplateUtility
    end

  end
end
