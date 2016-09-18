# This file uses the set_config_override to test having a nil value in the 
# @config hash.

require 'yaml'
require 'test/unit'
require_relative '../lib/Config'
 
class TestConfigFile < Test::Unit::TestCase
  def setup
    @config_file = ConfigFile.new
    @config_file.set_config_override({ 
          :test_config_entry => "some value",
          :test_nil_entry => nil }) 
  end
 
  def test_config_file_nil
    assert_nil(@config_file.config)
  end
end
