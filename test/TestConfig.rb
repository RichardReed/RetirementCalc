# This file uses the set_config_override to test values are put in the
# @config hash.

require 'yaml'
require 'test/unit'
require_relative '../lib/Config'

class TestConfigFile < Test::Unit::TestCase
  def setup
    @config_file = ConfigFile.new
    @config_file.set_config_override({
          :test_config_entry => "some value"})
    @config_file.config
  end

  def config_file_value
    return @config_file.config[:test_config_entry]
  end

  def test_config_file
    assert_equal("some value", config_file_value)
  end
end
