require 'net/http'
require 'json'
require 'uri'


task :post_post_to_mastodon => :environment do
  puts "posting POST articles"
  
  # We set up the authentication token.
  bearer_token = ENV['POST_BEARER_TOKEN']
  
  # We find the publisher.
  publisher = Publisher.find_by_name( 'POST' )
  
  # We find all articles not posted to Mastodon.
  articles = Article.where( "publisher_id =?", publisher.id ).where( 'is_posted_to_mastodon IS FALSE' )
  puts "Posting #{articles.size} POST articles to Mastodon"
  
  # For each article ...
  articles.each do |article|
    
    # ... we construct the post text.
    post_text = article.title + ' ' + article.link
    
    # We encode the post text.
    parser = URI::Parser.new
    post_text = parser.escape( post_text )
    
    # We construct the URI.
    uri = URI( "https://mastodon.me.uk/api/v1/statuses?status=#{post_text}" )
    
    # We create the client.
    http = Net::HTTP.new( uri.host, uri.port )
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # We create  the request.
    request =  Net::HTTP::Post.new( uri )
  
    # We add headers to the request.
    request.add_field "Authorization", "Bearer #{bearer_token}"

    # We make the request.
    request = http.request( request )
    
    # If the request is successful ...
    if request.code == '200'

      # ... we record that the article has been posted.
      article.is_posted_to_mastodon = true
      article.save
    end
    
    # We pause for two seconds.
    sleep( 2 )
  end
end