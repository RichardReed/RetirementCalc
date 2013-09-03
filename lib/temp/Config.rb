# Opens Config.yml file and loads the config hash

require 'yaml'
require 'singleton'

class ConfigFile
    attr_reader :config
    include Singleton

    def initialize
        @config = YAML.load(File.open('CONFIG.yml'))
    end
end