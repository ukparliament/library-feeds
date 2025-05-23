require 'open-uri'

# ## A task to import briefings and insights from the House of Commons Library.
task :import_commons_articles => :environment do
  puts "importing articles from the commons library feed"
  
  # We find the publisher.
  publisher = Publisher.find_by_name( 'House of Commons' )
  
  # We set the feed URL to import from.
  feed_url = 'https://commonslibrary.parliament.uk/research/all-research/feed/'
  
  # We get the RSS.
  doc = Nokogiri::XML( URI.open( feed_url ) )
  
  # For each item in the RSS ...
  doc.xpath( '//item' ).each do |item|
    
    # ... we store the bits we're interested in.
    article_title = item.xpath( 'title/text()' ).to_s
    article_author = item.xpath( 'dc:creator/text()' ).text
    article_link = item.xpath( 'link/text()' ).to_s
    article_published_at = item.xpath( 'pubDate/text()' ).to_s
    article_guid = item.xpath( 'guid/text()' ).to_s
    
    # We attempt to find the article ...
    article = Article.where( "guid = ?", article_guid ).where( "published_at =?", article_published_at ).first
    
    # Unless we find the article ...
    unless article
      
      # ... we create a new article.
      article = Article.new
      article.title = article_title
      article.author = article_author if article_author
      article.link = article_link
      article.published_at = article_published_at
      article.guid = article_guid
      article.publisher = publisher
      article.save
    end
  end
end