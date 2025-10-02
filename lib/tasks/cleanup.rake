# ## A task to cleanup the database by removing old articles.
task :cleanup => :environment do
  puts "cleaning up the database"
  
  # We find articles imported / created more than two months ago.
  articles = Article.all.where( "created_at <= ?", 2.month.ago )
  
  puts "deleting #{articles.size} articles"
  
  # For each article ...
  articles.each do |article|
    
    # ... we destroy it.
    article.destroy!
  end
end