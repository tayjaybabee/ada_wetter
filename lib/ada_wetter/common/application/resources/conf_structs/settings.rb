module AdaWetter
  class Application
    
    # Module that contains a template for the settings.conf file that will need to be created on first-run or for subsequent
    # updates
    #
    # @author Taylor-Jayde J. Blackstone <t.blackstone@inspyre.tech>
    # @since 0.1.0.4
    module Settings
      
      @temp_set = { settings: {
        terminal_control: false,
        conf_path:        '../conf/',
        settings_file:    'settings',
        settings_ext:     '.conf',
        mindsync:         {
          enabled?:  false,
          client_id: nil
        },
        darksky_api_key:  nil,
        user_info:        {
          name:             {
            first:  nil,
            middle: nil,
            last:   nil,
            title:  nil
            
          },
          contact:          {
            phone:            nil,
            phone2:           nil,
            mobile:           nil,
            mobile_type:      'SMSonly',
            email:            nil,
            email2:           nil,
            email_marketing:  false,
            email_newsletter: false
          },
          has_pass:         false,
          has_account:      false,
          password:         nil,
          demographic_data: {
            shared:         false,
            birthdate:      nil,
            age:            nil,
            gender:         nil,
            marital_status: nil
          },
        },
        home_data:        {
          home1: {
            name:                        'home',
            residents_adult:             1,
            residents_children:          0,
            storeys:                     1,
            main:                        true,
            premise_plugins:             'AdaWetter',
            address_same_as_weather:     true,
            unique_id:                   nil,
            date_added:                  nil,
            weather_info:                {
              location:       nil,
              default_format: 'ext_5day'
            },
            smrt_tstat:                  {
              has:         true,
              count:       1,
              smrt_tstat1: {
                name:     'living room',
                brand:    'nest',
                model:    'v2',
                settings: {}
              }
            }
          },
          connected_external_services: {}
        }
      }
      }
      
      
      
      def self.temp_settings
        LOG.message self, 'Found template file...'
        @temp_set
        LOG.message self, 'Found settings template!', 'ok'
        LOG.message self, "#{@temp_set}"
        return @temp_set
      end
    
    end
  end
end
