Gem::Specification.new do |s|
  s.name = 'ada-wetter'
  s.version = '1.0.0'
  s.date = '2019-07-20'
  s.summary = "Our simple CLI"
  s.description = "Our very very simple CLI"
  s.authors = [ "Taylor-Jayde J. Blackstone" ]
  s.email = 'tayjaybabee@gmail.com'
  s.files = Dir.glob("{bin,lib}/**/*")
  s.files += Dir['[A-Z]*'] + Dir['test/**/*']
  s.require_paths = ["lib"]
  s.executables << 'ada_wetter'
  s.add_dependency 'clipboard'
  s.add_dependency 'commander'
  s.add_dependency 'launchy'
  s.add_dependency 'rake'
  s.add_dependency 'tty-prompt'
end
