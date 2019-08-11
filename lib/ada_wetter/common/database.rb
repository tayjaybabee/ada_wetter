require 'ada_wetter/commands/configure'
require 'ada_wetter/cli'

# :category: Configuration
#

module AdaWetter::Application::Configure::Database
  include AdaWetter
  
  if $ADA_VERBOSE
    @verbose = true
  else
    @verbose = false
  end
  
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

  def self.create(dir="#{Dir.pwd}/../conf/", file='settings', ext='.conf')
    require 'tty-config'
    require 'ada_wetter/common/conf_structs/settings'
    require 'fileutils'
    
    @prompt.say "Received command to make default config file: #{file}" if @verbose
    
    @prompt.say 'Creating directory...' if @verbose
    @prompt.ok "Created #{dir}" if @verbose
    
    @prompt.say "Creating config file: #{file}#{ext}" if @verbose
    @prompt.say 'Creating hash structure using default settings as a template' if @verbose
    settings = AdaWetter::Application::Configure::Database::Settings.temp_settings
    @prompt.ok "Success! Loaded default configuration structure: #{settings}" if @verbose
    begin
      
      set_file = "#{file}#{ext}"
      
      raise "mismatch error" if set_file != def_file
      
      config = TTY::Config.coerce(settings)
      config.filename = settings[:settings_file]
      config.extname = settings[:settings_ext]
      
      config.to_h
      config.write("#{Dir.pwd}/../conf/settings.conf")
      
    rescue "mismatch error"
      @prompt.error 'For now you must use the following for the filename: settings.conf'
      abort 'Please try again using the proper name schema'
      
    end
    

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
