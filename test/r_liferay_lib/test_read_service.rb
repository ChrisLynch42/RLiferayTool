require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/r_liferay_lib/read_service'

module RLiferayTool
  class TestReadService < Minitest::Test

    def setup
      @test_object = ReadService.new(TestFiles::SERVICE_XML)
      @test_class_constant = ReadService
    end

    def teardown
    end

    def test_entities
      entity_name = 'ChatResponse'

      assert_equal(true,@test_object.entities.include?(entity_name),"Did not find Foo entity")
      assert_equal('responseId',@test_object.entities[entity_name]['primary_key'],"Did not find primary key responseId")
      column_name='title'
      assert_equal(true,@test_object.entities[entity_name]['columns'].include?(column_name),"Did not find column #{column_name}")
      assert_equal('String',@test_object.entities[entity_name]['columns'][column_name].column_type,"Did not find column #{column_name}'s type which is String")

      column_name='companyId'
      assert_equal(false,@test_object.entities[entity_name]['columns'].include?(column_name),"Did not find column #{column_name}")

    end

  end
end
