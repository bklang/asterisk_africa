class FlightAware
  include Singleton

  class Plugin < Adhearsion::Plugin
    config :flight_aware do
      api_username nil, desc: "API Username for FlightAware FlightXML 2.0"
      api_key nil, desc: "API Key for FlightAware FlightXML 2.0"
    end
  end

  def initialize
    opts = {
      wsdl: 'http://flightxml.flightaware.com/soap/FlightXML2/wsdl',
      basic_auth: [Adhearsion.config.flight_aware.api_username, Adhearsion.config.flight_aware.api_key]
    }
    @client = Savon::Client.new opts
  end

  def get_data(method, body)
    @client.call(method, message: body).to_hash
  end

  def self.method_missing(m, *args, &block)
    instance.send m, *args, &block
  end
end
