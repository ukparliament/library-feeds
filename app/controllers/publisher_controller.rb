class PublisherController < ApplicationController
  
  def index
    @page_title = 'Publishers'
    @publishers = Publisher.all
  end
  
  def show
    publisher = params[:publisher]
    @publisher = Publisher.find( publisher )
    @page_title = @publisher.name
    @articles = @publisher.articles
  end
end
