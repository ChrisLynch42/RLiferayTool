require 'minitest/autorun'
require_relative '../test_helper'
require_relative 'buildup_mixin'
require_relative 'cleanup_mixin'
require_relative '../../lib/r_liferay_tool'

module RLiferayLib
  class TestPreparePortletService < Minitest::Test
    include RLiferayLib::BuildupMixin
    include RLiferayLib::CleanupMixin

    def setup
      clean_up
      build_up
    end

    def teardown
      clean_up
    end

    def test_command_line
      RLiferayTool.start
    end



  end
end
