class HomeController < ApplicationController
  
  def index
    @articles = Article.all.order( 'published_at desc' )
  end
end
