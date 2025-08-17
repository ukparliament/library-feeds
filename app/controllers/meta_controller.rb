class MetaController < ApplicationController

  def index
    @page_title = 'About this website'
  end

  def cookies
    @page_title = 'Cookies'
    
    render 'library_design/meta/cookies'
  end
end
