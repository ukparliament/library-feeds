class HomeController < ApplicationController
  
  def index
    @description = 'An application designed to ingest feeds from the Research Service websites and make them available as accounts on both Bluesky and Mastodon.'
  end
end
