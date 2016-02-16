# encoding: utf-8
%w{
  asterisk_africa_tweets_call
  get_airline_ivr
}.each {|cc| require "call_controllers/#{cc}_controller"}

Adhearsion.router do

  # Specify your call routes, directing calls with particular attributes to a controller
  route 'Speak A Tweet', AsteriskAfricaTweetsCallController, to: /tweet/
  route 'Check Flight Status', GetAirlineIVRController, to: /flight/

  route 'default' do
    answer
    say "Hello World!"
  end
end
