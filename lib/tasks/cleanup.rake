# ## A task to cleanup the database by removing old articles.
task :cleanup => :environment do
  puts "cleaning up the database"
  
  # We find articles published more than two months ago.
  articles = Article.all.where( "published_at <= ?", 2.month.ago )
  puts "delating #{articles.size} articles"
  
  # For each article ...
  articles.each do |article|
    
    # ... we destroy it.
    article.destroy!
  end
end