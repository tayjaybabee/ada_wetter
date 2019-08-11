# AdaWetter

AdaWetter is an applet that is part of the ADAhome automation suite. This applet fetches local weather data (as well as weather for any location you desire) as well as data from your ADAhome sensePods and aggrigates it all into either a headless display or a gui.

# Developers

I recommend using RVM as your Ruby environment if you are in Linux. You can follow the installation instructions found on the RVM site (https://rvm.io/rvm/install) OR you can follow my instructions below. **Note to Ubuntu users!**: The install instructions on the page (https://rvm.io/rvm/install) instruct you to add a PPA and install RVM using the package manager (apt). **I advise against this** as I've had no luck with this method of installation, though I will keep trying.

## Install RVM

Here is how I install RVM (paraphrasing from RVM's site: https://rvm.io/rvm/install):

1. Install RVM GPG key 
```shell
    ~$: gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E37D2BAF1CF37B13E2069D6956105BD0E739499BDB
```
2. Install RVM 
```shell
  ~$: \curl -sSL https://get.rvm.io | bash
```
     
3. Configure shell for RVM
```shell
  ~$: source ~/.rvm/scripts/rvm
```

4. Test RVM installation
```shell
  ~$: type rvm | head -n 1
        #=> rvm is a function
```
  If you return anything else, RVM is not functioning properly. Please see their page for more details: https://get.rvm.io
  
  Otherwise....
    
5. Install ruby 2.5 (for dev this is only acceptable version until others are tested)
  ```shell
     ~$: rvm install 2.5
   ```
   
6. Install bundler (if not already installed)
  ```shell
    ~$: gem install bundler
  ```
   
## Clone AdaWetter & Install Dependancies


1. ```shell
     ~$: git clone https://github.com/tayjaybabee/ada_wetter.git
   ```
  
2. ```shell
     ~$: cd ada_wetter
   ```
  
3. ```shell
     ~/ada_wetter$: bundle install
   ```
   
   Once this is done all dependancies will be installed! You will now be able to run the program in it's current state by doing:
   
   ```shell
     ~/ada_wetter$: bin/ada_wetter
   ```
   
## Note to developers:

* You can build ada_wetter as a gem by doing:
  ```shell
    ~/ada_wetter$: gem build ada_wetter
  ```
  
* You can build yard documentation for ada_wetter by doing
  ```shell
    ~/ada_wetter$: yard doc
  ```
    * If the above doesn't work, maybe yard isn't installed?
      ```shell
        ~$: gem install yard
      ```
    * Run doc server on localhost:
      ```shell
        ~/ada_wetter$: yard server
      ```
      Then navigate to the place it tells you in your browser




# To Install?

You may have luck navigating to the root directory and running 

'gem install ada-wetter-1.0.0.gem'

Building another gem package will probably break it.



----


# AdaWetter

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ada_wetter`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ada_wetter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ada_wetter

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ada_wetter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the AdaWetter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ada_wetter/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2019 Taylor-Jayde Blackstone. See [MIT License](LICENSE.txt) for further details.
