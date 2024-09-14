require 'net/http'
require 'json'
require 'uri'


task :post_commons_to_bluesky => :environment do
  puts "posting commons articles"
  
  # We set up the authentication keys.
  bluesky_handle = ENV['COMMONS_BLUESKY_HANDLE']
  bluesky_app_password = ENV['COMMONS_BLUESKY_APP_PASSWORD']
  
  # We find the publisher.
  publisher = Publisher.find_by_name( 'House of Commons' )
  
  # We find all Commons articles not posted to Blueky.
  articles = Article.where( "publisher_id =?", publisher.id ).where( 'is_posted_to_bluesky IS FALSE' )
  puts "Posting #{articles.size} Commons articles to Bluesky"
  
  # We attempt to authenticate.
  uri = URI( 'https://bsky.social/xrpc/com.atproto.server.createSession' )
  body = { "identifier": bluesky_handle, "password": bluesky_app_password }
  headers = { 'Content-Type': 'application/json' }
  response = Net::HTTP.post( uri, body.to_json, headers )
  
  # We grab the access tokens from the JSON response.
  access_jwt = JSON.parse( response.body )['accessJwt']
  did = JSON.parse( response.body )['did']
  
  # For each article ...
  articles.each do |article|
    
    # ... we construct the text to post.
    post_text = article.title.sub( ': ', ' - ' ) + ' ' + article.link
    
    # ... we construct the link facets.
    facets = create_facets( post_text )
    
    # We construct the post.
    post = {
        "$type": "app.bsky.feed.post",
        "text": post_text,
        "createdAt": Time.now.iso8601,
        "facets": facets,
    }

    # We construct the body.
    body = {
      "repo": did,
      "collection": "app.bsky.feed.post",
      "record": post,
    }
    
    # We convert the body to JSON.
    body = body.to_json
    
    # We attempt to post.
    uri = URI( 'https://bsky.social/xrpc/com.atproto.repo.createRecord' )
    headers = { 'Content-Type': 'application/json', 'Authorization': "Bearer #{access_jwt}" }
    response = Net::HTTP.post( uri, body, headers )
    
    # If the request is successful ...
    if response.code == '200'
      
      # ... we report success.
      puts 'Posting Commons Library briefing to Bluesky - success'

      # We record that the article has been posted.
      article.is_posted_to_bluesky = true
      article.save
      
    # Otherwise, if the request is not successful ...
    else
      
      # ... we report failure.
      puts 'Posting Commons Library briefing to Bluesky - failure'
    end
    
    # We pause for two seconds.
    sleep( 2 )
  end
end

# ## A method to construct the link facet for Bluesky.
# [ATProtocol documentation](https://atproto.com/blog/create-post#mentions-and-links)
# [Code copied and adapted from GitHub](https://github.com/ShreyanJain9/bskyrb/issues/3)
def create_facets( text )
  
  # We create an array to hold the facets.
  facets = []

  # We define the regex pattern to match a link.
  link_pattern = URI.regexp

  # We find the links.
  text.enum_for( :scan, link_pattern ).each do |m|
    index_start = Regexp.last_match.offset(0).first
    index_end = Regexp.last_match.offset(0).last
    facets.push(
      '$type' => 'app.bsky.richtext.facet',
      'index' => {
        'byteStart' => index_start,
        'byteEnd' => index_end,
      },
      'features' => [
        {
          '$type' => 'app.bsky.richtext.facet#link',
          'uri' => m.join("").strip.sub( 'httpsc', 'https://c' ) # this is the matched link
        },
      ],
    )
  end
  
  # We return the matched facets.
  facets
end