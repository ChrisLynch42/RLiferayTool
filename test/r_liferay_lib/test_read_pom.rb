require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/r_liferay_lib/read_pom'

module RLiferayLib
  class TestReadPOM < Minitest::Test

    def setup
      @test_object = ReadPOM.new(TestFiles::POM_XML)
      @test_class_constant = ReadPOM
    end

    def teardown
    end

    def test_version
      version = '3.00.000'

      assert_equal(true,@test_object.version.include?(version),"Did not vind the version")
    end

  end
end
