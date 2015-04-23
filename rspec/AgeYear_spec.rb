require_relative '../lib/AgeYear.rb'
require_relative '../lib/Config.rb'

module AgeYear
  describe "is_age," do
    describe "converts birth_year to age," do
      context "with birth year of 1960," do
       # ConfigFile.set_config_override 'birth_year' => 1960
        ConfigFile.set_config_override birth_year: 1960
        it "returns age of 5 in 1965" do
          expect(1965.is_age).to eq(5)
        end
        it "returns age of 60 in 2020" do
          expect(2020.is_age).to eq(60)
        end
      end
      context "with birth year of 2010" do
        let (:fake_config) {ConfigFile.instance.config}
      #ConfigFile.set_config_override 'birth_year' => 2010
        it "returns age of 8 in 2018" do
puts "fake_config is: #{fake_config}"
          #stub_const("ConfigFile", Class.new)
          stub_const(fake_config, {birth_year: 2010})
puts "asigned fake_config is: #{fake_config}"
          #stub_const("ConfigFile.instance.config", {birth_year: 2010})
          #stub_const("ConfigFile.instance.config[:birth_year]", 2010)
          expect(2018.is_age).to eq(8)
        end
        #it "returns age of 65 in 2075" do
        #  stub_const(ConfigFile.instance.config{birth_year: 2010}
        #  expect(2075.is_age).to eq(65)
        #end
      end
    end
  end
  describe "is_year" do
    it "converts age to birth_year" do
    end
  end
end
