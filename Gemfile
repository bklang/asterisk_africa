source 'https://rubygems.org'

#gem 'adhearsion', github: 'adhearsion/adhearsion', branch: :master
gem 'adhearsion', '2.6.2'

# Exercise care when updating the Punchblock major version, since Adhearsion
# apps sometimes make use of underlying features from the Punchblock API.
# Occasionally an update of Adhearsion will necessitate an update to
# Punchblock; in those cases update this line and test your app thoroughly.
gem 'punchblock', '~> 2.7'

# This is here by default due to deprecation of #ask and #menu.
# See http://adhearsion.com/docs/common_problems#toc_3 for details
gem 'adhearsion-asr'
gem 'adhearsion-ivr', github: 'adhearsion/adhearsion-ivr', branch: 'feature/on_response'
gem 'adhearsion-i18n', github: 'adhearsion/adhearsion-i18n', branch: 'feature/use_formatter'
gem 'adhearsion-asterisk'

gem 'virginia', github: 'adhearsion/virginia', branch: 'develop'

gem 'reel-rack', '~> 0.2'
gem 'sinatra', require: false
gem 'sinatra-contrib', require: false

# External data sources
gem 'twitter', '< 5.0'
gem 'savon' # For SOAP APIs

#
# Check http://ahnhub.com for a list of plugins you can use in your app.
# To use them, simply add them here and run `bundle install`.
#

group :development, :test do
  gem 'rspec'
end
