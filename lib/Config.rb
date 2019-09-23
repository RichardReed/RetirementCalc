# Opens Config.yml file and loads the config hash into $CONFIG
# if it does not already exist
# Writes to the command line if the hash is missing a value.

require 'yaml'

class ConfigFile
  @@override = nil

  def set_config_override (hash)
    @@override = hash
    return @@override
  end

  def config
    @config ||= @@override || YAML.load(File.open('Config.yml'))

    if /=>nil/ =~ @config.to_s
    else
      $CONFIG = @config
      return $CONFIG
    end
  end
end
