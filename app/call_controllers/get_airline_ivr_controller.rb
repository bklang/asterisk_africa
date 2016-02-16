require 'helpers/ivr_helpers'
require 'call_controllers/get_flight_number_ivr_controller'

class GetAirlineIVRController < Adhearsion::IVRController
  include IVRHelpers
  AIRLINES = {
    'DAL' => ['Delta', 'Delta Air Lines'],
    'UAL' => ['United', 'United Air Lines'],
    'SWA' => ['Southwest'],
    'BAW' => ['British Airways']
  }
  prompts << -> { t(:say_airline) }

  on_complete do |result|
    airline = result.interpretation[:airline]
    logger.info "Selected airline #{airline}"
    pass GetFlightNumberIVRController, airline: airline
  end

  def grammar_url
    [cached_url_for(voice_grammar.to_s, 'application/srgs+xml')]
  end

  def voice_grammar
    RubySpeech::GRXML.draw root: 'get_airline', mode: :voice, language: 'en-US', tag_format: 'semantics/1.0.2006' do
      rule id: 'get_airline' do
        one_of do
          AIRLINES.each_pair do |icao, names|
            item do
              one_of do
                names.each do |name|
                  item { string name }
                end
              end
              tag { string %Q{out.airline = "#{icao}"} }
            end
          end
        end
      end
    end
  end
end
