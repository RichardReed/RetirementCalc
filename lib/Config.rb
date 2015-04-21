# Opens Config.yml file and loads the config hash
 
require 'yaml'
require 'singleton'
 
class ConfigFile
    attr_reader :config
    include Singleton
    @@override = nil 
 
    def self.set_config_override (hash)
      @@override = hash               
    end                                
 
    def initialize
        @config = @@override || YAML.load(File.open('CONFIG.yml')) 
    end
end
