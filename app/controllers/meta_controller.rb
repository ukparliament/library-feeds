class MetaController < ApplicationController

  def index
    @page_title = 'About this website'
    @description = 'About this website.'
  end

  def cookies
    @page_title = 'Cookies'
    @description = 'Cookie policy.'
    
    render 'library_design/meta/cookies'
  end
end
