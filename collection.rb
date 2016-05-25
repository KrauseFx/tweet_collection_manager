module TweetCollectionManager
  class Collection
    require 'twitter'
    require 'excon'

    attr_accessor :client
    attr_accessor :collection_id

    def initialize(collection_id: nil)

      @collection_id = collection_id
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["CONSUMER_KEY"]
        config.consumer_secret     = ENV["CONSUMER_SECRET"]
        config.access_token        = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
      end
    end

    def add_tweet(tweet_id)
      # e.g. 
      # https://api.twitter.com/1.1/collections/entries/add.json?tweet_id=390890231215292416&id=custom-388061495298244609
      path = "https://api.twitter.com/1.1/collections/entries/add.json"
      body = {
        tweet_id: tweet_id,
        id: "custom-#{collection_id}"
      }
      
      r = Twitter::REST::Request.new(self.client, :post, path, body)
      response = r.perform
      raise response[:response][:errors].to_s if response[:response][:errors].count > 0
    end
  end
end
