require 'yaml'

module DBOX
  Config = YAML::load File.read(DBOX::CONF_PATH.join('config.yml').to_s)

  def config
    Config
  end

end
