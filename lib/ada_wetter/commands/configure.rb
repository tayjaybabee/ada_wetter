module AdaWetter
  module Configure

    def self.start_wizard
      require 'ada_wetter/commands/configure/wizard'
      wiz = AdaWetter::Configure::Wizard
      wiz.new
    end

  end
end