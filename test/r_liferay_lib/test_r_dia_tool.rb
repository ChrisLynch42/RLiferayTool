require 'minitest/autorun'
require_relative '../test_helper'
require_relative 'cleanup_mixin'
require_relative '../../lib/r_liferay_tool'

module RLiferayLib
  class TestPreparePortletService < Minitest::Test

    def setup
    end

    def teardown
    end

    def test_command_line
      arguments = ['--project-version=1.00.000']
      RLiferayTool.start arguments
    end



    private

    def build_up
    end


  end
end
