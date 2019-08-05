module AdaWetter::Application::Configure::Database

  @default_filepath = '../conf/settings.yml'

  def self.readout(file=@default_filepath)
    require 'yaml'
    if File.exist?(file)
      YAML.load(File.read(file))
    else
      false
    end

  end

  def self.create()
    require 'tty-config'
    require 'ada_wetter/commands/configure/common/conf_structs/settings'
    settings = AdaWetter::Configure::Database::Settings.temp_settings
    config = TTY::Config.coerce(settings)
    config.filename = settings[:settings_file]
    config.extname = settings[:settings_ext]
    config.to_h
    config.write('../conf/settings.yml')
    p readout

  end

  def self.check_file
    if readout
      return true
    else
      return false
    end

  end


end
