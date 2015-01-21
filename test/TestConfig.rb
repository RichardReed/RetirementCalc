# This file tests the use of set_config_override to test values outside the 
# the spreadsheet.

require 'yaml'
require 'test/unit'
require_relative '../lib/Config'
 
class TestConfigFile< Test::Unit::TestCase
  def setup
    ConfigFile.set_config_override({ :test_config_entry => "some value" }) 
    @config_hash = ConfigFile.instance
  end
 
  def config_file_value
    return @config_hash.config[:test_config_entry]
  end

  def test_config_file
    assert_equal("some value", config_file_value)
  end
end
