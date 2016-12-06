require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ''
  config.consumer_secret = ''
  config.access_token = ''
  config.access_token_secret = ''
end


SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    today = Time.now.strftime("%-d")
    yesterday = today.to_i - 1
    tweet = twitter.search("#{today}/25 OR #{yesterday}/25 #AdvenTale from:MicroSFF").first
    if tweet
      send_event('adventale', text: tweet.text)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end
