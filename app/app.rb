class App < Adhearsion::Plugin
  config :app do
    twitter_consumer_key nil, desc: "Twitter Consumer Key (API Key)"
    twitter_consumer_secret nil, desc: "Twitter Consumer Secret (API Secret)"
    twitter_access_token nil, desc: "Twitter Access Token"
    twitter_access_token_secret nil, desc: "Twitter Access Token Secret"
  end
end
