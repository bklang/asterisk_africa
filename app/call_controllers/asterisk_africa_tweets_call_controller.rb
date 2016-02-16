class AsteriskAfricaTweetsCallController < Adhearsion::CallController
  def run
    tweets = Twitter.user_timeline 'asterisk_africa'
    answer
    say tweets.first.text
  end
end

