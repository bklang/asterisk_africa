# encoding: utf-8
require 'call_controllers/asterisk_africa_tweets_call_controller'

Adhearsion.router do

  # Specify your call routes, directing calls with particular attributes to a controller
  route 'Speak A Tweet', AsteriskAfricaTweetsCallController, to: /tweet/

  route 'default' do
    answer
    say "Hello World!"
  end
end
