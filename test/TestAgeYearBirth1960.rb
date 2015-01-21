require 'test/unit'
require_relative '../lib/AgeYear'

class TestAgeYearBirth1960 < Test::Unit::TestCase

  def setup
    ConfigFile.set_config_override({ 'birth_year' => 1960 })
  end

  def test_is_age
    assert_equal(54, 2014.is_age)
  end

  def test_is_year
    assert_equal(2020, 60.is_year)
  end
end
