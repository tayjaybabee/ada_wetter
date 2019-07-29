module AdaWetter
  module Configure

    def self.start_wizard
      require 'ada_wetter/commands/configure/wizard'
      require 'ada_wetter/commands/configure/common/database'
      wiz = AdaWetter::Configure::Wizard
      wiz.new
    end

  end
end