require 'helpers/ivr_helpers'
require 'call_controllers/get_flight_number_ivr_controller'

class GetOriginCityIVRController < Adhearsion::IVRController
  include IVRHelpers
  AIRPORTS = {
    'FAOR' => ['Johannesburg', 'Joeburg', 'O. R. Tambo International'],
  }
  prompts << "Say the name of the city from which you are departing"

  on_complete do |result|
    airport = result.interpretation[:airport]
    logger.info "Selected airport #{airport}"
    
    ident = "#{metadata[:airline]}#{metadata[:fltnum]}"
    flights = FlightAware.get_data :flight_info, ident: ident
    
    flight = flights[:flight_info_results][:flight_info_result][:flights].detect do |flight|
      flight[:origin] == airport
    end

    if flight
      logger.warn flight.inspect
      #departure_time = DateTime.strptime flight[:filed_departuretime], "%s"

      say "Your flight is leaving #{AIRPORTS[airport].first} for #{flight[:destination_name]}"
    else
      say "Sorry, I could not find your flight."
    end
  end


  def grammar_url
    [cached_url_for(voice_grammar.to_s, 'application/srgs+xml')]
  end

  def voice_grammar
    RubySpeech::GRXML.draw root: 'get_airport', mode: :voice, language: 'en-US', tag_format: 'semantics/1.0.2006' do
      rule id: 'get_airport' do
        one_of do
          AIRPORTS.each_pair do |icao, names|
            item do
              one_of do
                names.each do |name|
                  item { string name }
                end
              end
              tag { string %Q{out.airport = "#{icao}"} }
            end
          end
        end
      end
    end
  end
end

