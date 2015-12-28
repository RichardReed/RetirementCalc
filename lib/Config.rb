# Opens Config.yml file and loads the config hash
 
require 'yaml'
 
class ConfigFile
    @@override = nil 
 
    def set_config_override (hash)
      @@override = hash               
      return @@override
    end                                
 
    def config
        @config ||= @@override || YAML.load(File.open('Config.yml')) 
    end
end
