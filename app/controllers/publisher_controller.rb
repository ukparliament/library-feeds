class PublisherController < ApplicationController
  
  def index
    @publishers = Publisher.all
    
    @page_title = 'Publishers'
    @description = 'All publishers.'
    @crumb << { label: @page_title, url: nil }
    @section = 'publishers'
  end
  
  def show
    publisher = params[:publisher]
    @publisher = Publisher.find( publisher )
    @publications = @publisher.articles
    
    @page_title = @publisher.name
    @description = "Publications published by #{@publisher.name}."
    @rss_url = publisher_show_url( :format => 'rss' )
    @crumb << { label: 'Publishers', url: publisher_list_url }
    @crumb << { label: @page_title, url: nil }
    @section = 'publishers'
    
    render :template => 'publication/index'
  end
end
