module AdaWetter::Application::Configure::Database::Settings

  @settings = {
      conf_path: '../conf/',
      settings_file: 'settings',
      settings_ext: '.conf',
      mindsync: {
          enabled?: false,
          client_id: nil,
      },
      weather_info: {
          location: nil,
          api_key: nil,
          default_format: 'ext_5day'
      },
      user_info: {
          name: nil
      }
  }

  def self.temp_settings
    @settings
  end

end