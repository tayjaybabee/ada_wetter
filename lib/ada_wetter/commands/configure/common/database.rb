# :category: Configuration
#

module AdaWetter::Application::Configure::Database

  @default_filepath = '../conf/settings.conf'

  def self.readout(config: nil, file: @default_filepath)
    require 'tty-config'
    conf = TTY::Config.new
    if config.nil?
      if File.exist?(file)
        conf = conf.read(file)
      else
        false
      end
    else
      config
    end
  end

  def self.create
    require 'tty-config'
    require 'ada_wetter/commands/configure/common/conf_structs/settings'
    require 'fileutils'
    p Dir.pwd
    FileUtils.mkpath("#{Dir.pwd}/../conf")
    settings = AdaWetter::Application::Configure::Database::Settings.temp_settings
    config = TTY::Config.coerce(settings)
    config.filename = settings[:settings_file]
    config.extname = settings[:settings_ext]
    config.to_h
    config.write("#{Dir.pwd}/../conf/settings.conf")

    p readout(config: config)

  end

  def self.check_file
    if readout
      return true
    else
      return false
    end

  end

  def self.write(conf)
    conf.write()
  end

end
