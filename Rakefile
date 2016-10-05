require_relative 'collection.rb'

task :beta do
  raise "Provide a collection id" if ENV["COLLECTION_ID"].to_s.length == 0
  c = TweetCollectionManager::Collection.new(collection_id: ENV["COLLECTION_ID"])

  tweets = File.read("tweets.txt").split("\n")
  tweets.each do |tweet|
    next unless tweet.include?("https://twitter.com")
    tweet_id = tweet.match(/status\/(\d+)\w*/)[1]
    puts "Adding tweet #{tweet_id}"
    begin
      c.add_tweet(tweet_id)
    rescue => ex
      puts ex
      puts tweet
    end
    sleep 1
  end
  puts "Done: https://twitter.com/KrauseFx/timelines/634365663847546884"
end

task :default => [:beta]
