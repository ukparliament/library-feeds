class PublicationController < ApplicationController

  def index
    @publications = Article.find_by_sql(
      "
        SELECT a.*, p.name AS publisher_name
        FROM articles a, publishers p
        WHERE a.publisher_id = p.id
        ORDER BY a.created_at DESC
      "
    )
    @page_title = 'All publications'
    @description = 'All publications.'
    @rss_url = publication_list_url( :format => 'rss' )
    @crumb << { label: @page_title, url: nil }
    @section = 'publications'
  end
end
