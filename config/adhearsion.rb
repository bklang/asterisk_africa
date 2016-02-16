# encoding: utf-8

Adhearsion.config do |config|

  # Centralized way to specify any Adhearsion platform or plugin configuration
  # - Execute rake config:show to view the active configuration values
  #
  # To update a plugin configuration you can write either:
  #
  #    * Option 1
  #        Adhearsion.config.<plugin-name> do |config|
  #          config.<key> = <value>
  #        end
  #
  #    * Option 2
  #        Adhearsion.config do |config|
  #          config.<plugin-name>.<key> = <value>
  #        end

  config.development do |dev|
    dev.platform.logging.level = :debug
  end

  ##
  # Use with Rayo (eg Voxeo PRISM or FreeSWITCH mod_rayo)
  #
  # config.punchblock.username = "usera@freeswitch.local-dev.mojolingo.com" # Your XMPP JID for use with Rayo
  # config.punchblock.password = "1" # Your XMPP password

  ##
  # Use with Asterisk
  #
  config.punchblock.platform = :asterisk # Use Asterisk
  config.punchblock.username = "manager" # Your AMI username
  config.punchblock.password = "password" # Your AMI password
  config.punchblock.host = "asterisk.local-dev.mojolingo.com" # Your AMI host

  config.platform.media.default_renderer = :unimrcp
  config.adhearsion_asr.recognizer = :unimrcp
end

Twitter.configure do |config|
  app_config = Adhearsion.config.app
  config.consumer_key = app_config.twitter_consumer_key
  config.consumer_secret = app_config.twitter_consumer_secret
  config.oauth_token = app_config.twitter_access_token
  config.oauth_token_secret = app_config.twitter_access_token_secret
end
