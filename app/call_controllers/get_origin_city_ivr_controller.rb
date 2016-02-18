require 'helpers/ivr_helpers'
require 'call_controllers/get_flight_number_ivr_controller'

class GetOriginCityIVRController < Adhearsion::IVRController
  include IVRHelpers
  AIRPORTS = {
    'FAOR' => ['Johannesburg', 'Joeburg', 'O. R. Tambo International'],
  }
  prompts << -> { t(:say_departure_city) }

  on_complete do |result|
    airport = result.interpretation[:airport]
    logger.debug "Selected airport #{airport}"
    
    ident = "#{metadata[:airline]}#{metadata[:fltnum]}"
    logger.info "Searching for flight #{ident} departing from #{airport}"
    flights = FlightAware.get_data :flight_info, ident: ident
    

    if flight = find_flight_by_origin(flights, airport)
      logger.warn flight.inspect
      departure_time = DateTime.strptime flight[:filed_departuretime], "%s"
      play success_message(AIRPORTS[airport].first, flight[:destination_name], departure_time)
    else
      say t(:could_not_find_flight)
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

private

  def find_flight_by_origin(flights, origin)
    flights[:flight_info_results][:flight_info_result][:flights].detect do |flight|
      flight[:origin] == origin
    end
  end

  def success_message(from, to, time)
    ssml = t(:flight_is_departing) +
    RubySpeech::SSML.draw { string from } +
    t(:for) +
    RubySpeech::SSML.draw { string to } +
    t(:at_time) +
    RubySpeech::SSML.draw { string time.strftime("%H:%M") }
    # Workaround for https://github.com/benlangfeld/ruby_speech/issues/37
    ssml['xml:lang'] = call[:locale]
    ssml
  end
end

