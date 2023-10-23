class HomeController < ApplicationController
  
  def index
    @articles = Article.find_by_sql(
      "
        SELECT a.*, p.name AS publisher_name
        FROM articles a, publishers p
        WHERE a.publisher_id = p.id
        ORDER BY a.published_at DESC
      "
    )
  end
end
