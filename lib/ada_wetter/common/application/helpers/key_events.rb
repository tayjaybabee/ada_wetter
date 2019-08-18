=begin
  @File: ada_wetter/common/application/helpers/key_events.rb
  @Author: Taylor-Jayde B. Blackstone <tayjaybabee@gmail.com>
  @Info
=end

module AdaWetter
  class Application
  
    require_relative 'tty-prompt'
  
    prompt = TTY::Prompt::new(interrupt: :exit)
  
    prompt.on(:keypress) do |event|
      puts "name: #{event.key.name}, value: #{event.value.dump}"
    end
  
    prompt.on(:keyescape) do |event|
      exit
    end
  
    prompt.read_keypress
  end
end