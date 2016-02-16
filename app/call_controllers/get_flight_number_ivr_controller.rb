require 'helpers/ivr_helpers'
require 'call_controllers/get_origin_city_ivr_controller'

class GetFlightNumberIVRController < Adhearsion::IVRController
  include IVRHelpers
  prompts << "Say your flight number"
  
  def grammar_url
    [
      cached_url_for(voice_grammar.to_s, 'application/srgs+xml'),
      cached_url_for(dtmf_grammar.to_s, 'application/srgs+xml')
    ]
  end

  on_complete do |result|
    fltnum = result.interpretation[:fltnum]
    logger.info "Selected flight number #{fltnum}"
    pass GetOriginCityIVRController, airline: metadata[:airline], fltnum: fltnum
  end


  def voice_grammar
    RubySpeech::GRXML.draw root: 'fltnum_voice', mode: :voice, language: 'en-US', tag_format: 'semantics/1.0.2006' do
      rule id: :digit do
        one_of do
          item do
            one_of do
              item { string 'zero' }
              item { string 'oh' }
            end
            tag { string 'out = "0"' }
          end
          item { string 'one';   tag { string 'out = "1"' } }
          item { string 'two';   tag { string 'out = "2"' } }
          item { string 'three'; tag { string 'out = "3"' } }
          item { string 'four';  tag { string 'out = "4"' } }
          item { string 'five';  tag { string 'out = "5"' } }
          item { string 'six';   tag { string 'out = "6"' } }
          item { string 'seven'; tag { string 'out = "7"' } }
          item { string 'eight'; tag { string 'out = "8"' } }
          item { string 'nine';  tag { string 'out = "9"' } }
        end
      end

      rule id: 'fltnum_voice', scope: :public do
        tag { string 'out.fltnum = ""' }
        item repeat: '1-5' do
          ruleref uri: '#digit'
          tag { string 'out.fltnum += rules.latest()' }
        end
      end
    end
  end

  def dtmf_grammar
    RubySpeech::GRXML.draw root: 'fltnum_dtmf', mode: :dtmf, language: 'en-US', tag_format: 'semantics/1.0.2006' do
      rule id: :digit do
        one_of do
          item { string '0'; tag { string 'out = "1"' } }
          item { string '1'; tag { string 'out = "1"' } }
          item { string '2'; tag { string 'out = "2"' } }
          item { string '3'; tag { string 'out = "3"' } }
          item { string '4'; tag { string 'out = "4"' } }
          item { string '5'; tag { string 'out = "5"' } }
          item { string '6'; tag { string 'out = "6"' } }
          item { string '7'; tag { string 'out = "7"' } }
          item { string '8'; tag { string 'out = "8"' } }
          item { string '9'; tag { string 'out = "9"' } }
        end
      end

      rule id: 'fltnum_dtmf', scope: :public do
        tag { string 'out.fltnum = ""' }
        item repeat: '1-5' do
          ruleref uri: '#digit'
          tag { string 'out.fltnum += rules.latest()' }
        end
      end
    end
  end
end
